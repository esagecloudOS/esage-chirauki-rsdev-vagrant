# Abiquo RS with Vagrant

This Vagrantfile has the necessary configuration to create an Abiquo RS server installation using Chef solo provisioner.

The necessary cookbooks and roles are in the `cookbooks` and `roles` folders respectively.

Additionally, a few env vars are recognised so you can modify behaviours without editing the Vagrantfile.

## Env vars

| Var name       | Desc                                                    | Default                           |
|----------------|---------------------------------------------------------|-----------------------------------|
| ABQ_VERSION    | The Abiquo version to use                               | `master                           |
| ABQ_SERVER     | The Abiquo server address, either name or IP is valid   | `localhost`                       |
| ABQ_FULLVIRT   | The `abiquo.virtualfactory.kvm.fullVirt` property value | true                              |
| ABQ_WATCHTOWER | The `abiquo.monitoring.enabled` property value          | false                             |
| ABQ_MONITORING | The Abiquo Watchtower host address to use               | `localhost`                       |
| ABQ_NEW_RPM    | Wether or not to use the new RPMs                       | true                              |
| ABQ_NFS        | The NFS url for the VM repository                       | `10.60.1.104:/volume1/nfs-devel`  |
| ABQ_SMB        | The SMB url for the Hyper-V VM repository               | `//10.60.1.104/volume1/nfs-devel` |

## Usage

In order to setup a local RS server using Virtualbox just run:

```
$ vagrant up rs-c7-$ABQ_VERSION
```

Note the Abiquo version to use is part of the VM name, so the VM names will change if you override the Abiquo version using env vars. To check on the actual VM names type:

```
$ vagrant status
Current machine states:

rs-c6-master              not created (virtualbox)
rs-c7-master              not created (virtualbox)

This environment represents multiple VMs. The VMs are all listed
above with their current state. For more information about a specific
VM, run `vagrant status NAME`.
```
