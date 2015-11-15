#!/usr/bin/env rake
$:.unshift("/Library/RubyMotion/lib")
require "motion/project/template/ios"
require "bundler/gem_tasks"
Bundler.setup
Bundler.require

require "motion-support"

Motion::Project::App.setup do |app|
  # Use `rake config` to see complete project settings.
  app.name = "MotionSupport"
  app.detect_dependencies = false
end
