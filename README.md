# argo-apps-template

A template repository for managing platform applications using [ArgoCD](https://argo-cd.readthedocs.io/) and Helm. This repository provides a starting point for organizing, deploying, and managing multiple applications and namespaces in a Kubernetes cluster using GitOps principles.

## Features

- **ArgoCD Application Management:** Declarative configuration for managing applications via ArgoCD.
- **Helm Chart Structure:** Organize applications using Helm charts for modularity and reusability.
- **Namespace Setup:** Predefined manifests for essential namespaces (e.g., `argocd`, `monitoring`).
- **Extensible Directory Layout:** Easily add new applications and environments.

## Repository Structure
```
├── apps.yaml # ArgoCD Application manifest
├── apps/
│ ├── Chart.yaml # Helm chart definition for apps 
│ └── templates/ 
│ ├── kafka/ # Placeholder for Kafka-related manifests 
│ └── monitoring/ # Placeholder for Monitoring-related manifests 
├── setup/
│ ├── argocd.yaml # Namespace manifest for ArgoCD
│ └── monitoring.yaml # Namespace manifest for Monitoring
├── scripts/ # Directory for utility scripts
├── examples/ # Directory for example manifests
├── docs/ # Directory for documentation
├── Makefile # Makefile for common tasks
├── LICENSE # License file (MIT)
├── .gitattributes # Git attributes configuration
├── .gitignore # Git ignore rules
└── README.md # This documentation
```

# Getting Started

### Prerequisites

- [kubectl](https://kubernetes.io/docs/tasks/tools/)
- [Helm](https://helm.sh/)
- [ArgoCD](https://argo-cd.readthedocs.io/)

### Setup Namespaces

Apply the required namespaces for ArgoCD and Monitoring:

```sh
make setup
```

This runs: `kubectl apply -f setup/`

## Customization
* Add new applications by creating subdirectories under templates and adding the relevant Kubernetes manifests.
* Update Chart.yaml as needed to reflect new chart dependencies or metadata.
* Modify apps.yaml to change the ArgoCD Application configuration (e.g., target namespace, project).

## License
This project is licensed under the MIT License.
