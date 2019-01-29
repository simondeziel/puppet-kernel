#
# Class: kernel
#
class kernel (
  Array[String] $package_names                = $kernel::params::package_names,
  Enum['installed','latest'] $package_ensure  = $kernel::params::package_ensure,
) inherits kernel::params {
  package { $package_names:
    ensure => $package_ensure,
  }
}
