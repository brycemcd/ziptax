require 'rack/utils'
require 'ostruct'
require 'json'

module ZipTax
  class Response < OpenStruct
  end

  class Result < OpenStruct
  end

  class SalesTax
    attr_reader :key, :postal_code, :state, :city, :format

    BASE_URL="http://api.zip-tax.com/request/v20"

    def initialize(key: nil,
                   postal_code: nil,
                   state: nil,
                   city: nil,
                   format: 'json')

      fail ArgumentError, "postal_code and key (api key) are required arguments" if !key || !postal_code
      @key = key
      @postal_code = postal_code.to_s
      @state = state
      @city = city
      @format = format
    end

    def request_url
      query = {key: @key, postal_code: @postal_code, state: @state, city: @city, format: @format}
      "#{BASE_URL}?#{Rack::Utils.build_query(query)}"
    end

    def request_tax
      url = URI(request_url)
      resp = Net::HTTP.get(url)
      process_response(resp)
      
    end

    def self.request_for(key: nil,
                         postal_code: nil,
                         state: nil,
                         city: nil,
                         format: 'json')
      self.new(key: key,
               postal_code: postal_code,
               state: state,
               city: city,
               format: format)
    end

    private

    def process_response(resp)
      hsh = JSON.parse(resp.body)
      resp = ZipTax::Response.new(hsh)
      resp.results = hsh['results'].collect { |result| ZipTax::Result.new(result) }
      resp
    end
  end
end
