NAMESPACE ?= argocd
.PHONY: setup-helm setup-argocd helm-repo-display helm-chart-display helmfile-apply argocd-port-forward argocd-admin-password argocd-apply

update-context:
	@echo "Setting Kubernetes context to '$(NAMESPACE)' namespace..."
	kubectl config set-context --current --namespace=$(NAMESPACE)

setup-argocd:
	kubectl apply -f setup/

helm-repo-display:
	@echo "Available Helm repositories:"
	helm repo list

helm-chart-display:
	@echo "Available Helm charts in the '$(REPOSITORY)' repository:"
	helm search repo $(REPOSITORY)

helmfile-apply:
	@echo "Applying Helmfile configuration..."
	helmfile apply

argocd-port-forward:
	@echo "Port forwarding ArgoCD server..."
	kubectl port-forward svc/argocd-server -n argocd 8080:443

grafana-port-forward:
	@echo "Port forwarding Grafana server..."
	kubectl port-forward svc/grafana -n monitoring 3000:80

argocd-admin-password:
	@echo "Retrieving ArgoCD admin password..."
	kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d

alloy-port-forward:
	@echo "Port forwarding Alloy server..."
	kubectl port-forward svc/alloy -n monitoring 12345:12345

loki-port-forward:
	@echo "Port forwarding Loki server..."
	kubectl port-forward svc/loki -n monitoring 3100:3100

argocd-apply:
	@echo "Applying ArgoCD applications..."
	kubectl apply -f apps.yaml

namespace-hosts:
	@echo "Listing services in the '$(NAMESPACE)' namespace:"
	kubectl get svc -n $(NAMESPACE) -o jsonpath='{range .items[*]}{.metadata.name}.monitoring.svc.cluster.local{"\n"}{end}'

helm-repo-search:
	@echo "Searching for Helm charts in the '$(REPOSITORY)' repository..."
	helm search repo $(REPOSITORY)