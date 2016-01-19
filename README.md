# Rough-Sketch
## Built with Ruby on Rails

### Authors
[Toni Rib](http://github.com/tonirib), [Taylor Moore](https://github.com/Tman22), [Brenna Martenson](https://github.com/martensonbj)

This project was created as a part of the curriculum for the [Turing School of Software & Design](http://turing.io).

### Overview

This Rails application is a marketplace for artists. An artist can register an account and add art pieces to sell. Users can register accounts to purchase the available art pieces. An admin can regulate the process by transitioning order status and managing art for artists.

### Live Version

You can find a live version of this application on Heroku at: [https://rough-sketch.herokuapp.com/](https://rough-sketch.herokuapp.com/)

### Setup

To set up a local copy of this project, perform the following:

  1. Clone the repository: `git clone https://github.com/martensonbj/little_shop.git`
  2. `cd` into the project's directory
  3. Run `bundle install`
  4. Run `rake db:create db:migrate db:seed` to set up the postgres database and seed it with users, artists, categories, and items.
    - If you would like to create your own users, artist, items, and categories do not run `db:seed`
    - The seed file does not include any setup for admins, so those must be created manually by running `rails c` and adding a user to the database with role = 2
  5. Run the application in the dev environment by running `rails s`

### App Features

Features info here (To be completed)

### Test Suite

The test suite tests the application on multiple levels. To run all of the tests, run `rake test` from the terminal in the main directory of the project. The feature tests (integration tests) rely mainly on the [capybara gem](https://github.com/jnicklas/capybara) for navigating the various application views.

The project also utilizes the [simplecov gem](https://github.com/colszowka/simplecov) for quick statistics on code coverage.

### Dependencies

This application depends on many ruby gems, all of which are found in the `Gemfile` and can be installed by running `bundle install` from the terminal in the main directory of the project.
