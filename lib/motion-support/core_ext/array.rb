files = [
  'core_ext/array',
  'core_ext/array/wrap',
  'core_ext/array/access',
  'core_ext/array/conversions',
  'core_ext/array/extract_options',
  'core_ext/array/grouping',
  'core_ext/array/prepend_and_append'
].map { |file| File.expand_path(File.join(File.dirname(__FILE__), "/../../../motion", "#{file}.rb")) }

Motion::Require.all(files)
