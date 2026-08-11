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


