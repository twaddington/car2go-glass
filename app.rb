
configure do
  set :sessions, true
  set :session_secret, 'foo'
end

use OmniAuth::Builder do
  # provider :car2go, 'Geoloqi', ''
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
get '/auth/google/callback' do
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
  erb :setup_complete
end

# Glass posts location updates here
post '/glass/location' do

end

# When the user clicks an action on a card, the Glass API posts here
post '/glass/notification' do

end

