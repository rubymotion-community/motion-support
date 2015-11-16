require "motion-require"

files = [
  "core_ext/ns_string",
  "core_ext/string/access",
  "core_ext/string/behavior",
  "core_ext/string/exclude",
  "core_ext/string/filters",
  "core_ext/string/indent",
  "core_ext/string/starts_ends_with",
  "core_ext/string/inflections",
  "core_ext/string/strip",

  "core_ext/module/delegation"
].map { |file| File.expand_path(File.join(File.dirname(__FILE__), "/../../../motion", "#{file}.rb")) }

Motion::Require.all(files)
