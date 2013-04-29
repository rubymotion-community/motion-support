require 'motion-require'

files = [
  '_stdlib/date',
  '_stdlib/time',
  'core_ext/time/acts_like',
  'core_ext/time/calculations',
  'core_ext/time/conversions',
  'core_ext/date/acts_like',
  'core_ext/date/calculations',
  'core_ext/date/conversions',
  'core_ext/date_and_time/calculations',
  'core_ext/integer/time',
  'core_ext/numeric/time',
  'core_ext/object/acts_like',
  'duration'
].map { |file| File.expand_path(File.join(File.dirname(__FILE__), "/../../../motion", "#{file}.rb")) }

Motion::Require.all(files)
