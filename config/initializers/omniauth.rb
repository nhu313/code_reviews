Rails.application.config.middleware.use OmniAuth::Builder do
  omniauth_config = Rails.root.join('config/omniauth.yml')

  if File.exists?(omniauth_config)
    config = YAML.load_file(omniauth_config)[Rails.env]
  else
    config = ENV
  end

  provider :google_oauth2, ENV['google_id'], ENV['google_secret'], {approval_prompt: ''}
end
