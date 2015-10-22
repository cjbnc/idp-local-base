IDPHOST := idp-local-base
IMAGE   := ncsuoit/$(IDPHOST)

all: help

help:
	@echo "  Make Commands:"
	@echo "    latest       - build $(IMAGE):latest"
	@echo "    status       - list images"
	@echo "    cleanall     - remove images"
	@echo

latest: Dockerfile
	docker build -t $(IMAGE):latest .

cleanall: 
	for id in `docker images | grep $(IMAGE) | awk '{ print $$3 }' | sort | uniq`; do \
	  docker rmi $$id; \
	done

status:
	@echo "  Images:"
	@docker images $(IMAGE)

