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

The app is designed for both the mobile and desktop experience. Some of the main features of the app include:

#### Users

Users can browse the art inventory by both artist and category and filter based on a particular category or artist name. Each item has an image, title, price, artist name, and description associated with it. Users can add any items that are active to their cart. Users do not need to be signed in to browse items or add them to their cart. However, upon checkout, if a user is not signed in they will be asked to create an account or login before being allowed to check out. A user cannot add any items, but can choose to change their account to an "artist" account at any point. However, once they are signed up as an artist, they cannot change back to a default user. Users can also view any of their past orders and the order status.

#### Artists

Users can also sign up as an "artist" which allows them to add items to sell. Each item must include either an uploaded photo or a link to an online image path before it is allowed to be active. Artists can only add art for themselves, and they are allowed to both edit and delete any art that they own. Artists can also upload a profile photo that shows up next to their name in the art index. Artist also have all of the same priviledges as default users.

#### Admins

Admins are the 'master user' of the site. An admin can add art for any registered artist and also has the ability to edit and delete art from any artist. They are also able to view and change the status of any order that has been placed through the site. Like a default user, they are also able to shop and place orders of their own.

#### Other Features

The app is integrated with a test version of Stripe for mock-processing of payment at checkout. In addition, it uses Amazon Web Services S3 to store and host any image uploads. It also utilizes the jQuery library for live filtering of content.

### Test Suite

The test suite tests the application on multiple levels. To run all of the tests, run `rake test` from the terminal in the main directory of the project. The feature tests (integration tests) rely mainly on the [capybara gem](https://github.com/jnicklas/capybara) for navigating the various application views.

The project also utilizes the [simplecov gem](https://github.com/colszowka/simplecov) for quick statistics on code coverage.

### Dependencies

This application depends on many ruby gems, all of which are found in the `Gemfile` and can be installed by running `bundle install` from the terminal in the main directory of the project.
