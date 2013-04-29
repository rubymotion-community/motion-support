require 'motion-require'

Motion::Require.all(Dir.glob(File.expand_path('../../motion/**/*.rb', __FILE__)))

at_exit { puts "\nWARNING: Automatic dependency detection does not work with motion-support. Turn it off in your Rakefile:\n\n  app.detect_dependencies = false\n\n" if Motion::Project::App.config.detect_dependencies }
