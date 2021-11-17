# ViSaaS
==========
## Team 33 members:

Malcolm Mashig (mjm2396)

Akshay Sharma (as6429)

Phu Doan Pham (pdp2121)

## Installation
- Install Ruby 3.0.0 (use rvm https://rvm.io)
- Setup gems: `bundle install`


## Running the app
`bin/rails server`

## To Test
Run behave to test user stories
```
behave
```
Run test coverage
```
coverage run -m unittest tests
coverage report --omit=tests.py
```

## Heroku Link
https://blooming-caverns-07190.herokuapp.com

## GitHub Link
https://github.com/pdp2121/VISaaS (navigate to `proj-iter-1` branch)

## Adding a Controller
`bin/rails generate controller <controller name> <action name>`
Will generate below files
```
      create  app/controllers/home_controller.rb
       route  get 'home/index'
      invoke  erb
      create    app/views/home
      create    app/views/home/index.html.erb
      invoke  test_unit
      create    test/controllers/home_controller_test.rb
      invoke  helper
      create    app/helpers/home_helper.rb
      invoke    test_unit
      invoke  assets
      invoke    scss
      create      app/assets/stylesheets/home.scss
```
