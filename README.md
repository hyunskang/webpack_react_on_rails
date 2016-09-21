## Webpack React On Rails
[![Gem Version](https://badge.fury.io/rb/webpack_react_on_rails.svg)](https://badge.fury.io/rb/webpack_react_on_rails)
[![Build Status](https://travis-ci.org/brokenfingers/webpack_react_on_rails.svg?branch=fix%2Fallow-any-bundle-name-for-viewhelpers)](https://travis-ci.org/brokenfingers/webpack_react_on_rails)

This gem was created in order to easily setup webpack on rails. The following guide was used in the creation of the gem: http://clarkdave.net/2015/01/how-to-use-webpack-with-rails/

### Getting Started

#### Rails

Webpack React On Rails works with Rails 4.1 onwards, and Ruby 2.1 onwards. You can add it to your Gemfile with:

``` ruby
gem 'webpack_react_on_rails'
```

Run bundle to install the gem.

Next, run the generator to create the necessary files and setup the necessary configuration:

`rails generate webpack_react_on_rails:install`

The command will generate the following files and add the necesary configuration to `application.rb` and `production.rb`:

- `./package.json`
- `./config/webpack/main.config.js`
- `./config/webpack/development.config.js`
- `./config/webpack/production.config.js`
- `./config/webpack.rb`

Now, add the line below to your application layout:

``` ruby
<%= webpack_manifest_script %>
```

#### Webpack

<<<<<<< HEAD
Add entries to `main.config.js`:
=======
Run `npm install` to install all the node modules needed.

Add an entry path to `webpack.*.config.js`:
>>>>>>> origin/master

For example, adding the entry javascript file `index.js`:

``` js
entry: {
  index: './app/frontend/javascripts/index.js'
}
```

The same entry will be used for both development and production.

Run webpack using the following command:

`node_modules/.bin/webpack --config ./config/webpack/development.config.js --watch --colors`

Bundled assets will be located in the directory specified in:

``` js
config.output = {
  // this is our app/assets/javascripts directory, which is part of the Sprockets pipeline
  path: path.join(__dirname, '../../app', 'assets', 'javascript', 'bundle'),

  ...
};
```

For the example configuration Rails will serve assets from `app/assets/javascripts/bundle`

### Production

Before deploying to Heroku, set the buildpack:

1. `heroku buildpacks:clear`
2. `heroku buildpacks:set heroku/nodejs`
3. `heroku buildpacks:add heroku/ruby --index 2`

### View Helpers

For the given development and production webpack config:

Development:

``` js
config.output = {
  // this is our app/assets/javascripts directory, which is part of the Sprockets pipeline
  path: path.join(__dirname, '../../app', 'assets', 'javascript', 'bundle'),

  ...
};
```

Production:

``` js
config.output = {
  path: path.join(__dirname, '../../public', 'assets', 'bundle'),
  ...
};
```

Rails will serve bundled assets from `public/assets/bundle` in production and from `app/assets/javascripts/bundle` in development.

You can include your webpack bundled javascript using the view helper method:

In `erb` for the example configuration above:

``` ruby
<%= webpack_bundle_tag 'bundle/index' %>
```

### Issues:

If you find any issues, please create an `Issue` or PR, and I will address/review it as soon as possible.

This project uses MIT-LICENSE.
