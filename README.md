# Dragonfly with MySQL data storage

## Gemfile

    gem 'dragonfly-mysql', github: 'dnitta/dragonfly-mysql'

## Generate model and migration

    $ rails generate dragonfly_mysql:install

## Customize Dragonfly initializer

If you set random strings to `salt`, uids are sha1-hashed. So you can safely reuse uids in hidden tag. (For example: in confirmation page or validate error page).

#### `config/initializers/dragonfly.rb`
    app.datastore.salt = 'xxxxxxxxxxxxxxxxxx'

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## License

the `redactor-dragonfly` project is MIT-LICENSE.