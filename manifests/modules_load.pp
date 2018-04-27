#
class kernel::modules_load (
  Hash $configs,
) {
  if versioncmp($::lsbdistrelease,'16.04') < 0 {
    create_resources('kernel::modules_load::conf', {'modules' => $configs['modules']})
  } else {
    create_resources('kernel::modules_load::conf',$configs)
  }
}
