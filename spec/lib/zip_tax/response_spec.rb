require 'spec_helper'

describe ZipTax::Response do
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
  describe '.new_from_http_request' do
    context "on success" do
      let(:resp) { ZipTax::Response.new_from_http_request(fake_response) }
      it "creates a new Response object" do
        expect(resp).to be_kind_of ZipTax::Response
      end

      it "creates result objects" do
        expect(resp.results).to be_kind_of Array
        expect(resp.results.first).to be_kind_of ZipTax::Result
      end
    end
  end

  describe "#success?" do
    it "is true if rCode == 100" do
      expect(ZipTax::Response.new({rCode: 100}).success?).to be_truthy
    end

    it "is false if rCode != 100" do
      expect(ZipTax::Response.new({rCode: 101}).success?).to be_falsey
    end

    it "is false if no rCode" do
      expect(ZipTax::Response.new({notrCode: 101}).success?).to be_falsey
    end
  end
end
