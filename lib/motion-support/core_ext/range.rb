require 'motion-require'

files = [
  'core_ext/range/include_range',
  'core_ext/range/overlaps'
].map { |file| File.expand_path(File.join(File.dirname(__FILE__), "/../../../motion", "#{file}.rb")) }

Motion::Require.all(files)
