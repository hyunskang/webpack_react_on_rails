## Webpack React On Rails

### Setup

Run the generator using the following command: `rails generate webpack_react_on_rails:install`

The command will generate the following files and add the necesary configuration to `application.rb` and `production.rb`:

- `./package.json`
- `./webpack.development.config.js`
- `./webpack.production.config.js`
- `./config/webpack.rb`

Run webpack using the following command: `node_modules/.bin/webpack --config webpack.development.config.js --watch --colors`

### Production

Before deploying to Heroku set the buildpack:

1. `heroku buildpacks:clear`
2. `heroku buildpacks:set heroku/nodejs`
3. `heroku buildpacks:add heroku/ruby --index 2`

TODO:
1. Improve how webpack is configured for different environtments
2. Add instructions to README on how to use after generating the scaffolds.

This project uses MIT-LICENSE.
