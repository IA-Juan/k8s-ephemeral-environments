# Architecture Decision Records

## ADR-001 Namespace per Environment

Decision:

Each environment receives its own Kubernetes namespace.

Reason:

- Isolation
- Simple cleanup
- Independent lifecycle


## ADR-002 Deployment for Web Application

Decision:

The web application runs as Kubernetes Deployment.

Reason:

The application is stateless and horizontally scalable.


## ADR-003 StatefulSet for PostgreSQL

Decision:

PostgreSQL runs as StatefulSet.

Reason:

Database workloads require stable identity and persistent storage.


## ADR-004 Helm as Packaging Layer

Decision:

All Kubernetes resources are managed through Helm.

Reason:

Provides reusable and parameterized deployments.


## ADR-005 Configuration Externalization

Decision:

Environment configuration is stored separately from application code.

Reason:

The same image can run in multiple environments.