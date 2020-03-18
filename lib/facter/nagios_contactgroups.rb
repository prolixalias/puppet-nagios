# Create custom nagios_contactgroups fact for each nagios_contactgroup found.

files = Dir['/etc/nagios/facter/contactgroup_*.conf']

unless files.empty?
  contactgroups = files.map { |filename| filename[%r{_([^\.]+)\.conf$}, 1] }
  Facter.add('nagios_contactgroups') do
    setcode do
      contactgroups.join(',')
    end
  end
end
