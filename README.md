# RailsEmailChecker

[![Gem Version](https://badge.fury.io/rb/rails_email_checker.svg)](https://badge.fury.io/rb/redis_web_manager)
[![Maintainability](https://api.codeclimate.com/v1/badges/eecf90541668432d4d41/maintainability)](https://codeclimate.com/github/OpenGems/rails_email_checker/maintainability)
[![Build Status](https://travis-ci.org/OpenGems/rails_email_checker.svg?branch=master)](https://travis-ci.org/OpenGems/redis_web_manager)
[![security](https://hakiri.io/github/OpenGems/rails_email_checker/master.svg)](https://hakiri.io/github/OpenGems/redis_web_manager/master)
![Gem](https://img.shields.io/gem/dt/rails_email_checker)
[![Coverage Status](https://coveralls.io/repos/github/OpenGems/rails_email_checker/badge.svg?branch=master)](https://coveralls.io/github/OpenGems/rails_email_checker?branch=master)

ActiveModel email validation. Checks MX records, sub address, regex, whitelisted and blacklisted check

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'rails_email_checker'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install rails_email_checker

## Usage

### Use with ActiveModel

To validate that the domain has a good format (regex):
```ruby
class User < ActiveRecord::Base
  validates_email :email, formatted: true
end
```

To validate that the domain is not blacklisted:
```ruby
class User < ActiveRecord::Base
  validates_email :email, blacklisted: true
end
```

To validate that the domain has a MX record:
```ruby
class User < ActiveRecord::Base
  validates_email :email, recorded: true
end
```

To validate that email is not sub addressed:
```ruby
class User < ActiveRecord::Base
  validates_email :email, no_sub_addressed: true
end
```

### Use without ActiveModel
```ruby
address = RailsEmailChecker.address('test@gmail.com') # or RailsEmailChecker::Address.new('test@gmail.com')
address.formatted? # => true
address.sub_addressed? # => false
address.recorded? # => true
address.whitelisted? # => false
address.blacklisted? # => false
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/OpenGems/rails_email_checker. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the Contributor Covenant code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
