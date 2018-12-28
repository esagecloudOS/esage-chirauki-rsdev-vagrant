VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.synced_folder ".", "/vagrant", type: "rsync"

  server_address = ENV['ABQ_SERVER'] || 'localhost'
  fullvirt = ENV['ABQ_FULLVIRT'] || true
  monitoring = ENV['ABQ_MONITORING'] || false
  watchtowerhost = ENV['ABQ_WATCHTOWER'] || 'localhost'

  abq_version = ENV['ABQ_VERSION'] || "master"
  new_rpms = ENV['ABQ_NEW_RPM'] || true
  nfs_repo = ENV['ABQ_NFS'] || '10.60.1.104:/volume1/nfs-devel'
  smb_repo = ENV['ABQ_SMB'] || '//10.60.1.104/volume1/nfs-devel'
  base_repo = 'http://mirror.abiquo.com/el$releasever/3.10/os/x86_64'
  updates_repo = new_rpms ? "http://10.60.20.42/#{abq_version}/pkgs/el$releasever" : "http://10.60.20.42/#{abq_version}/rpm"

  rs_json_attrs = {
    "mariadb" => {
      "mysqld" => {
        "bind_address" => "0.0.0.0"
      }
    },
    "abiquo" => {
      "profile" => "remoteservices",
      "nfs" => {
        "location" => nfs_repo
      },
      "db": {
        "enable-master" => true,
        "user" => "abiquo",
        "password" => "abiquo",
        "from" => "%"
      },
      "yum" => {
        "base-repo" => base_repo,
        "updates-repo" => updates_repo,
        "gpg-check" => false
      },
      "properties" => {
        "abiquo.datacenter.id" => "rs-c7-#{abq_version}",
        "abiquo.server.api.location" => "https://#{server_address}/api",
        "abiquo.rabbitmq.host" => server_address,
        "abiquo.virtualfactory.kvm.fullVirt" => fullvirt,
        "abiquo.monitoring.enabled" => monitoring,
        "abiquo.kairosdb.host" => watchtowerhost,
        "abiquo.watchtower.host" => watchtowerhost,
        "abiquo.esxi.datastoreRdm" => "datastore1",
        "am.conversions.skip" => true,
        "abiquo.docker.registry" => "http://ucs-blade-1.bcn.abiquo.com:5001",
        "abiquo.appliancemanager.repositoryLocation" => nfs_repo,
        "abiquo.virtualfactory.hyperv.repositoryLocation" => smb_repo,
        "abiquo.virtualfactory.xenserver.repositoryLocation" => nfs_repo,
        "abiquo.virtualfactory.vmware.repositoryLocation" => nfs_repo
      }
    }
  }

  config.vm.define "rs-c6-#{abq_version}" do |t|
    t.vm.hostname = "rs-c6-#{abq_version}"

    t.vm.box = "bento/centos-6.8"

    t.vm.provision "chef_solo" do |chef|
      chef.roles_path = 'roles'
      chef.add_role "remoteservices"

      chef.json = rs_json_attrs
    end
  end

  config.vm.define "rs-c7-#{abq_version}" do |t|
    t.vm.hostname = "rs-c7-#{abq_version}"

    t.vm.box = "bento/centos-7.3"

    t.vm.provision "chef_solo" do |chef|
      chef.roles_path = 'roles'
      chef.add_role "remoteservices"

      chef.json = rs_json_attrs
    end
  end

  config.vm.provider :virtualbox do |v, override|
    v.memory = 2048
    v.cpus = 2
    override.vm.network :public_network
  end
  
  config.vm.provider :abiquo do |provider, override|
    override.vm.box = 'abiquo'
    override.vm.box_url = "https://github.com/abiquo/vagrant_abiquo/raw/master/box/abiquo.box"
    override.vm.hostname = 'abiquotesting'

    provider.abiquo_connection_data = {
      abiquo_api_url: 'https://chirauki40.bcn.abiquo.com/api',
      abiquo_username: 'admin',
      abiquo_password: 'xabiquo',
      connection_options: {
        ssl: {
          verify: false
        }
      }
    }
    provider.cpu_cores = 2
    provider.ram_mb = 2048
    provider.virtualdatacenter = 'ESX_VDC'
    provider.virtualappliance = 'Vagrant Tests'
    provider.template = 'Centos 7 x86_64'

    provider.network = {
      'private_dnsmasq' => nil
    }
    override.ssh.private_key_path = '~/.ssh/id_rsa'
    override.ssh.username = 'centos'
  end
end
