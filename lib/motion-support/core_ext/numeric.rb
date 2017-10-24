require 'motion-require'

files = [
  'duration',
  'core_ext/numeric/bytes',
  'core_ext/numeric/conversions',
  'core_ext/numeric/time'
].map { |file| File.expand_path(File.join(File.dirname(__FILE__), "/../../../motion", "#{file}.rb")) }

Motion::Require.all(files)
