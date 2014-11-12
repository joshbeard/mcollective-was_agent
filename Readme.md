# MCO WebSphere Profile Agent

## Overview

This is an Mcollective agent for interacting with IBM WebSphere profiles.

WebSphere's a behemoth, and querying things seems to take forever.

## Tasks

### profile_list

Returns a list of profiles on a machine.  This is simple - just look for
directories.

### profile_status

Query the status of profile(s) on a system by running the `bin/serverStatus.sh`
script in each profile.  This can take quite a while.

### profile_start

Start a profile on a system by running the `bin/serverStart.sh` script in the
profile.  This can take quite a while.

### profile_stop

Stop a profile on a system by running the `bin/serverStop.sh` script in the
profile.  This can take quite a while.

## Examples

### Module examples

Manage the installation of the agent with default parameters:

```puppet
include mco_was_agent

## or ##

class { 'mco_was_agent': }
```

Ensure the agent is not present:

```puppet
class { 'mco_was_agent':
  ensure => 'absent',
}
```

Pass custom directories to locate WAS profiles.  This will apply to all nodes,
so list any potential directories here.

```puppet
class { 'mco_was_agent':
  profile_dirs = [
    '/opt/ibm/was/something/long/WebSphere85/profiles',
    '/opt/ibm/was/something/long/WebSphere7/profiles',
  ],
}
```

### Agent examples

__Get the list of profiles on a specific system:__

```shell
mco rpc was profile_status -I thenode.example.com
```

__Get the list of profiles on all systems:__

```shell
mco rpc was profile_status
```

Example output:

```
peadmin@puppetmaster:~$ mco rpc was profile_status
Discovering hosts using the mc method for 2 second(s) .... 2

 * [ ============================================================> ] 2 / 2


puppetagent1.vagrant.vm
   Running: ["PROFILE_APP_03", "PROFILE_APP_02", "PROFILE_DMGR_01", "PROFILE_DMGR_03"]
   Stopped: ["PROFILE_APP_04", "PROFILE_APP_01", "PROFILE_DMGR_04", "PROFILE_DMGR_02"]

puppetmaster.vagrant.vm
   Running: ["PROFILE_APP_04", "PROFILE_APP_01", "PROFILE_DMGR_02", "PROFILE_DMGR_04"]
   Stopped: ["PROFILE_APP_03", "PROFILE_APP_02", "PROFILE_DMGR_03", "PROFILE_DMGR_01"]



Finished processing 2 / 2 hosts in 4084.56 ms
```

__Stop a specific profile on a specific system:__

```shell
mco rpc was profile_stop wasprofile=PROFILE_APP_01 -I thenode.example.com
```

## Authors

Josh Beard <[beard@puppetlabs.com](mailto:beard@puppetlabs.com)>
