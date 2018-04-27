#
# Define: kernel::modules_load::conf
#
define kernel::modules_load::conf (
  Array[String] $modules,
  Enum['present','absent'] $ensure = 'present',
) {
  # /etc/modules is special
  if $name == 'modules' {
    $real_file = '/etc/modules'
    if $ensure == 'absent' {
      fail('Refusing to remove /etc/modules')
    }
  } else {
    if versioncmp($::lsbdistrelease,'16.04') < 0 {
      fail('It is only possible to load modules by adding them to /etc/modules, please set name to "modules"')
    }
    $real_file = "/etc/modules-load.d/${name}.conf"
  }

  file { $real_file:
    ensure  => $ensure,
    content => "# File managed by Puppet\n\n${join($modules,"\n")}\n",
  }
}
