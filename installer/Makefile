STAGING = ./staging
HACK = ./hack

## kubectl
KUBECTL ?= kubectl
KUBECONFIG ?= ~/.kube/config

## middleware version
ISTIO_VERSION ?= 1.2.2
ROOK_VERSION ?= 1.0.4
CONCOURSE_VERSION ?= 5.3.0
KEYCLOAK_VERSION ?= 6.0.1
NIC_VERSION ?= 0.25.0
TEKTON_VERSION ?= 0.4.0
WEAVE_VERSION ?= 1.11.3

## component
CMN_COMPONENT = tekton keycloak concourse showks
PRD_COMPONENT = weave rook prometheus istio

## kubectl context
CMN_CONTEXT ?= common
PRD_CONTEXT ?= production

default: usage

## usage
usage:
	$(call yellow, "usage: ")
	@echo "  make install : Install middleware with \"kubectl apply\""
	@echo "  make dry-run : Install middleware with \"kubectl apply --dry-run\""
	@echo "  make clean   : Clean up staging directory"
	@echo "  make prepare : Prepare middlewares to staging directory"

.PHONY: clean
clean:
	$(call yellow, "clean staging directory")
	@rm -Rf $(STAGING)

.PHONY: install
install: prepare apply

.PHONY: dry-run
dry-run: prepare set-dry-run apply

prepare: \
	$(STAGING)/showks \
	$(STAGING)/istio \
	$(STAGING)/rook \
	$(STAGING)/concourse \
	$(STAGING)/keycloak \
	$(STAGING)/nginx-ingress-controller \
	$(STAGING)/tekton \
	$(STAGING)/prometheus \
	$(STAGING)/weave

set-dry-run:
	$(eval DRY_RUN := --dry-run)

apply: apply-cmn apply-prd

apply-cmn:
	$(call green,"[cmn] running apply")

	@echo "---\ncreate showks and showks-system namespace\n---"
	KUBECONFIG=$(KUBECONFIG) $(KUBECTL) apply --context $(CMN_CONTEXT) $(DRY_RUN) -f $(HACK)/manifests/showks-ns.yaml
	@echo "---"

	@for d in $(CMN_COMPONENT); do \
	echo "---\napply $${d}\n---"; \
	KUBECONFIG=$(KUBECONFIG) $(KUBECTL) apply --context $(CMN_CONTEXT) $(DRY_RUN) -f $(STAGING)/$${d}; \
	echo "---"; \
	done
	@echo "apply finished"

apply-prd:
	$(call green,"[prd] running apply")

	@echo "---\ncreate showks and showks-system namespace\n---"
	KUBECONFIG=$(KUBECONFIG) $(KUBECTL) apply --context $(PRD_CONTEXT) $(DRY_RUN) -f $(HACK)/manifests/showks-ns.yaml
	@echo "---"

	@for d in $(PRD_COMPONENT); do \
	echo "---\napply $${d}\n---"; \
	KUBECONFIG=$(KUBECONFIG) $(KUBECTL) apply --context $(PRD_CONTEXT) $(DRY_RUN) -f $(STAGING)/$${d}; \
	echo "---"; \
	done
	@echo "apply finished"

.PHONY: delete
delete: delete-cmn delete-prd

delete-cmn:
	$(call green,"[cmn] running delete")

	@for d in $(CMN_COMPONENT); do \
	echo "---\ndelete $${d}\n---"; \
	KUBECONFIG=$(KUBECONFIG) $(KUBECTL) delete --context $(CMN_CONTEXT) $(DRY_RUN) -f $(STAGING)/$${d}; \
        echo "---"; \
	done

	@echo "delete finished"
	$(call yellow,"WARNING: showks and showks-system namespaces are not deleted.")

delete-prd:
	$(call green,"[prd] running delete")

	@for d in $(PRD_COMPONENT); do \
	echo "---\ndelete $${d}\n---"; \
	KUBECONFIG=$(KUBECONFIG) $(KUBECTL) delete --context $(CMN_CONTEXT) $(DRY_RUN) -f $(STAGING)/$${d}; \
        echo "---"; \
	done

	@echo "delete finished"
	$(call yellow,"WARNING: showks and showks-system namespaces are not deleted.")

## middlewares

$(STAGING)/showks:
	$(call green, "preparing showks component")
	@$(HACK)/showks.sh

$(STAGING)/istio:
	$(call green, "preparing istio $(ISTIO_VERSION)")
	@$(HACK)/istio.sh $(ISTIO_VERSION)

$(STAGING)/rook:
	$(call green, "preparing rook $(ROOK_VERSION)")
	@$(HACK)/rook.sh $(ROOK_VERSION)

$(STAGING)/concourse:
	$(call green, "preparing concourse $(CONCOURSE_VERSION)")
	@$(HACK)/concourse.sh $(CONCOURSE_VERSION)

$(STAGING)/keycloak:
	$(call green, "preparing keycloak $(KEYCLOAK_VERSION)")
	@$(HACK)/keycloak.sh $(KEYCLOAK_VERSION)

$(STAGING)/nginx-ingress-controller:
	$(call green, "preparing nginx-ingress-controller $(NIC_VERSION)")
	@$(HACK)/nginx-ingress-controller.sh $(NIC_VERSION)

$(STAGING)/tekton:
	$(call green, "preparing tekton $(TEKTON_VERSION)")
	@$(HACK)/tekton.sh $(TEKTON_VERSION)

$(STAGING)/prometheus:
	$(call green, "preparing prometheus")
	@$(HACK)/prometheus.sh

$(STAGING)/weave:
	$(call green, "preparing weave scope $(WEAVE_VERSION)")
	@$(HACK)/weave.sh $(WEAVE_VERSION)



## functions

define yellow
      @tput setaf 3
      @echo $1
      @tput sgr0
endef

define green
      @tput setaf 2
      @echo $1
      @tput sgr0
endef

define red
      @tput setaf 1
      @echo $1
      @tput sgr0
endef
