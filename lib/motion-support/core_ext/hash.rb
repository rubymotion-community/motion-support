require 'motion-require'

files = [
  'core_ext/ns_dictionary',
  'core_ext/hash/deep_merge',
  'core_ext/hash/except',
  'core_ext/hash/indifferent_access',
  'core_ext/hash/keys',
  'core_ext/hash/reverse_merge',
  'core_ext/hash/slice',
  'hash_with_indifferent_access',
  
  'core_ext/module/delegation'
].map { |file| File.expand_path(File.join(File.dirname(__FILE__), "/../../../motion", "#{file}.rb")) }

Motion::Require.all(files)
