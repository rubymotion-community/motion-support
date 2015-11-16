require "motion-require"

files = [
  "core_ext/numeric/bytes",
  "core_ext/numeric/conversions",
  "core_ext/numeric/time"
].map do |file|
  File.expand_path(
    File.join(File.dirname(__FILE__), "/../../../motion", "#{file}.rb")
  )
end

Motion::Require.all(files)
