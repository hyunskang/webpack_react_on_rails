var path = require('path');
var webpack = require('webpack');
var ChunkManifestPlugin = require('chunk-manifest-webpack-plugin');

var config = module.exports = {
  entry: {
    // The entry point for the application js i.e. './app/frontend/javascripts/app.js'
  }
};

config.module = {
  loaders: [{
    test: /\.jsx?$/,
    exclude: /node_modules/,
    loader: 'babel'
  }]
};

config.output = {
  path: path.join(__dirname, 'public', 'assets', 'bundle'),
  filename: '[name]-bundle-[chunkhash].js',
  chunkFilename: '[id]-bundle-[chunkhash].js'
};

config.resolve = {
  extensions: ['', '.js', '.jsx'],
  modulesDirectories: ['node_modules'],
};

config.plugins = [
  new webpack.optimize.UglifyJsPlugin({
    minimize: true,
    compress: {
      warnings: false
    }
  }),
  new ChunkManifestPlugin({
    filename: 'webpack-common-manifest.json',
    manifestVariable: 'webpackBundleManifest'
  }),
  new webpack.DefinePlugin({
    'process.env': {
      'NODE_ENV': JSON.stringify('production')
    }
  })
];
