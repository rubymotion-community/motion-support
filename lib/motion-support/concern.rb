require "motion-require"

files = [
  "concern"
].map { |file| File.expand_path(File.join(File.dirname(__FILE__), "/../../motion", "#{file}.rb")) }

Motion::Require.all(files)
