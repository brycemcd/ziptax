require 'spec_helper'

describe ZipTax::SalesTax do
  let(:fake_response) {
    <<-STR
    {
      "version": "v20",
      "rCode": 100,
      "results": [
        {
        "geoPostalCode": "10801",
        "geoCity": "NEW ROCHELLE",
        "geoCounty": "WESTCHESTER",
        "geoState": "NY",
        "taxSales": 0.083750002086163,
        "taxUse": 0.083750002086163,
        "txbService": "L",
        "txbFreight": "Y",
        "stateSalesTax": 0.03999999910593,
        "stateUseTax": 0.03999999910593,
        "citySalesTax": 0.03999999910593,
        "cityUseTax": 0.03999999910593,
        "cityTaxCode": "NE 6861",
        "countySalesTax": 0,
        "countyUseTax": 0,
        "countyTaxCode": "WE 5581",
        "districtSalesTax": 0.003749999916181,
        "districtUseTax": 0.003749999916181
        }
       ]
      }
    STR
  }

  let(:generic_request) {
    ZipTax.api_key = 'abc123'
    ZipTax::SalesTax.new(postalcode: '00124')
  }

  describe "must set api key" do
    it "sets an api key via class attribute" do
      expect(ZipTax.api_key).to be_falsey
      ZipTax.api_key = 'abc123'
      expect(ZipTax.api_key).to_not be_nil
    end
  end

  describe "#new" do
    it "errors if postal code are not set" do
     expect {
       ZipTax::SalesTax.new
     }.to raise_exception(ArgumentError, /postalcode/i)
    end

    it "errors if api_key is not set" do
      expect(ZipTax).to receive(:api_key).and_return(nil)
      expect {
        ZipTax::SalesTax.new(postalcode: '10023')
      }.to raise_exception(ArgumentError, /api_key/i)
    end

    it "sets all possible parameters to the api" do
      rq = ZipTax::SalesTax.new(postalcode: '000123',
                                state: 'NY',
                                city: 'New York'
                               )
      expect(rq).to be_kind_of ZipTax::SalesTax
      [:postalcode, :state, :city].each do |attr|
        expect(rq.send(attr.to_sym)).to_not be_nil
      end
    end
  end

  describe "#request_tax" do
    context "success" do
      it "returns a json response" do
        expect(Net::HTTP).to receive(:get).and_return(fake_response)
        resp = generic_request.request_tax
        expect(resp).to be_kind_of ZipTax::Response
      end
    end
  end

  describe "#request_url" do
    it "includes the keys/values included as get params on the base url" do
      expect(generic_request.request_url).to eql("#{ZipTax::SalesTax::BASE_URL}?postalcode=00124&state&city&format=json&key=abc123")
    end
  end

  describe ".request_for" do
    it "calls the API endpoing in one method call" do
      expect(Net::HTTP).to receive(:get).and_return(fake_response)
      rq = ZipTax::SalesTax.request_for(postalcode: '00123')
      expect(rq).to be_kind_of ZipTax::Response
    end
  end
end
