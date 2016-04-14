require 'yaml'
require 'pp'

module Boinggg
  class Boinggg::Config
    def initialize(filename, host, port = 80)
      @yaml = YAML.load_file(filename)
      @tests = []
      generate_simple_tests(host,port)
    end

    def generate_simple_tests(_hostname, _port)
      if @yaml.include?('simple')
        # flatten here because YAML array merging is a bit weird
        @yaml['simple'].flatten.each.map do |test|
          args = test.chomp.split(/\s+/)
          @tests.push(Boinggg::Test.new(args[0], args[1], args[2], _hostname, _port))
        end
      end
    end

    def run
      @tests.each do |test|
        test.run
        puts test.format_log
      end
    end
  end
end
