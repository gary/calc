# frozen_string_literal: true

require 'calc/version'

# :nodoc:
module Calc
  # Generic exception that all program-generated exceptions inherit from
  Error = Class.new(StandardError)
end
