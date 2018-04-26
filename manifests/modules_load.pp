#
class kernel::modules_load (
  Hash $configs,
) {
  create_resources('kernel::modules_load::conf',$configs)
}
