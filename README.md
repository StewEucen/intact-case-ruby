# Intact Case for Ruby

## What's Intact Case

Intact Case is the rules for interconverting naturally camelCase|StudlyCaps and snake_case which include acronym.

camelCase / StudlyCaps|snake_case
----|----
camelCase|camel_case
SnakeCase|snake_case
PHPUnit|php__unit
getUTCDay|get_utc__day

This library can interconvert camelCase|StudlyCaps and hyphenated string.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'intact_case'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install intact_case

## Usage

When you use this library, you must understand rules of Intact Case.

If you want to see more information, please see [IntactCase](http://lab.kochlein.com/IntactCase).

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake rspec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/StewEucen/intact-case-ruby. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
