require 'test_helper'
require 'generators/webpack_react_on_rails/install_generator'

class InstallGeneratorTest < Rails::Generators::TestCase
  tests ::WebpackReactOnRails::InstallGenerator
  destination File.expand_path("../tmp", File.dirname(__FILE__))
  setup :prepare_destination

  test "create the correct configuration files" do
    around_hook {
      run_generator

      assert_file "config/initializers/webpack.rb"
      assert_file "./webpack_development.config.js"
      assert_file "./webpack_development.config.js"
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
