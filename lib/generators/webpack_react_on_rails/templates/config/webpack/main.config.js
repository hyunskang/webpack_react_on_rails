var path = require('path');
var webpack = require('webpack');

var config = module.exports = {
  context: path.join(__dirname, '../', '../')
};

config.module = {
  loaders: [{
    test: /\.jsx?$/,
    exclude: /node_modules/,
    loader: 'babel'
  }]
};

config.resolve = {
  extensions: ['', '.js', '.jsx'],
  modulesDirectories: ['node_modules'],
};

// the main entry point for our application's frontend js
// anything not required by this file will never end up in the compiled bundle
// passing an object provides multiple entries points
config.entry = {
  // your entry points
};

config.output = {
  // your outputs
  // we'll be overriding some of these in the production config, to support
  // writing out bundles with digests in their filename
}
