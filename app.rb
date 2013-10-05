
configure do
  set :sessions, true
  set :session_secret, 'foo'
end

use OmniAuth::Builder do
  # provider :car2go, Site::CONFIG[:car2go][:client_id], Site::CONFIG[:car2go][:client_secret]
  provider :google_oauth2, Site::CONFIG[:google][:client_id], Site::CONFIG[:google][:client_secret], {
    access_type: 'offline', 
    approval_prompt: 'force',
    scope: 'https://www.googleapis.com/auth/glass.timeline https://www.googleapis.com/auth/userinfo.profile https://www.googleapis.com/auth/glass.location'
  }
end

# Home Page
get '/' do
  erb :index
end

# Setup page - connect to Google, car2go
get '/setup' do
  erb :setup  
end

# Google OAuth Complete
get '/auth/google_oauth2/callback' do
  # TODO: Store access and refresh tokens in the database
  erb "<h1>#{params[:provider]}</h1>
       <pre>#{JSON.pretty_generate(request.env['omniauth.auth'])}</pre>"
end

# Car2go OAuth Complete
get '/auth/car2go/callback' do
  erb "<h1>#{params[:provider]}</h1>
       <pre>#{JSON.pretty_generate(request.env['omniauth.auth'])}</pre>"
end

# Setup Complete
get '/setup/complete' do
  token = params[:google_token]
  @mirror = MirrorClient.new Signet::OAuth2::Client.new({
    access_token: Site::CONFIG[:google][:access_token],
    refresh_token: Site::CONFIG[:google][:refresh_token]
  })
  puts @mirror.insert_subscription '117847912875913905493', 'locations', 'https://pin13.net/car2go-glass/callback.php'
  erb :setup_complete
end

# Glass posts location updates here
post '/glass/location' do

end

# When the user clicks an action on a card, the Glass API posts here
post '/glass/notification' do

end

