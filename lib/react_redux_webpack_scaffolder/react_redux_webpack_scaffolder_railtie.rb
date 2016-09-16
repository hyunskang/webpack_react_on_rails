class ReactReduxWebpackScaffolderRailtie < Rails::Railtie
  initializer "my_gem.configure_view_controller" do |app|
    ActiveSupport.on_load :action_view do
      include ReactReduxWebpackScaffolder::ActionView::WebpackHelpers
    end
  end

  rake_tasks do
    load 'tasks/webpack/compile.rake'
  end
end
