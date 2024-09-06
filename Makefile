NAME = quay.io/yshestakov/openldap
VERSION = latest
ARGS:=--build-arg LDAP_OPENLDAP_GID=911 --build-arg LDAP_OPENLDAP_UID=911

.PHONY: build build-nocache test tag-latest push push-latest release git-tag-version

build:
	podman build -t $(NAME):$(VERSION) $(ARGS) --rm image 

build-nocache:
	podman build -t $(NAME):$(VERSION) $(ARGS) --no-cache --rm image

tag:
	podman tag $(NAME):$(VERSION) $(NAME):$(VERSION)

tag-latest:
	podman tag $(NAME):$(VERSION) $(NAME):latest

push:
	podman push $(NAME):$(VERSION)

push-latest:
	podman push $(NAME):latest

release: build test tag-latest push push-latest

git-tag-version: release
	git tag -a v$(VERSION) -m "v$(VERSION)"
	git push origin v$(VERSION)
