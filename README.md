# StockSummary

The app gets a ticker (AAPL) and a start date and calculates the return the stock has generated since the start date to today as well as the maximum drawdown of the stock within that time frame.

Then it shows the results in CLI where you start it from and also push it to a Slack channel.

## Usage


## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

Inside it you can test different parts of the system. Retrieve stock prices:
```
ENV['STOCK_PRICES_TOKEN'] = 'quandl api key'
sp = StockSummary::StockPrices.new
sp.get_prices('FB', '2016-10-01').count
```

Calculate stock summary:
```
cl = StockSummary::Calculator.new
summary = cl.get_summary([175.2, 172.3, 171.9, 176.7])
```

Push to Slack
```
ENV['SLACK_TOKEN'] = 'slack api key'
sl = StockSummary::Slack.new
sl.push('Some text message')
```

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/misha-slyusarev/stock_summary.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
