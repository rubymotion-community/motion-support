unless defined?(Motion::Project::Config)
  raise "This file must be required within a RubyMotion project Rakefile."
end

require 'motion-support/motion_support_files'
Motion::Project::App.setup do |app|
  app.files.unshift(MotionSupport.requires)
end
