require "motion-support/version"
require "motion-require"

Motion::Require.all(Dir.glob(File.expand_path('../motion-support/**/*.rb', __FILE__)))
