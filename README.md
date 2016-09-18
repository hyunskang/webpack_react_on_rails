## Webpack React On Rails

### Getting Started

#### Rails

Webpack React On Rails works with Rails 4.1 onwards, and Ruby 2.1 onwards. You can add it to your Gemfile with:

``` ruby
gem 'webpack-react-on-rails'
```

Run bundle to install the gem.

Next, run the generator to create the necessary files and setup the necessary configuration:

`rails generate webpack_react_on_rails:install`

The command will generate the following files and add the necesary configuration to `application.rb` and `production.rb`:

- `./package.json`
- `./webpack.development.config.js`
- `./webpack.production.config.js`
- `./config/webpack.rb`

Now, the line below to your application layout:

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

### TODOS:

1. Improve how webpack is configured for different environtments

This project uses MIT-LICENSE.
