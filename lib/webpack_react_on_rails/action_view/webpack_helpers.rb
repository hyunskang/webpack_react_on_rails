module WebpackReactOnRails
  module ActionView::WebpackHelpers
    include ActionView::Helpers
    include ActionView::Context

    def webpack_bundle_tag(bundle)
      if Rails.configuration.webpack[:use_manifest]
        manifest = Rails.configuration.webpack[:asset_manifest]

        path_names = bundle.split('/')
        path_names[-1] = manifest[path_names.last]
        path_name = path_names.join('/')

        src = "#{compute_asset_host}/assets/#{filename}"
      else
        src = "#{compute_asset_host}/assets/#{bundle}-bundle"
      end

      javascript_include_tag(src)
    end

    def webpack_manifest_script
      return '' unless Rails.configuration.webpack[:use_manifest]
      javascript_tag "window.webpackManifest = #{Rails.configuration.webpack[:common_manifest]}"
    end
  end
end
