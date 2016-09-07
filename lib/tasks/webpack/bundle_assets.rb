namespace :webpack do
  task :bundle_assets => :environment do
    # Check if Rails.application.config.webpack_config = path exists
    # Run webpack
    `webpack --config ./webpack_production.config.js --progress --colors`
  end
end
