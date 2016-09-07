class ReactReduxWebpackScaffolderRailtie < Rails::Railtie
  rake_tasks do
    load '../tasks/bundle_assets.rake'
  end
end
