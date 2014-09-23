require 'rack/utils'
require 'ostruct'
require 'json'

module ZipTax
  class SalesTax
    attr_reader :key, :postalcode, :state, :city, :format

    BASE_URL="http://api.zip-tax.com/request/v20"

    def initialize(postalcode: nil,
                   state: nil,
                   city: nil)

      fail ArgumentError, 'ZipTax.api_key must be set' if ZipTax.api_key.nil?
      fail ArgumentError, "postalcode is a required argument" if !postalcode
      @key = key
      @postalcode = postalcode.to_s
      @state = state
      @city = city
      @format = 'json'
    end

    def request_url
      query = {postalcode: @postalcode, state: @state, city: @city, format: @format}
      query.merge!(key: ZipTax.api_key)
      "#{BASE_URL}?#{Rack::Utils.build_query(query)}"
    end

    def request_tax
      url = URI(request_url)
      resp = Net::HTTP.get(url)
      ZipTax::Response.new_from_http_request(resp)
    end

    def self.request_for(postalcode: nil, state: nil, city: nil)

      rt = self.new(postalcode: postalcode, state: state, city: city)
      rt.request_tax
    end

  end
end
