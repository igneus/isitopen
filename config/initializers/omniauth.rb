OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, Isitopen.facebook_app_id, Isitopen.facebook_app_secret
end
