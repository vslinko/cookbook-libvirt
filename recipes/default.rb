%w{ qemu-kvm libvirt-bin }.each do |pkg|
  package pkg
end

service "libvirt-bin"

directory "#{node["libvirt"]["definitions_dir"]}/networks" do
  recursive true
end
