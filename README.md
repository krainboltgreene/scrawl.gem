scrawl
--------

  - [![Quality](http://img.shields.io/codeclimate/github/krainboltgreene/scrawl.gem.svg?style=flat-square)](https://codeclimate.com/github/krainboltgreene/scrawl.gem)
  - [![Coverage](http://img.shields.io/codeclimate/coverage/github/krainboltgreene/scrawl.gem.svg?style=flat-square)](https://codeclimate.com/github/krainboltgreene/scrawl.gem)
  - [![Build](http://img.shields.io/travis-ci/krainboltgreene/scrawl.gem.svg?style=flat-square)](https://travis-ci.org/krainboltgreene/scrawl.gem)
  - [![Dependencies](http://img.shields.io/gemnasium/krainboltgreene/scrawl.gem.svg?style=flat-square)](https://gemnasium.com/krainboltgreene/scrawl.gem)
  - [![Downloads](http://img.shields.io/gem/dtv/scrawl.svg?style=flat-square)](https://rubygems.org/gems/scrawl)
  - [![Tags](http://img.shields.io/github/tag/krainboltgreene/scrawl.gem.svg?style=flat-square)](http://github.com/krainboltgreene/scrawl.gem/tags)
  - [![Releases](http://img.shields.io/github/release/krainboltgreene/scrawl.gem.svg?style=flat-square)](http://github.com/krainboltgreene/scrawl.gem/releases)
  - [![Issues](http://img.shields.io/github/issues/krainboltgreene/scrawl.gem.svg?style=flat-square)](http://github.com/krainboltgreene/scrawl.gem/issues)
  - [![License](http://img.shields.io/badge/license-MIT-brightgreen.svg?style=flat-square)](http://opensource.org/licenses/MIT)
  - [![Version](http://img.shields.io/gem/v/scrawl.svg?style=flat-square)](https://rubygems.org/gems/scrawl)

This is a simple object that turns hashes, even nested, into Heroku like log strings.

It is a smaller, faster, and I believe more OO way to do [scrolls](https://github.com/asenchi/scrolls).


Using
=====

The `Scrawl` object gives you a simple interface:

``` ruby
require "scrawl"

data = Scrawl.new(app: "scrawl", state: 0)
data.inspect
  # => "app=\"scrawl\" state=0"
puts data.inspect
  # => app="scrawl" state=0
```

It also does some nice things:

``` ruby
require "scrawl"

data = Scrawl.new(now: -> { Time.now })
puts data.inspect
  # => now="2014-04-13 01:36:18 -0500"
puts data.inspect
  # => now="2014-04-13 01:36:19 -0500"
puts data.inspect
  # => now="2014-04-13 01:36:20 -0500"
```

You can also handle a "global" set of values:

``` ruby
require "logger"
require "scrawl"

logger = Logger.new(STDOUT)
global = Scrawl.new(now: -> { Time.now }, app: "scrawl", state: 0)

# ...

def report_user(user)
  user.report!
  logger.info(global.merge(message: "Bank has been reported."))
    # => now="2014-04-13 01:36:20 -0500" app="scrawl" state=0 message="Bank has been reported."
end

# ...
```

We've also got a way to combine multiple statement objects:

``` ruby
require "logger"
require "scrawl"

logger = Logger.new(STDOUT)

global = Scrawl.new(now: -> { Time.now })
application = Scrawl.new(app: "scrawl", version: ENV["VERSION"])

logger.info(Scrawl.new(global, application, message: "Hello, World"))
```

Finall, nesting:

``` ruby
require "scrawl"

global = Scrawl.new(now: -> { Time.now })
application = Scrawl.new(app: { name: "scrawl", version: ENV["VERSION"] })

# ...

def report_user(user)
  begin
    user.report!
  rescue => exception
  logger.info(global.merge(global, application, error: { exception: exception, message: "Bank wasnt been reported." }))
    # => now="2014-04-13 01:36:20 -0500" app.name="scrawl" app.version=0 error.exception=... error.message="Bank has been reported."
  end
end

# ...
```


Installing
==========

Add this line to your application's Gemfile:

    gem "scrawl", "~> 3.0"

And then execute:

    $ bundle

Or install it yourself with:

    $ gem install scrawl


Contributing
============

  1. Read the [Code of Conduct](/CONDUCT.md)
  2. Fork it
  3. Create your feature branch (`git checkout -b my-new-feature`)
  4. Commit your changes (`git commit -am 'Add some feature'`)
  5. Push to the branch (`git push origin my-new-feature`)
  6. Create new Pull Request


License
=======

Copyright (c) 2014-2015 Kurtis Rainbolt-Greene

MIT License

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
"Software"), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
