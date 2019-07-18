NAME="mtail"
VERSION?=$(shell cat VERSION)
ARCH="linux_amd64""
TOKEN?="TODO: SET A TOKEN"
PWD=$(shell pwd)

all: rpm clean

rpm:
	mkdir -p "$(PWD)/rpmbuild/SOURCES/"
	cd "$(PWD)/rpmbuild/SOURCES" && wget https://github.com/google/$(NAME)/releases/download/$(VERSION)/$(NAME)_$(VERSION)_$(ARCH)
	cd "$(PWD)/rpmbuild/SOURCES" && mv $(NAME)_$(VERSION)_$(ARCH) $(NAME) 
	rpmbuild --define '_rpmfilename $(NAME)-$(VERSION)-$(ARCH).rpm' --define "version $(VERSION)" --define '_topdir $(PWD)/rpmbuild' -ba --clean  $(NAME).spec
	
clean:

