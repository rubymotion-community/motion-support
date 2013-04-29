files = [
  'core_ext/integer/multiple',
  'core_ext/integer/inflections',
  'core_ext/integer/time'
].map { |file| File.expand_path(File.join(File.dirname(__FILE__), "/../../../motion", "#{file}.rb")) }

Motion::Require.all(files)
