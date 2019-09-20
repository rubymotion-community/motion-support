require_relative 'core_ext_files'
Motion::Project::App.setup do |app|
  app.files.unshift(MotionSupport.integer_files)
end
