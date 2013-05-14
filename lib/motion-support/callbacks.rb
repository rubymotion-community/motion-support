require 'motion-require'

files = [
  "_stdlib/array",
  "concern",
  "descendants_tracker",
  "callbacks",
  "core_ext/kernel/singleton_class"
].map { |file| File.expand_path(File.join(File.dirname(__FILE__), "/../../motion", "#{file}.rb")) }

Motion::Require.all(files)
