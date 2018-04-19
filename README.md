# Puppet modules-load

Manages /etc/modules and /etc/modules-load.d/*.conf files.

## Requirements
* Modern distro with /etc/modules-load.d directory unless you only
  want to manage /etc/modules.

## Usage

To make net.netfilter.nf_conntrack_tcp_loose=0 work, 2 modules are needed which can be
loaded on boot with:

```puppet
  modules_load::conf { 'nf-conntrack':
    modules => [
                 '# needed to have net.netfilter.nf_conntrack_tcp_loose',
                 'nf_conntrack_ipv4',
                 'nf_conntrack_ipv6',
               ],
  }
```

The above would generate the file /etc/modules-load.d/nf-conntrack.conf with the content:

```
# File managed by Puppet

# needed to have net.netfilter.nf_conntrack_tcp_loose
nf_conntrack_ipv4
nf_conntrack_ipv6
```

To ensure /etc/modules only contains the default comment:

```puppet
  # the "modules" name is handled in a special way
  modules_load::conf { 'modules':
    modules => [
                 '# /etc/modules: kernel modules to load at boot time.',
                 '#',
                 '# This file contains the names of kernel modules that should be loaded',
                 '# at boot time, one per line. Lines beginning with "#" are ignored.',
                 '',
               ],
  }

```

Which would result in /etc/modules containing:

```
# File managed by Puppet

# /etc/modules: kernel modules to load at boot time.
#
# This file contains the names of kernel modules that should be loaded
# at boot time, one per line. Lines beginning with "#" are ignored.

```

It is also useful to combine hiera data:

```
# data/common.yaml
lookup_options:
  modules_load::conf:
    merge:
      strategy: deep
      knockout_prefix: '--'

modules_load::conf:
  modules:
    modules:
      - '# /etc/modules: kernel modules to load at boot time.'
      - '#'
      - '# This file contains the names of kernel modules that should be loaded'
      - '# at boot time, one per line. Lines beginning with "#" are ignored.'
      - ''

# data/nodes/router.example.com.yaml
modules_load::conf:
  he:
    modules:
      - '# for HE tunnel'
      - sit
```

with create_resources:

```puppet
node 'router.example.com' {
  # ...

  # load some modules on boot
  create_resources(modules_load::conf,lookup('modules_load::conf'))
}

node 'foobar.example.com' {
  # ...

  # load some modules on boot
  create_resources(modules_load::conf,lookup('modules_load::conf'))
}
```

which would result in **foobar** and **router** having a clean /etc/modules. **router** would
also have the "sit" module loaded to support the Hurricane Electric tunnel.
