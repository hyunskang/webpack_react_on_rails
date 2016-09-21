require 'test_helper'

class WebpackHelpersTest < ActionView::TestCase
  include ActionView::WebpackHelpers

  test "return correct script tag for the given bundle name" do
    Rails.configuration.webpack[:use_manifest] = false

    bundle_name = 'index-bundle'
    assert_equal("<script src=\"/assets/#{bundle_name}.js\"></script>", webpack_bundle_tag(bundle_name))
  end

  test "return correct script tag when using manifest" do
    bundle_name = 'index'
    bundle_manifest = 'random-base64-string'

    Rails.configuration.webpack[:use_manifest] = true
    Rails.configuration.webpack[:asset_manifest] = {
      bundle_name => "#{bundle_name}-bundle-#{bundle_manifest}"
    }

    assert_equal("<script src=\"/assets/#{bundle_name}-bundle-#{bundle_manifest}.js\"></script>", webpack_bundle_tag(bundle_name))
  end

  test "return correct script tag for the given bundle path" do
    Rails.configuration.webpack[:use_manifest] = false
    Rails.configuration.webpack[:asset_manifest] = {}

    bundle_name = 'bundle/index'
    assert_equal("<script src=\"/assets/#{bundle_name}.js\"></script>", webpack_bundle_tag(bundle_name))
  end

  test "return correct script tag for the given bundle path when using manifest" do
    Rails.configuration.webpack[:asset_manifest] = {}

    bundle_name = 'bundle/index'
    bundle_manifest = 'random-base64-string'

    bundle_actual_name = bundle_name.split('/').last

    Rails.configuration.webpack[:use_manifest] = true
    Rails.configuration.webpack[:asset_manifest] = {
      bundle_actual_name => "#{bundle_actual_name}-bundle-#{bundle_manifest}"
    }

    assert_equal("<script src=\"/assets/#{bundle_name}-bundle-#{bundle_manifest}.js\"></script>", webpack_bundle_tag(bundle_name))
  end
end
