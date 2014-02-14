Livepost::Application.configure do
  # Settings specified here will take precedence over those in config/application.rb.

  # In the development environment your application's code is reloaded on
  # every request. This slows down response time but is perfect for development
  # since you don't have to restart the web server when you make code changes.
  config.cache_classes = false

  # Do not eager load code on boot.
  config.eager_load = false

  # Show full error reports and disable caching.
  config.consider_all_requests_local       = true
  config.action_controller.perform_caching = false

  # Don't care if the mailer can't send.
  config.action_mailer.raise_delivery_errors = false

  # Print deprecation notices to the Rails logger.
  config.active_support.deprecation = :log

  # Raise an error on page load if there are pending migrations
  config.active_record.migration_error = :page_load

  # Debug mode disables concatenation and preprocessing of assets.
  # This option may cause significant delays in view rendering with a large
  # number of complex assets.
  config.assets.debug = true
  config.quiet_assets = true

  # Speed up data populating by lowering bcrypt's cost function.
  ActiveModel::SecurePassword.min_cost = true

  # Activate Bullet development gem
  config.after_initialize do
  Bullet.enable = true #enable bullet
  Bullet.alert = true #alert in the browser via a javascript popup
  #Bullet.bullet_logger = true #don't log things to a special log file
  #Bullet.console = true #dont log things to the web log file
  #Bullet.growl = true #we dont use growl
  #Bullet.xmpp = { :account  => 'bullets_account@jabber.org', #we dont use jabber/xmpp
  #                :password => 'bullets_password_for_jabber',
  #                :receiver => 'your_account@jabber.org',
  #                :show_online_status => true }
  Bullet.rails_logger = true #let alerts be sent to the rails log
  #Bullet.airbrake = true #we dont use airbrake
  Bullet.add_footer = true
  end
end