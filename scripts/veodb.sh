
#!/bin/bash
set -e

ENV_NAME=${1:-demo-123}
POSTGRES_POD="${ENV_NAME}-postgres-0"
echo "== Estado final de la tabla de auditoría =="
kubectl exec -i "${POSTGRES_POD}" -n "${ENV_NAME}" -- psql -U postgres -d postgres -c "SELECT * FROM \"${ENV_NAME}_audit\";"
