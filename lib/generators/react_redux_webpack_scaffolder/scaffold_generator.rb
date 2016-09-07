require 'rails/generators'

module ReactReduxWebpackScaffolder
  class ScaffoldGenerator < Rails::Generators::Base
    TEMPLATES_DIR = File.join(File.expand_path(File.dirname(__FILE__)), '../../templates')

    def create_scaffold_file
      generate_package_file('package', "#{Rails.root}/package.json")

      generate_config_file('webpack_development_config', "#{Rails.root}/webpack_development.config.js")

      generate_config_file('webpack_production_config', "#{Rails.root}/webpack_production.config.js")

      # Update .gitignore to include app/assets/javascripts, /node_modules
      gitignore_path = File.join(Rails.root, '.gitignore')
      File.open(gitignore_path, 'a+') do |f|
        if !/\/node_modules\n/.match(f.read)
          f.write "/app/assets/javascripts/webpack_bundle\n"
          f.write "/node_modules\n"
        end
      end

      # Update config/initializers/assets.rb and add Rails.application.config.assets.precompile += %w( bundle.js )
      config_assets_path = File.join(Rails.root, 'config', 'initializers', 'assets.rb')
      File.open(config_assets_path, 'a+') do |f|
        if !/bundle.js/.match(f.read)
          f.write "Rails.application.config.assets.precompile += %w( webpack_bundle/bundle.js )"
        end
      end
    end

    private

    def rails_application_name
      Rails.application.class.parent.to_s
    end

    def generate_package_file(template_name, file_path)
      template = File.read(File.join(TEMPLATES_DIR, template_name))
      template.gsub!('APPLICATION_NAME', rails_application_name)
      create_file file_path, template
    end

    def generate_config_file(template_name, file_path)
      template = File.read(File.join(TEMPLATES_DIR, template_name))
      create_file file_path, template
    end
  end
end
