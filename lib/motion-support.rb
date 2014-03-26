require 'motion-require'

Motion::Require.all(Dir.glob(File.expand_path('../../motion/**/*.rb', __FILE__)))
