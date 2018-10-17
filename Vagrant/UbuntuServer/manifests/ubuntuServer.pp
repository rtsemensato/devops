exec { "apt-update" :
  command => "/usr/bin/apt-get update"
}

package {["openjdk-8-jre", "tomcat8", "mysql-server"]:
  ensure  => installed,
  require => Exec["apt-update"]
}

service { "tomcat8" :
  ensure     => running,
  enable     => true,
  hasstatus  => true,
  hasrestart => true,
  require    => Package["tomcat8"]
}

service { "mysql" :
  ensure     => running,
  enable     => true,
  hasstatus  => true,
  hasrestart => true,
  require    => Package["mysql-server"]
}

exec { "db-learnjsf" :
  command => "mysqladmin -uroot create learnjsf",
  unless  => "mysql -u root learnjsf",
  path    => "/usr/bin",
  require => Service["mysql"]
}

exec { "mysql-password" :
  command => "mysql -uroot -e \"GRANT ALL PRIVILEGES ON * TO 'learnjsf'@'%' IDENTIFIED BY 'senha10';\" learnjsf",
  unless  => "mysql -ulearnjsf -psenha10 learnjsf",
  path => "/usr/bin",
  require => Exec["db-learnjsf"]
}

file { "/var/lib/tomcat8/webapps/LearnJSF.war" :
  source  => "/vagrant/manifests/LearnJSF.war",
  owner   => "tomcat8",
  group   => "tomcat8",
  mode    => "0644",
  require => Package["tomcat8"],
  notify  => Service["tomcat8"]
}
