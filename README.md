# Rough-Sketch
## Built with Ruby on Rails

### Authors
[Toni Rib](http://github.com/tonirib), [Taylor Moore](https://github.com/Tman22), [Brenna Martenson](https://github.com/martensonbj)

This project was created as a part of the curriculum for the [Turing School of Software & Design](http://turing.io).

### Live Version

You can find a live version of this application on Heroku at: [https://rough-sketch.herokuapp.com/](https://rough-sketch.herokuapp.com/)

### Setup

To set up a local copy of this project, perform the following:

  1. Clone the repository: `git clone https://github.com/martensonbj/little_shop.git`
  2. `cd` into the project's directory
  3. Run `bundle install`
  4. Run `rake db:create db:migrate db:seed` to set up the postgres database and seed it with users and artists.
    - If you would like to create your own users and artists, do not run `db:seed`
    - The seed file does not include any setup for admins, so those must be created manually by running `rails c` and adding a user to the database with role = 2
  5. Run the application in the dev environment by running `rails s`

### App Features

Features info here

### Test Suite

Test Suite Info Here

### Dependencies

This application depends on many ruby gems, all of which are found in the `Gemfile` and can be installed by running `bundle install` from the terminal in the main directory of the project.
