require 'thor'
require "boinggg/version"
require "boinggg/config"
require "boinggg/test"

module Boinggg
  class Boinggg::CLI < Thor
    desc 'run_tests TESTSUITE HOST [PORT]',
      'run all the tests in TESTSUITE file against webserver HOST[:PORT]'
    def run_tests(testsuite, host, port = 80)
      config = Boinggg::Config.new(testsuite, host, port)
      config.run
    end
  end
end
