require 'test_helper'
require 'generators/webpack_react_on_rails/install_generator'

class InstallGeneratorTest < Rails::Generators::TestCase
  tests ::WebpackReactOnRails::InstallGenerator
  destination File.join(Rails.root, "tmp")

  test "create the correct configuration files" do
    around_hook {
      # Need to add test
    }
  end

  private

  def around_hook
    before_hook
    yield
    after_hook
  end
  # Creates all necessary test files
  def before_hook
    create_application_rb
    create_production_rb
  end

  def create_application_rb
    path = File.join(Rails.root, "tmp", "config")
    FileUtils.mkdir_p(path) unless File.exist?(path)
    File.open(File.join(path, 'application.rb'), "w+") do |f|
      f.write(
<<-APPLICATION.strip_heredoc
require File.expand_path('../boot', __FILE__)

require 'rails/all'

Bundler.require(*Rails.groups)
require "webpack_react_on_rails"

module Dummy
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de

    # Do not swallow errors in after_commit/after_rollback callbacks.
    config.active_record.raise_in_transactional_callbacks = true
  end
end
APPLICATION
      )
    end
  end

  def create_production_rb
    path = File.join(Rails.root, "tmp", "config", "environments")
    FileUtils.mkdir_p(path) unless File.exist?(path)
    File.open(File.join(path, 'production.rb'), "w+") do |f|
      f.write(
<<-PRODUCTION.strip_heredoc
Rails.application.configure do
  config.cache_classes = true

  config.eager_load = true

  config.consider_all_requests_local       = false
  config.action_controller.perform_caching = true

  config.serve_static_files = ENV['RAILS_SERVE_STATIC_FILES'].present?

  config.assets.js_compressor = :uglifier

  config.assets.compile = false

  config.assets.digest = true

  config.log_level = :debug

  config.i18n.fallbacks = true
  config.active_support.deprecation = :notify

  config.log_formatter = ::Logger::Formatter.new

  config.active_record.dump_schema_after_migration = false
end
PRODUCTION
      )
    end
  end

  # Removes all test files created
  def after_hook
    FileUtils.rm_rf(File.join(Rails.root, "tmp"))

    init_webpack_path = File.join(Rails.root, "config", "initializers", "webpack.rb")
    File.delete(init_webpack_path) if File.file?(init_webpack_path)

    webpack_dev_config_path = File.join(Rails.root, "webpack_development.config.js")
    File.delete(webpack_dev_config_path) if File.file?(webpack_dev_config_path)

    webpack_prod_config_path = File.join(Rails.root, "webpack_production.config.js")
    File.delete(webpack_prod_config_path) if File.file?(webpack_prod_config_path)

    package_json_path = File.join(Rails.root, "package.json")
    File.delete(package_json_path) if File.file?(package_json_path)
  end
end
