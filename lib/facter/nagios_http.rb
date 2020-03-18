# Create custom nagios_httpd_<exename> facts for each daemon found
# + create a main nagios_httpd fact if one or more is present

binaries = [
  '/usr/sbin/httpd',
  '/usr/sbin/nginx',
  '/usr/sbin/lighttpd',
]

mainfact = false
binaries.each do |filename|
  next unless FileTest.exists?(filename)
  mainfact = true
  # Create a specific nagios_httpd_<exename> fact
  Facter.add('nagios_httpd_' + filename[/[^\/]+$/]) { setcode { true } }
end
if mainfact == true
  Facter.add('nagios_httpd') { setcode { true } }
end
