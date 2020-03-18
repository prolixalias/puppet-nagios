# Custom nagios_* facts to tweak monitoring defaults.
if FileTest.exists?('/etc/nagios/facter')
  Dir.entries('/etc/nagios/facter/').each do |file|
    next unless file[-5..-1] == '.conf'
    Facter.add('nagios_' + file[0..-6]) do
      setcode { File.read('/etc/nagios/facter/' + file).chomp }
    end
  end
end
