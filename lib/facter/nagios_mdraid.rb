if FileTest.exists?('/proc/mdstat')
  txt = File.read('/proc/mdstat')
  if txt =~ %r{^md}i
    Facter.add('nagios_mdraid') { setcode { true } }
  end
end
