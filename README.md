# ZipTax

Zip-Tax.com provides a very simple API for querying sales and use tax
rates in most zip codes in the United States. This gem provides a thin
wrapper around the API to quickly and easily retrieve sales tax rates by
zip code.

[Official documentation for the API](http://docs.zip-tax.com/en/latest/index.html) is hosted by Zip-Tax.

You will need an API key to get started (sadly, no free developer accounts exist)

## Installation

Add this line to your application's Gemfile:

    gem 'ziptax'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install ziptax

## Usage

Try it out in irb:

```bash
gem install ziptax
irb -r ziptax
```
```ruby
ZipTax::SalesTax.request_for(key: '<yourkeyhere>', postalcode: '10003')
# => {
  "version": "v20",
  "rCode": 100,
  "results": [
    {
      "geoPostalCode": "10003",
      "geoCity": "NEW YORK CITY",
      "geoCounty": "NEW YORK",
      "geoState": "NY",
      "taxSales": 0.088749997317791,
      "taxUse": 0.088749997317791,
      "txbService": "L",
      "txbFreight": "Y",
      "stateSalesTax": 0.03999999910593,
      "stateUseTax": 0.03999999910593,
      "citySalesTax": 0.045000001788139,
      "cityUseTax": 0.045000001788139,
      "cityTaxCode": "NE 8081",
      "countySalesTax": 0,
      "countyUseTax": 0,
      "countyTaxCode": "",
      "districtSalesTax": 0.003749999916181,
      "districtUseTax": 0.003749999916181
    },
    {
      "geoPostalCode": "10003",
      "geoCity": "NEW YORK",
      "geoCounty": "NEW YORK",
      "geoState": "NY",
      "taxSales": 0.088749997317791,
      "taxUse": 0.088749997317791,
      "txbService": "L",
      "txbFreight": "Y",
      "stateSalesTax": 0.03999999910593,
      "stateUseTax": 0.03999999910593,
      "citySalesTax": 0.045000001788139,
      "cityUseTax": 0.045000001788139,
      "cityTaxCode": "NE 8081",
      "countySalesTax": 0,
      "countyUseTax": 0,
      "countyTaxCode": "",
      "districtSalesTax": 0.003749999916181,
      "districtUseTax": 0.003749999916181
    }
  ]
}
```

## Contributing

1. Fork it ( https://github.com/brycemcd/ziptax/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
