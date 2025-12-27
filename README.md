# ic-gitops-central

## Bootstrap Kubernetes Cluster (Flux Operator + CRDs)

1. Point to the target cluster:
    ```
    export KUBECONFIG=~/.kube/aws-k8s
    ```
2. Install the Flux Operator (creates `flux-system` namespace):
    ```
    podman_helm install flux-operator oci://ghcr.io/controlplaneio-fluxcd/charts/flux-operator --namespace flux-system --create-namespace
    ```
3. Apply the FluxInstance that syncs this repo/branch/path:
    ```
    podman_kubectl apply -f infrastructure/fluxinstance/fluxinstance.yaml
    ```
4. Watch controllers come up and initial sync:
    ```
    podman_kubectl -n flux-system get fluxinstances flux -w
    podman_kubectl -n flux-system get deployments
    podman_kubectl -n flux-system get kustomizations
    ```

## Demo application

- Flux also applies a minimal nginx example at `./apps/demo-nginx`.
- Quick check:
  - `podman_kubectl -n demo get pods`
  - `podman_kubectl -n demo port-forward svc/demo-nginx 8080:80` then `curl http://localhost:8080`.

## Metrics Server

- The cluster includes a metrics-server HelmRelease in `./infrastructure/metrics-server` (namespace `kube-system`).
- Verify after bootstrap:
  - `podman_kubectl -n kube-system get deploy metrics-server`
  - `podman_kubectl top nodes` / `podman_kubectl top pods -A`
