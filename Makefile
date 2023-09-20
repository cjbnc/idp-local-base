IDPHOST := idp50-local-base
IMAGE   := ncsuoit/$(IDPHOST)
HELPER  := ./dhelper.pl
DATE    := $(shell date +'%y%m%d%H%M')
CDATE   := $(shell $(HELPER) stamp $(IMAGE):latest)

ifdef REBUILD
  BLDFLAG := --no-cache
else
  BLDFLAG :=
endif

all: help

help:
	@echo "  Make Commands:"
	@echo "    status       - list images"
	@echo "    latest       - build $(IMAGE):bld$(DATE) and tag as latest"
	@echo "       REBUILD=y - add to latest to force rebuild current sources"
	@echo "    tagsave      - save $(IMAGE):latest to registry"
	@echo "    tagload      - restore $(IMAGE):latest from registry"
	@echo "    cleanall     - remove images"
	@echo "    runshell     - run bash on $(IMAGE):latest image"
	@echo

latest: Dockerfile
	(cd downloads; make all)
	docker build $(BLDFLAG) -t $(IMAGE):bld$(DATE) .
	docker tag $(IMAGE):bld$(DATE) $(IMAGE):latest

cleanall: 
	for id in `docker images | grep $(IMAGE) | awk '{ print $$3 }' | sort | uniq`; do \
	  docker rmi -f $$id; \
	done

status:
	@echo "  Images:"
	@docker images $(IMAGE)

tagsave: latest
	$(HELPER) -l save $(IMAGE):latest

tagload:
	$(HELPER) -l load $(IMAGE):latest

runshell:
	docker run -it --rm -p 443:443 -v /tmp:/tmp $(IMAGE):latest /bin/bash

