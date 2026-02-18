# ic-gitops-central
InfraCoders Central GitOps Repository

Infrastructure and platform components managed using GitOps principles.

This repository serves as an entry point and documentation hub for the project.  
Individual components are maintained in separate repositories and versioned independently.

---

## 📦 Components

| Component   | Version | Description |
|-------------|---------|-------------|
| aws-stack   | [v0.0.3](https://github.com/Infra-Coders/ic-aws-stack/releases/tag/v0.0.3)| Base AWS infrastructure stack |
| ingress     | [v0.0.1](https://github.com/Infra-Coders/ic-ingress-stack/releases/tag/v0.0.1)  | Ingress configuration and routing foundation |
| cert-manager| [v0.0.1](https://github.com/Infra-Coders/ic-cert-manager-stack/releases/tag/v0.0.1)  | Cert Manager |

---

## 🧩 Architecture Overview

- Components are split into **separate repositories**
- Each component follows **independent versioning**
- Designed to support **GitOps workflows**
- Ready for further Kubernetes / Cloud-native integrations

---

## Flux bootstrap

Prereqs:

- `kubectl`
- `helm`
- Access to your target cluster (current `kubectl` context)

Install Flux Operator and configure sync:

```bash
FLUX_SYNC_REF="refs/heads/<your-branch>" \
FLUX_SYNC_PATH="clusters/<env>/<cluster>" \
./bootstrap/INSTALL_FLUX.sh
```

