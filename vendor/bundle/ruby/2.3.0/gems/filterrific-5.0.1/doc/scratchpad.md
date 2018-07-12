# Filterrific scratchpad

## TODO

* add check that no filter_name conflicts with existing methods on included ActiveRecord class (See https://github.com/jhund/filterrific/issues/17)

## Travis

Example setups:

* https://github.com/mislav/will_paginate/blob/master/.travis.yml
* https://github.com/stripe/stripe-ruby/blob/master/.travis.yml

Filterrific 2

* requires Ruby 1.9.3 or later
* requires Rails 3.1 or later
* new syntax
* better test coverage

test matrix

            Rails 2.x  Rails 3.0  Rails 3.1  Rails 3.2  Rails 4.0  Rails 4.1  Rails Edge
Ruby 1.8.7
Ruby 1.9.3
Ruby 2.0
Ruby 2.1

Each combination is also tested for postgres and mysql

wwtd to simulate travis

plataformatec/devise uses the rails stable branch from git.
That's an interesting idea.

## Options for proper test matrix

* appraisal by thoughtbot -1
* wwtd: ++ for being able to run tests locally
* ENV vars (steve klabnik's approach)
* use combustion gem for testing without dummy app? nah. It doesn't support Rails 4

Preferred method:

* use ENV vars in travis.yml for Rails versions
* use steve klabnik's approach for selecting the correct gemfile
* use ENV vars to choose correct dummy app

Apps to generate dummy apps for each version:

    bundle exec rails plugin new ~/development/filterrific_4.1/filterrific -T --mountable --dummy-path=spec/dummy --database=postgresql

[differences between full and mountable engine](http://stackoverflow.com/a/17263429)

* 3.1: ibo-pts
* 3.2: filterrific_demo (sqlite3)
* 4.0: yikesite (mysql)
* 4.1: utilibase (postgresql)
