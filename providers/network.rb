action :define do
  definition_xml = "#{node["libvirt"]["definitions_dir"]}/networks/#{new_resource.name}.xml"

  template definition_xml do
    source "network.xml.erb"
    cookbook "libvirt"
    variables :new_resource => new_resource
  end

  execute "virsh net-define #{definition_xml}" do
    not_if "virsh net-info #{new_resource.name}"
  end
end

action :undefine do
  execute "virsh net-undefine #{new_resource.name}" do
    only_if "virsh net-info #{new_resource.name}"
  end

  file "#{node["libvirt"]["definitions_dir"]}/networks/#{new_resource.name}.xml" do
    action :delete
  end
end

action :autostart do
  execute "virsh net-autostart #{new_resource.name}" do
    only_if "virsh net-info #{new_resource.name} | grep Autostart | grep no"
  end
end

action :start do
  execute "virsh net-start #{new_resource.name}" do
    only_if "virsh net-info #{new_resource.name} | grep Active | grep no"
  end
end

action :destroy do
  execute "virsh net-destroy #{new_resource.name}" do
    only_if "virsh net-info #{new_resource.name} | grep Active | grep yes"
  end
end

action :redefine do
  definition_xml = "#{node["libvirt"]["definitions_dir"]}/networks/#{new_resource.name}_redefine.xml"

  uuid = `virsh net-uuid #{new_resource.name}`.strip

  template definition_xml do
    source "network.xml.erb"
    cookbook "libvirt"
    variables :new_resource => new_resource, :uuid => uuid
    notifies :run, "execute[redefine_network_#{new_resource.name}]", :immediately
  end

  execute "redefine_network_#{new_resource.name}" do
    command <<-EOS
      virsh net-define #{definition_xml}
      killall -s SIGHUP dnsmasq
    EOS
    action :nothing
  end
end
