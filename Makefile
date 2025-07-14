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

argocd-admin-password:
	@echo "Retrieving ArgoCD admin password..."
	kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d

argocd-apply:
	@echo "Applying ArgoCD applications..."
	kubectl apply -f apps.yaml
