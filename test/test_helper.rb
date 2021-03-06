$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'ninetynine_snakes'
require 'gosu'

require 'minitest/autorun'
require 'custom_assertions/string_assertions'

include NinetynineSnakes

require "minitest/reporters"
Minitest::Reporters.use!    [Minitest::Reporters::SpecReporter.new]