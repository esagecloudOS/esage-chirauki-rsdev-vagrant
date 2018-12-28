name "remoteservices"
description "Installs the Abiquo Remote Services using the latest nightly builds"
run_list "recipe[abiquo]", "recipe[abiquo::install_v2v]", "recipe[abiquo::setup_v2v]"
default_attributes({
  "abiquo" => {
    "profile" => "remoteservices",
    "tomcat" => {
      "wait-for-webapps" => true
    },
    "properties" => {
      "abiquo.monitoring.enabled" => false,
      "abiquo.dvs.vcenter.user" => "root",
      "abiquo.dvs.vcenter.password" => "vmware",
      "abiquo.kairosdb.port" => 8080,
      "abiquo.watchtower.port" => 36638
    }
  }
})