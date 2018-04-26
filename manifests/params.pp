# @api private
# This class handles kernel params. Avoid modifying private classes.
class kernel::params {
  if ($::operatingsystem != 'Ubuntu') {
    fail("${module_name} does not support ${::operatingsystem}")
  }

  if $is_virtual {
    $package_names = ['linux-image-virtual']
  } else {
    $package_names = ['linux-image-generic']
  }
  $package_ensure = 'installed'
}
