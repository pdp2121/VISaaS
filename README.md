# ViSaaS
==========
## Team 33 members:

Malcolm Mashig (mjm2396)

Akshay Sharma (as6429)

Phu Doan Pham (pdp2121)

## Installation
- Install Ruby 3.0.0 (use rvm https://rvm.io)
- Install Webpack: `bundle exec rake webpacker:install`
- Install Postgres: `brew install postgresql`
- Setup gems: `sudo bundle install`
- If using Mac, start Postgres server: `pg_ctl -D /usr/local/var/postgres start`
- Initialize database: `rake db:create`


## Running the app
`bin/rails server`

## To Test
Run cucumber to test user stories
```
cucumber -s --publish-quiet
```

Run test coverage
```
bundle exec rspec
```

## Heroku Link
https://blooming-caverns-07190.herokuapp.com

## GitHub Link
https://github.com/pdp2121/VISaaS/tree/proj-iter-2

## Notes

- Our first iteration was done with flask, python, and behave testing because we were not aware that Ruby on Rails was a requirement of the project. For this iteration, we have migrated our application to Ruby on Rails and are now using Cucumber and RSpec for testing.

- Our new features for this iteration include allowing the user to choose which plot type to create. This feature can be further expanded to include more plot types with little overhead. Another new feature is allowing a user to upload their own data as a CSV and choose two variables of interest from a dropdown before creating a plot of the relationship between those variables. Lastly, we have recently incorporated a feature that allows users to copy the html code that generates the plot they create within our application, so that they can paste it elsewhere effortlessly.

- A TA asked why we have a weather forecast feature available to users. This feature will be generalized as a feature whereby users can visualize any open-source API dataset that our application connects to. Right now, we are just connected to a weather API, but we plan on adding more public, live datasets for our application demo.

