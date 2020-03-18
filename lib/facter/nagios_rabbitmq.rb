# Create custom nagios_rabbitmq fact
if FileTest.exists?('/sbin/rabbitmq-server')
  Facter.add('nagios_rabbitmq') { setcode { true } }
end

if Facter::Core::Execution.which('rabbitmqctl')
  rabbitmq_nodename = Facter::Core::Execution.execute('rabbitmqctl status 2>&1')
  Facter.add(:nagios_rabbitmq_nodename) do
    setcode do
      %r{^Status of node '?([\w\.]+@[\w\.\-]+)'? \.+$}.match(rabbitmq_nodename)[1]
    end end
  rabbitmq_vhosts = Facter::Core::Execution.execute('rabbitmqctl list_vhosts 2>&1').gsub(%r{^Listing vhosts \.\.\.$\n}, '').split(%r{\n})
  Facter.add('nagios_rabbitmq_vhosts') { setcode { rabbitmq_vhosts } }
end
