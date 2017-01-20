Exec {
    path    => ["/usr/local/bin/", "/usr/bin", "/bin", "/usr/sbin", "/sbin" ],
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

package { "build-essential": }
package { "zlib1g-dev": }
package { "libssl-dev": }
package { "libreadline-dev": }
package { "libgdbm-dev": }
package { "openssl": }

exec { "ruby : source : configure":
    command => "sh configure",
    cwd     => "/usr/src/ruby-2.4.0",
    creates => "/usr/src/ruby-2.4.0/Makefile",
    require => [
        Exec["ruby : source : unzip"],
        Package["build-essential"],
        Package["zlib1g-dev"],
        Package["libssl-dev"],
        Package["libreadline-dev"],
        Package["libgdbm-dev"],
        Package["openssl"],
    ],
}

exec { "ruby : source : make":
    command => "make",
    cwd     => "/usr/src/ruby-2.4.0",
    creates => "/usr/src/ruby-2.4.0/ruby",
    require => Exec["ruby : source : configure"],
}

exec { "ruby":
    command => "make install",
    cwd     => "/usr/src/ruby-2.4.0",
    creates => "/usr/local/bin/ruby",
    require => Exec["ruby : source : make"],
}

exec { "jekyll":
    command => "gem install jekyll",
    creates => "/usr/local/bin/jekyll",
    require => Exec["ruby"],
}

exec { "bundler":
    command => "gem install bundler",
    creates => "/usr/local/bin/bundler",
    require => Exec["ruby"],
}
