require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Driverhunt
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de

    # Devise recommends forcing your application to not access the DB
    #   or load models when precompiling your assets.
    config.assets.initialize_on_precompile = false

    config.action_view.field_error_proc = Proc.new { |html_tag, instance| 
      html_tag
    }
  
    config.action_mailer.default_url_options = {:host => 'localhost:8080'}
    config.action_mailer.delivery_method = :smtp
    
    # config.action_mailer.smtp_settings = {
    #   :address              => "smtp.gmail.com",
    #   :domain               => "mail.google.com",
    #   :port                 => 587,
    #   :domain               => "gmail.com",
    #   :user_name            => "XX",
    #   :password             => "XX",
    #   :authentication       => 'login',
    #   :enable_starttls_auto => true
    # }

    config.action_mailer.smtp_settings = {

      :port                 => 587,
      :address              => "smtp.mandrillapp.com",
      :user_name            => "Will@driverhunt.com",
      :password             => "2LaL2d9ihHWLN84QO3Xs8g",
      :authentication       => :plain

    }

  end
end
