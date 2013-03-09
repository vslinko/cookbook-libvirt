actions :define, :undefine, :autostart, :start, :destroy, :redefine
default_action [:define, :autostart, :start]

attribute :name,       :kind_of => String, :name_attribute => true
attribute :bridge,     :kind_of => String, :default => "virbr0"
attribute :domain,     :kind_of => String, :default => nil
attribute :forward,    :kind_of => String, :default => "nat"
attribute :dns_hosts,  :kind_of => Array,  :default => nil
attribute :ip_address, :kind_of => String, :default => "192.168.122.1"
attribute :netmask,    :kind_of => String, :default => "255.255.255.0"
attribute :dhcp_range, :kind_of => Array,  :default => ["192.168.122.2", "192.168.122.254"]
attribute :dhcp_hosts, :kind_of => Array,  :default => nil
