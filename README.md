## ReactReduxWebpackScaffolder [![Code Climate](https://codeclimate.com/github/brokenfingers/react_redux_webpack_scaffolder/badges/gpa.svg)](https://codeclimate.com/github/brokenfingers/react_redux_webpack_scaffolder)

Run the generator using the following command: `rails g react_redux_webpack_scaffolder:scaffold`

Run webpack using the following command: `node_modules/.bin/webpack --config webpack.config.js --watch --colors`

Before deploying to Heroku set the buildpack:
1. `heroku buildpacks:clear`
2. `heroku buildpacks:set heroku/nodejs`
3. `heroku buildpacks:add heroku/ruby --index 2`

After deploying to Heroku run the following command: `heroku run rake webpack:precompile_assets`

TODO:
1. Improve how webpack is configured for different environtments
2. Add instructions to README on how to use after generating the scaffolds.

This project uses MIT-LICENSE.
