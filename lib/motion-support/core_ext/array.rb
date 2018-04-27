require 'core_ext_files'
Motion::Project::App.setup do |app|
  app.files.unshift(MotionSupport.array_files)
end
