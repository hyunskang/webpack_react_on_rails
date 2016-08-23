require 'rails/generators'

module ReactReduxWebpackScaffolder
  class ScaffoldGenerator < Rails::Generators::Base
    def create_scaffold_file
      create_file "#{Rails.root}/package.json", npm_package
      create_file "#{Rails.root}/webpack.config.js", webpack_config
    end

    private

    def rails_application_name
      Rails.application.class.parent
    end

    # NPM Package related output methods
    def npm_package
      <<-NPM_PACKAGE.strip_heredoc
{
  #{application_details}
  #{babel_details}
  #{dev_dependencies}
  #{dependencies}
}
      NPM_PACKAGE
    end

    def application_details
      <<-APP_DETAILS.strip_heredoc
  "name": "#{rails_application_name}",
    "description": "TODO: Add a brief description for the application",
    "version": "1.0.0",
      APP_DETAILS
    end

    def babel_details
      <<-BABEL_DETAILS.strip_heredoc
  "babel": {
      "presets": [
        "es2015",
        "react"
      ],
      "plugins": [
        "transform-object-assign"
      ]
    },
      BABEL_DETAILS
    end

    def dev_dependencies
      <<-DEV_DEPENDENCIES.strip_heredoc
  "devDependencies": {
      "babel-core": "^6.13.2",
      "babel-loader": "^6.2.5",
      "babel-preset-es2015": "^6.13.2",
      "babel-preset-react": "^6.11.1",
      "exports-loader": "~0.6.2",
      "expose-loader": "~0.6.0",
      "imports-loader": "~0.6.3",
      "lodash": "~2.4.1",
      "react-hot-loader": "^1.3.0",
      "webpack": "~1.4.13"
    },
      DEV_DEPENDENCIES
    end

    def dependencies
      <<-DEPENDENCIES.strip_heredoc
  "dependencies": {
      "babel-plugin-transform-object-assign": "^6.8.0",
      "immutable": "^3.8.1",
      "isomorphic-fetch": "^2.2.1",
      "react": "^15.3.1",
      "react-dom": "^15.3.1",
      "react-redux": "^4.4.5",
      "redux": "^3.5.2",
      "redux-thunk": "^2.1.0"
    }
      DEPENDENCIES
    end

    # Webpack Config related output methods
    def webpack_config
      <<-WEBPACK_CONFIG.strip_heredoc
      #{require_modules}
      #{config_exports}
      #{config_module}
      #{config_output}
      #{config_resolve}
      #{config_plugins}
      WEBPACK_CONFIG
    end

    def require_modules
      <<-REQUIRE_MODULES.strip_heredoc
var path = require('path');
      var webpack = require('webpack');
      REQUIRE_MODULES
    end

    def config_exports
      <<-CONFIG_EXPORTS.strip_heredoc
var config = module.exports = {
        // the base path which will be used to resolve entry points
        context: __dirname,

        // the main entry point for our application's frontend js
        // anything not required by this file will never end up in the compiled bundle
        entry: [
          'webpack/hot/only-dev-server',
        ]
      };
      CONFIG_EXPORTS
    end

    def config_module
      <<-CONFIG_MODULE.strip_heredoc
config.module = {
        loaders: [{
          test: /\.jsx?$/,
          exclude: /node_modules/,
          loader: 'babel'
        }]
      };
      CONFIG_MODULE
    end

    def config_output
      <<-CONFIG_OUTPUT.strip_heredoc
// this config dicates where compiled bundles end up
      config.output = {
        // this is our app/assets/javascripts directory, which is part of the Sprockets pipeline
        path: path.join(__dirname, 'app', 'assets', 'javascripts'),

        // the filename of the compiled bundle, e.g. app/assets/javascripts/bundle.js
        filename: 'bundle.js',

        // if the webpack code-splitting feature is enabled, this is the path it'll use to download bundles
        publicPath: '/assets',
      };
      CONFIG_OUTPUT
    end

    def config_resolve
      <<-CONFIG_RESOLVE.strip_heredoc
config.resolve = {
        extensions: ['', '.js', '.jsx'],
        modulesDirectories: ['node_modules'],
      };
      CONFIG_RESOLVE
    end

    def config_plugins
      <<-CONFIG_PLUGINS.strip_heredoc
config.plugins = [
        new webpack.HotModuleReplacementPlugin()
      ];
      CONFIG_PLUGINS
    end
  end
end
