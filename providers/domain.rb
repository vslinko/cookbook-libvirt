action :define do
  definition_xml = "#{node["libvirt"]["definitions_dir"]}/#{new_resource.name}.xml"

  template definition_xml do
    source "domain.xml.erb"
    cookbook "libvirt"
    variables :new_resource => new_resource
  end

  execute "virsh define #{definition_xml}" do
    not_if "virsh domstate #{new_resource.name}"
  end
end

action :undefine do
  execute "virsh undefine #{new_resource.name}" do
    only_if "virsh domstate #{new_resource.name}"
  end

  file "#{node["libvirt"]["definitions_dir"]}/#{new_resource.name}.xml" do
    action :delete
  end
end

action :autostart do
  execute "virsh autostart #{new_resource.name}" do
    only_if "sudo virsh dominfo #{new_resource.name} | grep Autostart | grep disable"
  end
end

action :start do
  execute "virsh start #{new_resource.name}" do
    only_if "virsh domstate #{new_resource.name} | grep 'shut off'"
  end
end

action :destroy do
  execute "virsh destroy #{new_resource.name}" do
    only_if "virsh domstate #{new_resource.name} | grep running"
  end
end
