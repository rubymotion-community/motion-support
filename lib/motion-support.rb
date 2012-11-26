require "motion-support/version"
require 'bubble-wrap'
Dir.glob(File.join(File.dirname(__FILE__), 'motion-support/*.rb')).each do |file|
  BW.require file
end
