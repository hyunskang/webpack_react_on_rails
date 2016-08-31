require 'rails/generators'

module ReactReduxWebpackScaffolder
  class ScaffoldGenerator < Rails::Generators::Base
    TEMPLATES_DIR = File.join(File.expand_path(File.dirname(__FILE__)), '../../templates')

    def create_scaffold_file
      # Check if npm is installed or not if not display warning message
      package_json_template = File.read(File.join(TEMPLATES_DIR, 'package'))
      package_json_template.gsub!('APPLICATION_NAME', rails_application_name)

      create_file "#{Rails.root}/package.json", package_json_template

      webpack_config_template = File.read(File.join(TEMPLATES_DIR, 'webpack_config'))
      create_file "#{Rails.root}/webpack.config.js", webpack_config_template

      # Update .gitignore to include app/assets/javascripts, /node_modules
      gitignore_path = File.join(Rails.root, '.gitignore')
      File.open(gitignore_path, 'a+') do |f|
        if !/\/node_modules\n/.match(f.read)
          f.write "/app/assets/javascripts\n"
          f.write "/node_modules\n"
        end
      end

      # Update config/initializers/assets.rb and add Rails.application.config.assets.precompile += %w( bundle.js )
      config_assets_path = File.join(Rails.root, 'config', 'initializers', 'assets.rb')
      File.open(config_assets_path, 'a+') do |f|
        if !/bundle.js/.match(f.read)
          f.write "Rails.application.config.assets.precompile += %w( bundle.js )"
        end
      end
    end

    private

    def rails_application_name
      Rails.application.class.parent.to_s
    end
  end
end
