require 'motion_support_files'
Motion::Project::App.setup do |app|
  app.files.unshift(MotionSupport.inflector_files)
end
