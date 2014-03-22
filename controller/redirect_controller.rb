get '/redirect/:city' do
  haml :redirect, :locals => {:city => params[:city]}
end