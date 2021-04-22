#
# ansible-elastic-baremetal
#

.PHONY: lint # Test YAML syntax
lint:
	@ansible-lint -x ANSIBLE0012 .

.PHONY: test # Test the playbook using vagrant
test: lint
	@vagrant up

.PHONY: destroy # Destroy vagrant boxes
destroy:
	@vagrant destroy -f

.PHONY: help # This help message
help:
	@grep '^.PHONY: .* #' Makefile \
		| sed 's/\.PHONY: \(.*\) # \(.*\)/\1\t\2/' \
		| expand -t20 \
		| sort
