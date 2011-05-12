#!/usr/bin/ruby

host = `hostname`.chomp

if host.index('.')
  hostname = host.split(".")[0].slice(0..13)
else
  hostname = host.slice(0..13)
end
host_hex = hostname.unpack("c*").map { |e|"0x#{e.to_s(16)}" }
system "/usr/bin/ipmitool raw 0x6 0x58 194 0"
system "/usr/bin/ipmitool raw 0x6 0x58 193 0 0 #{host_hex.length} #{host_hex.join(' ')}"
