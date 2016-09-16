if Rails.configuration.webpack[:use_manifest]
  Rails.application.load_tasks
  Rake::Task['webpack:compile'].invoke

  asset_manifest = Rails.root.join('public', 'assets', 'webpack-asset-manifest.json')

  if File.exist?(asset_manifest)
    Rails.configuration.webpack[:asset_manifest] = JSON.parse(
      File.read(asset_manifest),
    ).with_indifferent_access
  end
end
