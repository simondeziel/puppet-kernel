#
# Class: modules_load
#
class modules_load (
  String $lookup_key = 'modules_load::conf',
) {
  create_resources(modules_load::conf,lookup($lookup_key))
}
