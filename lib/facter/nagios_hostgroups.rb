# Create custom nagios_hostgroups fact for each nagios_hostgroup found.

files = Dir['/etc/nagios/facter/hostgroup_*.conf']

unless files.empty?
  hostgroups = files.map { |filename| filename[%r{_([^\.]+)\.conf$}, 1] }
  Facter.add('nagios_hostgroups') { setcode { hostgroups.join(',') } }
end
