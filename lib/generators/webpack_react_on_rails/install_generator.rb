require 'rails/generators'

module WebpackReactOnRails
  class InstallGenerator < Rails::Generators::Base
    source_root File.expand_path('../templates', __FILE__)

    def create_scaffold_file
      inside 'config' do
        inject_into_file "application.rb", "\n    config.webpack = {\n      :use_manifest => false,\n      :asset_manifest => {},\n      :common_manifest => {}\n    }\n", after: "class Application < Rails::Application"

        inside 'environments' do
          inject_into_file "production.rb", "  config.webpack[:use_manifest] = true\n", before: /^end/
        end

        inside 'initializers' do
          copy_file "../../../templates/config/initializers/webpack.rb", "webpack.rb"
        end

        inside 'webpack' do
          copy_file "../../../templates/config/webpack/main.config.js", "main.config.js"
          copy_file "../../../templates/config/webpack/development.config.js", "development.config.js"
          copy_file "../../../templates/config/webpack/production.config.js", "production.config.js"
        end
      end

      copy_file "../templates/package.json", "./package.json"

      # Update .gitignore to include app/assets/javascripts, /node_modules
      gitignore_path = File.join(Rails.root, '.gitignore')
      File.open(gitignore_path, 'a+') do |f|
        if !/\/node_modules\n/.match(f.read)
          f.write "/public/assets/javascripts/bundle\n"
          f.write "/node_modules\n"
        end
      end
    end
  end
end
