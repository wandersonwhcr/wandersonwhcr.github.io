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
