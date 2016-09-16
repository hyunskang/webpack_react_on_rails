module WebpackReactOnRails
  class Railtie < Rails::Railtie
    initializer "railtie.configure_view_controller" do |app|
      ActiveSupport.on_load :action_view do
        include ActionView::WebpackHelpers
      end
    end

    rake_tasks do
      load 'tasks/webpack/compile.rake'
    end
  end
end
