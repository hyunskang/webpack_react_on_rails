namespace :webpack do
  task :bundle_assets => :environment do
    config_path = Rails.application.config.try(:webpack_config)
    config_path = config_path ? config_path : './webpack_production.config.js'

    cmd = "webpack --config #{config_path} --progress --colors"
    
    # Run webpack
    `#{cmd}`
  end
end
