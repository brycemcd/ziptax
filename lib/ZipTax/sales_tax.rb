require 'rack/utils'
require 'ostruct'
require 'json'

module ZipTax
  class Result < OpenStruct
  end

  class SalesTax
    attr_reader :key, :postalcode, :state, :city, :format

    BASE_URL="http://api.zip-tax.com/request/v20"

    def initialize(key: nil,
                   postalcode: nil,
                   state: nil,
                   city: nil)

      fail ArgumentError, "postalcode and key (api key) are required arguments" if !key || !postalcode
      @key = key
      @postalcode = postalcode.to_s
      @state = state
      @city = city
      @format = 'json'
    end

    def request_url
      query = {key: @key, postalcode: @postalcode, state: @state, city: @city, format: @format}
      "#{BASE_URL}?#{Rack::Utils.build_query(query)}"
    end

    def request_tax
      url = URI(request_url)
      resp = Net::HTTP.get(url)
      ZipTax::Response.new_from_http_request(resp)
    end

    def self.request_for(key: nil, postalcode: nil, state: nil, city: nil)

      rt = self.new(key: key, postalcode: postalcode, state: state, city: city)
      rt.request_tax
    end
  end
end
