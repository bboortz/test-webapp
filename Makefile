
help:                     ## printing out the help
	@echo
	@echo test-webapp Makefile
	@echo
	@echo --- TARGETS ---
	@fgrep -h "##" $(MAKEFILE_LIST) | fgrep -v fgrep | sed -e 's/\\$$//' | sed -e 's/##//'


install:                  ## install all requirements
	./scripts/install.sh

build:                    ## build a docker container with the application
	./scripts/build.sh

run:                      ## run the application
	./scripts/run.sh

test:                     ## run the test cases
	./scripts/test.sh
