Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2, '434988192076.apps.googleusercontent.com', '3d-IW3lUbI36Ok_lPlEBM7RY', {approval_prompt: ''}
end
