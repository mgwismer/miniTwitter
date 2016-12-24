require 'sinatra'
require 'sinatra/activerecord'
require './models.rb'
require 'sinatra/flash'

set :database, "sqlite3:test.sqlite3"
enable :sessions

#this is the root
get '/' do
   erb :home
end

#goto the login page
get '/loginpage' do
   erb :loginpage
end

#goto the sign up page
get '/signup' do
   erb :signup
end

get '/users' do
   @users = User.all
   erb :users
end

get '/user/:id' do
   @user = User.find(params["id"])
   erb :user
end

get '/user/posts/:id' do
   @user = User.find(params["id"])
   erb :listpost
end 
 
get '/allposts' do
   @posts = Post.all.reverse
   erb :allposts
end

get '/mypage' do
  if (session[:user_id])
    redirect "/user/#{session[:user_id]}"
  else
    erb :loginpage
  end
end

get '/logout' do
  if (session[:user_id])
    session[:user_id] = nil 
    erb :loginpage
  else
    erb :loginpage
  end
end

post '/users/create' do
  @user= User.new(params)
  @user.save
  redirect "/user/#{@user.id}"
end

post '/posts/create/:user_id' do
  @user = User.find(params["user_id"])
  @post = Post.new(title: params["title"], content: params["content"])
  @post.user_id = @user.id
  @post.save
  redirect "/user/#{@user.id}"
end

post '/posts/search' do
  #@user = User.find(params["user_id"])
  @searched_user = User.find_by(name: params['search'])
  # puts @searched_user
  redirect "/user/posts/#{@searched_user.id}"
end

post '/login' do
  @user = User.where(email: params['email']).first
  if @user && (@user.password == params['password'])
    session[:user_id] = @user.id
    flash[:notice] = "You got it, you're so  in"
    redirect "/user/#{session[:user_id]}"
  else 
    flash[:alert] = "Nope, try again"
    redirect '/loginpage'
  end

end
