Rails.application.config.middleware.use OmniAuth::Builder do
  config = YAML.load_file(Rails.root.join('config/omniauth.yml'))[Rails.env]
  provider :google_oauth2, config['google_id'], config['google_secret'], {approval_prompt: ''}
end
