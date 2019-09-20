require_relative 'motion_support_files'
Motion::Project::App.setup do |app|
  app.files.unshift(MotionSupport.callbacks_files)
end
