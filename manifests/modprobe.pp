#
class kernel::modprobe (
  Hash $configs,
  Hash $blacklist_configs,
) {
  create_resources('kernel::modprobe::conf',$configs)
  create_resources('kernel::modprobe::blacklist',$blacklist_configs)
}
