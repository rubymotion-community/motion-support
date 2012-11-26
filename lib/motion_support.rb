require "motion_support/version"
require 'bubble-wrap'
Dir.glob(File.join(File.dirname(__FILE__), 'motion_support/*.rb')).each do |file|
  BW.require file
end
