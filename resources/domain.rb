actions :define, :undefine, :autostart, :start, :destroy
default_action [:define, :autostart]

attribute :name,     :kind_of => String,  :name_attribute => true
attribute :type,     :kind_of => String,  :default => "kvm"
attribute :os_type,  :kind_of => String,  :default => "hvm"
attribute :memory,   :kind_of => Integer, :default => 1048576
attribute :disks,    :kind_of => Array
attribute :iso,      :kind_of => String,  :default => nil
attribute :network,  :kind_of => String,  :default => "default"
attribute :mac,      :kind_of => String,  :default => nil
attribute :vnc_port, :kind_of => Integer, :default => 5900
