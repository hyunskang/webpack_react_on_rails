var path = require('path');
var webpack = require('webpack');
var _ = require('lodash');
var config = module.exports = require('./main.config.js');

config = _.merge(config, {
  context: __dirname,
});

config.entry = _.merge(config.entry, {
  entry: {
    webpackDev: 'webpack/hot/only-dev-server',
  }
});

// this config dicates where compiled bundles end up
config.output = _.merge(config.output, {
  // this is our app/assets/javascripts directory, which is part of the Sprockets pipeline
  path: path.join(__dirname, 'app', 'assets', 'javascript', 'bundle'),

  // the filename of the compiled bundle, e.g. app/assets/javascripts/bundle.js
  filename: '[name]-bundle.js',

  // if the webpack code-splitting feature is enabled, this is the path it'll use to download bundles
  publicPath: '/assets',
});

config.plugins.push(
  new webpack.HotModuleReplacementPlugin()
);
