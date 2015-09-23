# -*- encoding: utf-8 -*-
require File.expand_path('../motion/version', __FILE__)

Gem::Specification.new do |spec|
  spec.name        = "motion_blender-support"
  spec.version     = MotionSupport::VERSION
  spec.authors     = ['kayhide', "Thomas Kadauke"]
  spec.email       = ['kayhide@gmail.com', "thomaspec.kadauke@googlemail.com"]
  spec.homepage    = "https://github.com/kayhide/motion_blender-support"
  spec.summary     = "Commonly useful extensions to the standard library for RubyMotion"
  spec.description = "Commonly useful extensions to the standard library for RubyMotion. Ported from ActiveSupport."

  spec.files         = `git ls-files`.split($\)
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "motion_blender"
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'pry'
  spec.add_development_dependency 'pry-doc'
end
