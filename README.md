# ic-gitops-central

For now `infrastructure' directory is well organized.
Others requires polishing.

## Repository structure

```
├── apps
│   └── base                            # common apps for all cluster
│       └── capacitor                   # sample app
├── clusters                            # clusters configuration - includes artifacts to use for the deployment
│   └── dev
│       ├── artifacts.yaml
│       ├── capacitor.yaml
│       └── infrastructure.yaml
└── infrastructure                      # infastructure tools
    └── base
    │   └──files.yaml                   # infrastrucutre tools for all clusters, not loaded automatically, they need to referred also in infrastructure/clusters/<ENV>/
    └── clusters                        # configuration of deployments for clusters
        └── dev
        └── <SOME>
```

## Adding an application to infrastructure stack

For now we're considering adding a new **infrastructure** stack application on the dev cluster.

1. If application requires a new namespace add a k8s namespace manifest in `clusters/base/namespaces` directory, file content example:

  ```yaml
  ---
  apiVersion: v1
  kind: Namespace
  metadata:
    name: ingress-nginx
  ```

2. Add another sync-infastructure-<MY_APP>.yaml in `infrastructure/base` directory, similar to following one (considering that application definition and deployments are in separate GitHub project):

  ```yaml
  ---
  apiVersion: source.toolkit.fluxcd.io/v1
  kind: GitRepository
  metadata:
  name: ic-ingress-stack
  namespace: flux-system
  spec:
  interval: 5m0s
  url: https://github.com/Infra-Coders/ic-ingress-stack.git
  ref:
      branch: wm-proper-approach
  ---
  apiVersion: kustomize.toolkit.fluxcd.io/v1
  kind: Kustomization
  metadata:
  name: ic-ingress-stack
  namespace: flux-system
  spec:
  interval: 5m
  sourceRef:
      kind: GitRepository
      name: ic-ingress-stack
  prune: true
  ```

2. Reference this file to the *resources* list in `infrastructure/base/kustomization.yaml`.
3. If there's a patch needed, make a patch file in `clusters/dev/` directory.
4. For structure of GitRepository configured for new infastructure app - see [ic-ingress-stack](https://github.com/Infra-Coders/ic-ingress-stack).
