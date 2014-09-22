module ZipTax
  class Response < OpenStruct

    def success?
      self.rCode && self.rCode == 100
    end

    def self.new_from_http_request(response_hsh)
      #NOTE: xml is not supported by this gem right now
      # it is supported in the API
      hsh = JSON.parse(response_hsh)
      resp = ZipTax::Response.new(hsh)
      resp.results = hsh['results'].collect { |result| ZipTax::Result.new(result) }
      resp
    end
  end
end
