#!/usr/bin/env rake
$:.unshift("/Library/RubyMotion/lib")
$:.unshift("~/.rubymotion/rubymotion-templates")

require 'motion/project/template/ios'
require "bundler/gem_tasks"
require "bundler/setup"
Bundler.require

require 'motion-support'

Motion::Project::App.setup do |app|
  # Use `rake config' to see complete project settings.
  app.name = 'MotionSupport'
end
