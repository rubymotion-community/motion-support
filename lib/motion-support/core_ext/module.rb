files = [
  'core_ext/module/aliasing',
  'core_ext/module/introspection',
  'core_ext/module/anonymous',
  'core_ext/module/reachable',
  'core_ext/module/attribute_accessors',
  'core_ext/module/attr_internal',
  'core_ext/module/delegation',
  'core_ext/module/remove_method'
].map { |file| File.expand_path(File.join(File.dirname(__FILE__), "/../../../motion", "#{file}.rb")) }

Motion::Require.all(files)
