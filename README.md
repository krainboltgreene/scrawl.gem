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

    gem "scrawl", "~> 1.0"

And then execute:

    $ bundle

Or install it yourself with:

    $ gem install scrawl


Contributing
============

  1. Fork it
  2. Create your feature branch (`git checkout -b my-new-feature`)
  3. Commit your changes (`git commit -am 'Add some feature'`)
  4. Push to the branch (`git push origin my-new-feature`)
  5. Create new Pull Request


Changelog
=========

  - 1.0.0: Initial release


Conduct
=======

As contributors and maintainers of this project, we pledge to respect all people who contribute through reporting issues, posting feature requests, updating documentation, submitting pull requests or patches, and other activities.

We are committed to making participation in this project a harassment-free experience for everyone, regardless of level of experience, gender, gender identity and expression, sexual orientation, disability, personal appearance, body size, race, ethnicity, age, or religion.

Examples of unacceptable behavior by participants include the use of sexual language or imagery, derogatory comments or personal attacks, trolling, public or private harassment, insults, or other unprofessional conduct.

Project maintainers have the right and responsibility to remove, edit, or reject comments, commits, code, wiki edits, issues, and other contributions that are not aligned to this Code of Conduct. Project maintainers who do not follow the Code of Conduct may be removed from the project team.

This code of conduct applies both within project spaces and in public spaces when an individual is representing the project or its community.

Instances of abusive, harassing, or otherwise unacceptable behavior may be reported by opening an issue or contacting one or more of the project maintainers.

This Code of Conduct is adapted from the [Contributor Covenant](http://contributor-covenant.org), version 1.1.0, available at [http://contributor-covenant.org/version/1/1/0/](http://contributor-covenant.org/version/1/1/0/)


License
=======

Copyright (c) 2014, 2015 Kurtis Rainbolt-Greene

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
