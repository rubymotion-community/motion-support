require 'core_ext_files'
Motion::Project::App.setup do |app|
  app.files.unshift(MotionSupport.string_files)
end
