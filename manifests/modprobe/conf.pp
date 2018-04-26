#
# Define: kernel::modprobe::conf
#
# Deploy modprobe config snippets in /etc/modprobe.d/
#
# Simple usage:
# kernel::modprobe::conf { 'no-conntrack-helper':
#  content => "# File managed by Puppet\noptions nf_conntrack nf_conntrack_helper=0\n",
# }
#
#
define kernel::modprobe::conf (
  Enum['present','absent'] $ensure = 'present',
  Optional[String] $content        = undef,
  Optional[String] $source         = undef,
) {
  file { "/etc/modprobe.d/${name}.conf":
    ensure  => $ensure,
    content => $content,
    source  => $source,
  }
}
