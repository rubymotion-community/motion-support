require 'motion-require'

files = [
  "inflector/inflections",
  "inflector/methods",
  "inflections",
  "core_ext/string/inflections",
  
  "core_ext/array/prepend_and_append"
].map { |file| File.expand_path(File.join(File.dirname(__FILE__), "/../../motion", "#{file}.rb")) }

Motion::Require.all(files)
