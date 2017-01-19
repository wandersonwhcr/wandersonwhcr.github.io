Vagrant.configure(2) do |config|
    config.vm.box = "puppetlabs/debian-8.2-32-puppet"

    config.vm.network 'forwarded_port', guest: 8000, host: 8000

    config.vm.provision 'puppet' do |puppet|
        puppet.options          = '--verbose --debug'
        puppet.environment      = 'default'
        puppet.environment_path = 'puppet/environments'
    end
end
