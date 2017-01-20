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

exec { "ruby : source : wget":
    command => "wget https://cache.ruby-lang.org/pub/ruby/2.4/ruby-2.4.0.tar.gz -O ruby-2.4.0.tar.gz",
    cwd     => "/usr/src",
    creates => "/usr/src/ruby-2.4.0.tar.gz",
}

exec { "ruby : source : unzip":
    command => "tar xvzf ruby-2.4.0.tar.gz",
    cwd     => "/usr/src",
    creates => "/usr/src/ruby-2.4.0",
    require => Exec["ruby : source : wget"],
}
