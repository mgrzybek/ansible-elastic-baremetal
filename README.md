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

A description of the settable variables for this role should go here, including 
any variables that are in defaults/main.yml, vars/main.yml, and any variables 
that can/should be set via parameters to the role. Any variables that are read 
from other roles and/or the global scope (ie. hostvars, group vars, etc.) 
should be mentioned here as well.

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
    aeb_cpuset_number_per_jvm: 2
    aeb_jvm_xmx_gb: 32
    aeb_rpc_starting_port: 9300
    aeb_http_starting_port: 9400
    aeb_storage_paths:
    - /srv/els-data-0
    - /srv/els-data-1
    - /srv/els-data-2
    - /srv/els-data-3
    - /srv/els-data-4
```

License
-------

GPL-3+

Author Information
------------------

Mathieu GRZYBEK

