require 'test_helper'
require 'generators/webpack_react_on_rails/install_generator'

class InstallGeneratorTest < Rails::Generators::TestCase
  tests ::WebpackReactOnRails::InstallGenerator
  destination File.expand_path("../dummy/tmp", File.dirname(__FILE__))
  setup :prepare_destination

  test "create the correct configuration files" do
    setup_files

    run_generator

    assert_file "./config/initializers/webpack.rb"
    assert_file "./config/webpack/main.config.js"
    assert_file "./config/webpack/development.config.js"
    assert_file "./config/webpack/production.config.js"
    assert_file "./package.json"

    cleanup_files
  end

  private

  # Creates all necessary test files
  def setup_files
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

end
PRODUCTION
      )
    end
  end

  # Removes all test files created
  def cleanup_files
    FileUtils.rm_rf(File.join(Rails.root, "tmp"))
  end
end
