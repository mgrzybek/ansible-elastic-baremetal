ansible-elastic-baremetal
=========================

This role is used to install Elasticsearch on bare metal nodes, ie. with a lot 
of threads and memory.
Each node hosts several Podman-based Elasticsearch Systemd services.

Requirements
------------

Each node should provide the same mountpoint paths. Moreover the services cannot 
use more than 50% of the RAM.

Role Variables
--------------

```yaml
aeb_container_image: "docker.io/elasticsearch:6.8.15"

aeb_config_consul: false # Add elasticsearch services to consul
aeb_consul_services_path: /etc/consul.d

aeb_cluster_name:
aeb_initial_masters: [] # The Elasticsearch master nodes must be up reachable

aeb_cpuset_number_per_jvm: 0
aeb_jvm_xmx_gb: 0 # This value must be at least 1 GB
aeb_rpc_starting_port: 9300
aeb_http_starting_port: 9400
aeb_storage_paths: [] # The paths must exist
aeb_publish_host: # If empty, the default ipv4 address is used
aeb_service_name_prefix: els # Must be the same than the master nodes

# Documentation: https://www.elastic.co/guide/en/elasticsearch/reference/current/modules-node.html
aeb_node_roles: [ "data" ] 
```

Dependencies
------------

See `requirements.yml`.

Example Playbook
----------------

Deploy 5 Elasticsearch services per node with 2 CPUs and 32 GB per JVM.

```yaml
- hosts: servers
  roles:
  - role: ansible-elastic-baremetal
  vars:
    # CPU / RAM limits
    aeb_cpuset_number_per_jvm: 2
    aeb_jvm_xmx_gb: 32

    # Ports
    aeb_rpc_starting_port: 9300
    aeb_http_starting_port: 9400

    # Storage paths
    aeb_storage_paths:
    - /srv/els-data-0
    - /srv/els-data-1
    - /srv/els-data-2
    - /srv/els-data-3
    - /srv/els-data-4
```

Testing
-------

This role provides a `Vagrantfile` and a `Makefile`.

```bash
# Makefile-provided commands
$ make help
help                This help message
lint                Test YAML syntax
vagrant-destroy     Destroy vagrant boxes
vagrant-variables   Test vagrant env variables
vagrant-vbox        Test the playbook using vagrant and virtualbox
# Mandatory variables
$ export VAGRANT_BOX_NAME="my-box"
# Optionnal variables
$ export VAGRANT_BOX_URL="http://repo/my-box.box"
$ export VAGRANT_VM_CPUS=5
$ export VAGRANT_VM_MEMORY=5120
# Vagrant using Virtualbox
$ make vagrant-vbox
$ make vagrant-destroy
```

License
-------

GPL-3+

Author Information
------------------

Mathieu GRZYBEK

