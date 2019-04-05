# Contributing

First, thanks for wanting to contribute. You’re awesome! :heart:

## Questions

Use [Stack Overflow](https://stackoverflow.com/) with the tag `groupdate`.

## Feature Requests

Create an issue. Start the title with `[Idea]`.

## Issues

Think you’ve discovered an issue?

1. Search existing issues to see if it’s been reported.
2. Try the `master` branch to make sure it hasn’t been fixed.

```rb
gem "groupdate", github: "ankane/groupdate"
```

If the above steps don’t help, create an issue. Include:

- Detailed steps to reproduce
- Complete backtraces for exceptions

## Pull Requests

Fork the project and create a pull request. A few tips:

- Keep changes to a minimum. If you have multiple features or fixes, submit multiple pull requests.
- Follow the existing style. The code should read like it’s written by a single person.
- Add one or more tests if possible. Make sure existing tests pass with:

```sh
bundle exec rake test
```

Feel free to open an issue to get feedback on your idea before spending too much time on it.

## Dev Setup

On Mac:

```sh
# install and run PostgreSQL
brew install postgresql
brew services start postgresql

# install and run MySQL
brew install mysql
brew services start mysql

# create databases
createdb groupdate_test
mysql -u root -e "create database groupdate_test"
mysql_tzinfo_to_sql /usr/share/zoneinfo | mysql -u root mysql

# clone the repo and run the tests
git clone https://github.com/ankane/groupdate.git
cd groupdate
bundle install
bundle exec rake test

# run a single test file
ruby test/postgresql_test.rb
```

---

This contributing guide is released under [CCO](https://creativecommons.org/publicdomain/zero/1.0/) (public domain). Use it for your own project without attribution.
