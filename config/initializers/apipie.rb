Apipie.configure do |config|
  config.app_name                = 'NewsZone'
  config.api_base_url            = '/api'
  config.doc_base_url            = '/apidocs/apipie'
  config.translate               = false
  config.default_locale          = nil
  config.api_controllers_matcher = "#{Rails.root}/app/controllers/**/*.rb"
end
