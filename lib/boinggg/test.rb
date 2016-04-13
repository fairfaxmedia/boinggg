require 'net/http'
require 'pp'

module Boinggg
  class Boinggg::Test
    def initialize(_type,_from,_to, _hostname, _port)
      @from = _from
      @to = _to
      @type = _type
      @hostname = _hostname
      @port = _port
    end

    def run
      Net::HTTP.start(@hostname, @port) do |http|
        request = Net::HTTP::Get.new(URI(@from))
        @lastresponse = http.request(request)
      end
      @laststatus = ( code_ok? && location_ok? ) ? 'OK' : 'FAIL'
    rescue => e
      @laststatus = 'EXCEPTION'
      STDERR.puts e.message
    end

    def last_code
      @lastresponse.code.to_i
    end

    def last_location
      @lastresponse.get_fields('Location').first
    end

    def code_ok?
      last_code == @type.to_i
    end

    def location_ok?
      URI(last_location) == URI(@to)
    end

    def format_log
      onfail = @laststatus == 'FAIL' ? [ "actual", last_code, last_location ] : []
      [ @laststatus, "#{@hostname}:#{@port}", "desired", @type, @from, @to, onfail ].flatten.join(" ")
    end
  end
end

