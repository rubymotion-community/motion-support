require "motion-require"

files = [
  "core_ext/class/attribute",
  "core_ext/class/attribute_accessors"
].map do |file|
  File.expand_path(
    File.join(File.dirname(__FILE__), "/../../../motion", "#{file}.rb")
  )
end

Motion::Require.all(files)
