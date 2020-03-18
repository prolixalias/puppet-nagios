# Create nagios_pci_<modname> facts for these modules, if found
modnames = ['megaraid', 'megaraid_sas', 'mptsas', 'hpsa']

if File.exist?('/proc/bus/pci/devices')
  File.open('/proc/bus/pci/devices') do |io|
    io.each do |line|
      line.chomp!
      # Search for lines ending with tab + module name
      modnames.each do |modname|
        next unless line.end_with? "\t" + modname
        # Create the fact for the found device
        Facter.add('nagios_pci_' + modname) { setcode { true } }
        # Stop looking for it, to avoid useless duplicates
        modnames.delete(modname)
      end
    end
  end
end
