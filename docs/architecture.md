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