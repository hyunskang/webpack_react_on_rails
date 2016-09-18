## Webpack React On Rails

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
- `./webpack_development.config.js`
- `./webpack_production.config.js`
- `./config/webpack.rb`

Now, add the line below to your application layout:

``` ruby
<%= webpack_manifest_script %>
```

#### Webpack

Add an entry path to `webpack.*.config.js`:

For example, adding the entry javascript file `index.js`:

``` js
entry: {
  webpackDev: 'webpack/hot/only-dev-server',
  index: './app/frontend/javascripts/index.js'
}
```

Run webpack using the following command: 

`node_modules/.bin/webpack --config webpack.development.config.js --watch --colors`

Bundled assets will be located in the directory specified in:

``` js
config.output = {
  // this is our app/assets/javascripts directory, which is part of the Sprockets pipeline
  path: path.join(__dirname, 'app', 'assets', 'javascript', 'bundle'),

  ...
};
```

### View Helpers

You can include your webpack bundled javascript using the view helper method:

In `erb`:

``` ruby
<%= webpack_bundle_tag 'bundle/index' %>
```

### Production

Before deploying to Heroku, set the buildpack:

1. `heroku buildpacks:clear`
2. `heroku buildpacks:set heroku/nodejs`
3. `heroku buildpacks:add heroku/ruby --index 2`

### Issues:

If you find any issues, please create an `Issue`, and I will address it as soon as possible.

### TODOS:

1. Improve how webpack is configured for different environtments

This project uses MIT-LICENSE.
