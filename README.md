# README

Linky is a link-sharing site that allows users to:
* Create an account using an email or Github
* Create Communities
* Share Links in those communities
* Vote on Links
* Comment on Links

## Install

### Clone the repository

```shell
git clone git@github.com:stuart-hahn/linky.git
cd linky
```

### Check your Ruby version

```shell
ruby -v
```

The ouput should start with something like `ruby 2.6.1`

If not, install the right ruby version using [rbenv](https://github.com/rbenv/rbenv) (it could take a while):

```shell
rbenv install 2.6.1
```

### Install dependencies

Using [Bundler](https://github.com/bundler/bundler) and [Yarn](https://github.com/yarnpkg/yarn):

```shell
bundle && yarn
```

### Set environment variables

This project uses "omniauth-github" and requires ENV variables of a Github Oath APP_SECRET AND CLIENT_ID. You can set these in a .env file (make sure to add .env to .gitignore so that they don't get pushed to Github with other commits).

### Initialize the database

```shell
rails db:migrate
```

## Serve

```shell
rails s
```

## Contributing & Code of Conduct

Bug reports and pull requests are welcome on GitHub at https://github.com/stuart-hahn/linky. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).