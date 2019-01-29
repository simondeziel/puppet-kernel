#
# Class: kernel::update_initramfs
#
class kernel::update_initramfs {
  exec { 'update-initramfs':
    command     => '/usr/sbin/update-initramfs -uk all',
    refreshonly => true,
  }
}
