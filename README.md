# ViSaaS
==========

[Live Here](https://blooming-caverns-07190.herokuapp.com)

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

## Heroku 
- Deploy from any branch using `git push heroku <branch>: master`
- The app is live at https://blooming-caverns-07190.herokuapp.com
- Note: sometimes, we experience a delay in the display of the map plots (in that case, a page refresh will help)

## GitHub Link
https://github.com/pdp2121/VISaaS/tree/map_plots

