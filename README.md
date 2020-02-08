# ActiveWorksheet

ActiveWorksheet reads local spreadsheet files (XLS, XLSX and CSV) and presents them as ActiveRecord/ActiveResource objects, mapping rows as records and columns and attributes.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'active_worksheet'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install active_worksheet

## Usage

Having the following CSV file:

```csv
id,first_name,last_name,email,company
1,Brendis,MacCahee,bmaccahee0@privacy.gov.au,Klocko and Sons
2,Abbe,John,ajohn1@ibm.com,"Mayer, Weimann and Stark"
3,Buffy,Schiersch,bschiersch2@chronoengine.com,"Gusikowski, Schmidt and Watsica"
4,Flore,Aberhart,faberhart3@boston.com,Beatty Group
```

```ruby
class ImportedAccount < ActiveWorksheet::Base
  self.source = "./accounts.csv"
end
```

The `ImportedAccount` class will read the file as a spreadsheet and treat the first row as the collection's headers, where each column is an attribute name.

```ruby
ImportedAccount.count
# => 4

ImportedAccount.first
# => #<ImportedAccount id=1, first_name="Brendis", last_name="MacCahee", email="bmaccahee0@privacy.gov.au", company="Klocko and Sons">
```

ActiveWorksheet works with .xls, .xlsx and .csv files.

`ActiveWorksheet::Base` exposes the following class methods, similar to `ActiveRecord::Base` or `ActiveResource::Base`:
* `.all`
* `.find(index)`
* `.first`
* `.last`
* `.count`

### Using Google Sheets (experimental)

ActiveWorksheet can connect to Google Sheets files by setting a URL as `source` and an `authorization` strategy.

```ruby
class Savings < ActiveWorksheet::Base
  self.source = "https://docs.google.com/spreadsheets/d/YOUR_GOOGLE_SHEETS_ID/edit"
  self.authorization = {
    credentials: Google::Auth::UserRefreshCredentials.new(
      client_id: "CLIENT_ID",
      client_secret: "CLIENT_SECRET",
      refresh_token: "REFRESH_TOKEN",
      type: "authorized_user"
    )
  }
end
```

> **Note:** At the moment, all attributes are formatted strings (the same way they're represented in Google Sheets).

```ruby
Savings.last.week
# => "52"

Savings.last.weekly_savings
# => "S/.1,300.00"
```

#### Authorization

ActiveWorksheet supports the following authorization strategies:

##### OAuth client ID (For "Other" Application type)

With a JSON file containing `client_id` and `client_secret`:

```ruby
self.authorization = {
  config: "YOUR_CONFIG_FILE_PATH.json",
}
```

##### OAuth client ID (For "Web application" Application type)

With a credentials object:

```ruby
require "googleauth"

self.authorization = {
  credentials: Google::Auth::UserRefreshCredentials.new(
    client_id: "CLIENT_ID",
    client_secret: "CLIENT_SECRET",
    refresh_token: "USER_REFRESH_TOKEN",
    type: "authorized_user"
  )
}
```

##### Service account key

With a JSON file downloaded from Google Developer Console:

```ruby
self.authorization = {
  service_account_key: "my-service-account-xxxxxxxxxxxx.json",
}
```

> **Note:** You can check available configuration strategies and a more thorough explanation [here](https://github.com/gimite/google-drive-ruby/blob/master/doc/authorization.md).

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/hpneo/active_worksheet. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the ActiveWorksheet project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/hpneo/active_worksheet/blob/master/CODE_OF_CONDUCT.md).
