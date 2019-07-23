NAME=mtail
VERSION?=$(shell cat VERSION)
RELEASE?=$(shell cat RELEASE)
TOKEN?="TODO: SET A TOKEN"
PWD=$(shell pwd)
ARCH=linux_amd64
BIN_NAME=$(NAME)_$(VERSION)-$(RELEASE)_$(ARCH)

all: rpm clean

rpm:
	mkdir -p $(PWD)/rpmbuild/SOURCES/
	cp $(NAME).service $(PWD)/rpmbuild/SOURCES/
	cd $(PWD)/rpmbuild/SOURCES && [ -f $(BIN_NAME) ] ||  wget "https://github.com/google/$(NAME)/releases/download/$(VERSION)-$(RELEASE)/$(BIN_NAME)"
	cd $(PWD)/rpmbuild/SOURCES && mv $(BIN_NAME) $(NAME) &&  mkdir -p $(BIN_NAME) && cp $(NAME) $(BIN_NAME)/ && cp $(NAME).service $(BIN_NAME)/ 
	cd $(PWD)/rpmbuild/SOURCES && tar cvfz $(BIN_NAME).tar.gz $(BIN_NAME)
	rpmbuild --define '_rpmfilename $(BIN_NAME).rpm' --define '_topdir $(PWD)/rpmbuild' --define 'version $(VERSION)' --define 'release $(RELEASE)' -ba --clean  $(NAME).spec
	
clean:
	rm -rf rpmbuild/SOURCES/mtail*
