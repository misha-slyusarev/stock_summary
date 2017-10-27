# StockSummary

The app gets a ticker (AAPL) and a start date and calculates the return the stock has generated since the start date to today as well as the maximum drawdown of the stock within that time frame.

Then it shows the result in CLI where you start it form and also push it to a Slack channel.

## Usage

Retrieve stock prices
```
sp = StockSummary::StockPrices.new('fLrJgxjwgLCcyepsgH')
sp.get_prices('FB', '2016-10-01').count
```

Calculate stock summary
```
cl = StockSummary::Calculator.new
summary = cl.get_stock_summary(sp.get_prices('FB', '2017-10-01'))
```

Push to Slack
```
sl = StockSummary::Slack.new('xoxb-262815399732-7NqeP6L1TPAV8Og220QjxU')
sl.push(summary)
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/stock_summary.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
