#!/bin/bash
set -e

# Recibe el nombre del entorno (ej: demo-123)
ENV_NAME=${1:-demo-123}
POSTGRES_POD="${ENV_NAME}-postgres-0"

echo "== Obteniendo la lista de Pods en el namespace: ${ENV_NAME} =="
# Obtenemos solo los nombres de los pods vivos en formato de lista
PODS_LIST=$(kubectl get pods -n "${ENV_NAME}" -o jsonpath='{.items[*].metadata.name}')

echo "== Inicializando la tabla de auditoría en PostgreSQL =="
# 1. Aseguramos que la tabla exista
kubectl exec -i "${POSTGRES_POD}" -n "${ENV_NAME}" -- psql -U postgres -d postgres <<EOF
CREATE TABLE IF NOT EXISTS "${ENV_NAME}_audit" (
    id SERIAL PRIMARY KEY,
    environment_name VARCHAR(50) NOT NULL,
    kubernetes_namespace VARCHAR(50) NOT NULL,
    kubernetes_pod VARCHAR(100) NOT NULL,
    fecha_hora TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
EOF

echo "== Insertando registros de cada Pod encontrado =="
# 2. Iteramos sobre cada pod de la lista y lo insertamos de forma individual
for POD in ${PODS_LIST}; do
    echo "Registrando Pod: ${POD}"
    kubectl exec -i "${POSTGRES_POD}" -n "${ENV_NAME}" -- psql -U postgres -d postgres <<EOF
    INSERT INTO "${ENV_NAME}_audit" (environment_name, kubernetes_namespace, kubernetes_pod)
    VALUES ('${ENV_NAME}', '${ENV_NAME}', '${POD}');
EOF
done

echo ""
echo "== Estado final de la tabla de auditoría =="
kubectl exec -i "${POSTGRES_POD}" -n "${ENV_NAME}" -- psql -U postgres -d postgres -c "SELECT * FROM \"${ENV_NAME}_audit\";"

