# StockSummary

The application gets a ticker (AAPL) and a start date and calculates the return the stock has generated since the start date to today as well as the maximum drawdown of the stock within that time frame.

Then it shows the results in CLI where you start it from and also push it to a Slack channel.

## Setup

You will need to setup accounts on [Quandl](https://www.quandl.com) and [Slack](https://slack.com). Then on Slack you should be able to create a new bot and get its API token. We will need a API token from Quandl as well.

## Usage

Build and install the gem:
```
gem build stock_summary.gemspec
gem install ./stock_summary-0.1.0.gem
```

From now you should be able to play with `stock_summary` utility from your console:
```
stock_summary -h
```

The utility expects you to set `QUANDL_TOKEN` and `SLACK_TOKEN` environment variables. This is done as environment variables because usually you don't want to pass your passwords as parameters, but instead you setup environment where you can use the utility without password. This can be setup in production environment, or there could be a separate script locally that takes general password and setup these tokens for you.

`stock_summary` accepts following parameters:
* -p -- number of digits after a comma (default is 2)
* -s -- name of a slack channel you going to send the message to (default is general)

So we can invoke following command to find out something about Facebook stock:
```
$ QUANDL_TOKEN=<quandl tocken> SLACK_TOKEN=<slack token> stock_summary FB 2016-10-10 -p 3 -s general

Stock ticker FB has 41.7$ return and 34.11% maximum drawdown from 2016-10-10 up to now
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

Inside it you can test different parts of the system. Retrieve stock prices:
```
ENV['QUANDL_TOKEN'] = 'quandl api key'
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
