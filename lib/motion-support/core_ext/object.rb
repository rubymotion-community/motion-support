require "motion-require"

files = [
  "_stdlib/cgi",
  "core_ext/object/acts_like",
  "core_ext/object/blank",
  "core_ext/object/deep_dup",
  "core_ext/object/duplicable",
  "core_ext/object/try",
  "core_ext/object/instance_variables",
  "core_ext/object/to_param",
  "core_ext/object/to_query"
].map do |file|
  File.expand_path(
    File.join(File.dirname(__FILE__), "/../../../motion", "#{file}.rb")
  )
end

Motion::Require.all(files)
