require 'net/http'
require 'differ'
require 'colorize'

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
      @laststatus = 'EXCEPTION' if @lastresponse.code.to_i > 499
    rescue => e
      @laststatus = 'EXCEPTION'
      STDERR.puts e.message
    end

    def last_code
      @lastresponse.code.to_i
    end

    def last_location
      @lastresponse.get_fields('Location').first
    rescue => e
      ""
    end

    def request_exception?
      @laststatus == 'EXCEPTION'
    end

    def code_ok?
      last_code == @type.to_i
    end

    def location_ok?
      URI(last_location) == URI(@to)
    end

    def format_log(colour = false)
      [
        @laststatus,
        "#{@hostname}:#{@port}",
        "desired",
        @type,
        @from,
        "actual",
        last_code.to_s.colorize(code_ok? ? :green : :red),
        request_exception? ? "" : Differ.diff_by_word(@to,last_location).format_as(:color),
      ].join(" ")
    end
  end
end

