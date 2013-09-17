Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2, '434988192076.apps.googleusercontent.com', '2zdGqktCN6wwvzCA4rTnU217', {approval_prompt: ''}
end
