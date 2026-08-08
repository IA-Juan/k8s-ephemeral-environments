# Kubernetes Ephemeral Environments

A reusable framework to create and destroy isolated ephemeral environments on Kubernetes using Helm.

This project demonstrates how to provision a complete application environment on demand:

- Node.js web application
- PostgreSQL database
- Persistent storage
- Kubernetes Ingress
- Namespace isolation
- Environment-specific configuration

The goal is to provide a simple and repeatable mechanism to create temporary environments for development, testing and demonstrations.

---

# Architecture Overview
                     Internet

                        |

                NGINX Ingress

                        |

                Kubernetes Service

                        |

             Node.js Web Deployment

                        |

             PostgreSQL Service

                        |

          PostgreSQL StatefulSet

                        |

                PersistentVolumeClaim

                        |

                PersistentVolume

                
---

# Main Concepts

## Ephemeral Environment

Each environment is isolated using a dedicated Kubernetes namespace.

Example:
demo-123


creates:


namespace/demo-123


with its own:

- Application
- Database
- Storage
- Network resources

---

# Technology Stack

| Component | Technology |
|---|---|
| Container Platform | Kubernetes |
| Package Manager | Helm 3 |
| Application | Node.js |
| Framework | Express |
| Database | PostgreSQL |
| Storage | Kubernetes Persistent Volumes |
| Ingress | NGINX |

---

# Repository Structure


apps/
demo-web/
Application source code

charts/
edc-environment/
Kubernetes Helm Chart

environments/
Environment definitions

scripts/
Automation scripts

docs/
Project documentation


---

# Deployment Workflow

Create an environment:

```bash
./scripts/deploy.sh demo-123

The script will:

Create namespace
Build application image
Deploy Helm release
Install PostgreSQL
Configure networking
Verify application readiness

Remove Environment
./scripts/destroy.sh demo-123

The complete environment will be removed.

Design Principles

This project follows:

Infrastructure as Code
Immutable containers
Configuration externalization
Stateless application design
Reusable Helm charts
Environment isolation
Project Status

Current phase:

Architecture and foundation

Roadmap:

 Repository structure
 Node.js application
 Docker image
 Helm chart
 PostgreSQL integration
 Persistent storage
 Ingress
 Deployment automation
 CI/CD pipeline
License

MIT


---

# Paso 2 — `.gitignore`

Abrí:

```text
.gitignore

Contenido:

# Node

node_modules/
npm-debug.log

# Environment variables

.env
.env.*

# Logs

*.log
logs/

# Coverage

coverage/

# IDE

.vscode/
.idea/

# OS

.DS_Store
Thumbs.db

# Kubernetes packages

*.tgz

# Temporary

tmp/
temp/
Paso 3 — Makefile

Abrí:

Makefile

Contenido:

.PHONY: help build deploy destroy lint clean

help:
	@echo "Available commands:"
	@echo ""
	@echo "make build   - Build application image"
	@echo "make deploy  - Deploy Kubernetes environment"
	@echo "make destroy - Remove Kubernetes environment"
	@echo "make lint    - Validate Helm chart"
	@echo "make clean   - Clean temporary files"


build:
	./scripts/build.sh


deploy:
	./scripts/deploy.sh


destroy:
	./scripts/destroy.sh


lint:
	helm lint charts/edc-environment


clean:
	rm -rf tmp/
Paso 4 — environments

Abrí:

environments/demo-123.yaml

Poné:

environment:
  name: demo-123

namespace:
  name: demo-123

ingress:
  host: demo-123.localtest.me

database:
  name: demo123

Abrí:

environments/demo-456.yaml

Poné:

environment:
  name: demo-456

namespace:
  name: demo-456

ingress:
  host: demo-456.localtest.me

database:
  name: demo456
Paso 5 — Documentación

Ahora completamos los documentos.

docs/architecture.md
# Architecture

## Goal

Provide a reusable mechanism to create isolated Kubernetes environments.

## Components

### Application

A stateless Node.js web service deployed using Kubernetes Deployment.

### Database

PostgreSQL deployed as StatefulSet with persistent storage.

### Storage

Each environment owns its own PersistentVolumeClaim.

### Networking

Each application is exposed using Kubernetes Ingress.

## Isolation

Each environment is deployed into a dedicated namespace.
docs/architecture-decisions.md
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
docs/deployment.md
# Deployment

Deployment lifecycle:


Environment Definition

    |

Helm Values Generation

    |

Namespace Creation

    |

Application Deployment

    |

Database Deployment

    |

Ingress Exposure

    |

Health Verification

