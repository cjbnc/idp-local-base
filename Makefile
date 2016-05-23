IDPHOST := idp-local-base
IMAGE   := ncsuoit/$(IDPHOST)
DATE    := $(shell date +'%y%m%d%H%M')

all: help

help:
	@echo "  Make Commands:"
	@echo "    latest       - build $(IMAGE):latest"
	@echo "    status       - list images"
	@echo "    cleanall     - remove images"
	@echo

latest: Dockerfile
	(cd downloads; make all)
	docker build -t $(IMAGE):bld$(DATE) .
	docker tag -f $(IMAGE):bld$(DATE) $(IMAGE):latest

cleanall: 
	for id in `docker images | grep $(IMAGE) | awk '{ print $$3 }' | sort | uniq`; do \
	  docker rmi -f $$id; \
	done

status:
	@echo "  Images:"
	@docker images $(IMAGE)

