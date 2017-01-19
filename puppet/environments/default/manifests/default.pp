Exec {
    path    => ["/usr/bin", "/bin", "/usr/sbin", "/sbin" ],
    timeout => 0,
}

Package {
    require => Exec["apt-get : update"],
    before  => Exec["apt-get : autoremove"],
}

exec { "apt-get : update":
    command => "apt-get update",
}

exec { "apt-get : upgrade":
    command => "apt-get upgrade -q -y",
    require => Exec["apt-get : update"],
}

exec { "apt-get : autoremove":
    command => "apt-get autoremove -q -y",
    require => Exec["apt-get : upgrade"],
}

package { "vim":
    name => "vim",
}

package { "git":
    name => "git",
}

package { "unzip":
    name => "unzip",
}

package { "exim4":
    name   => "exim4-base",
    ensure => "purged",
}

package { "nano":
    name   => "nano",
    ensure => "purged",
}

package { "rpcbind":
    name   => "rpcbind",
    ensure => "purged",
}

exec { "php : key":
    unless  => "apt-key list | grep dotdeb",
    command => "curl http://www.dotdeb.org/dotdeb.gpg | apt-key add -",
}

file { "php : list":
    path    => "/etc/apt/sources.list.d/php.list",
    content => "deb http://packages.dotdeb.org jessie all",
    require => Exec["php : key"],
    before  => Exec["apt-get : update"],
}

package { "php : cli":
    name    => "php-cli",
    require => [
        File["php : list"],
        Exec["apt-get : update"],
    ],
}

exec { "composer":
    creates => "/usr/bin/composer",
    command => "curl https://getcomposer.org/composer.phar -o /usr/bin/composer && chmod +x /usr/bin/composer",
}

exec { "composer : update":
    command     => "composer self-update",
    environment => "COMPOSER_HOME=/root/.composer",
    require     => [
        Package["php : cli"],
        Exec["composer"],
    ],
}
