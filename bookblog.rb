require 'sinatra'
require 'sinatra/activerecord'
require './models.rb'
require 'sinatra/flash'
require 'json'

set :database, "sqlite3:test.sqlite3"
enable :sessions
initColor = {h1Color: "000000", bodyColor: "FFFFFF", textColor: "000000"}

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
   @users = User.all
   @user = User.find(params["id"])
   @colors = Color.find_by(user_id: @user.id)
   erb :user
end

get '/user/posts/:id' do
   @user = User.find(params["id"])
   @colors = Color.find_by(user_id: @user.id)
   erb :listpost
end 
 
get '/allposts' do
  if (session[:user_id])
    @posts = Post.all.reverse
    @users = User.all
    erb :allposts
  else
    erb :loginpage
  end
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
  #default colors
  @color = Color.new(initColor)
  @color.user_id = @user.id
  @color.save
  redirect "/user/#{@user.id}"
end

#user creates a new post
post '/posts/create/:user_id' do
  @user = User.find(params["user_id"])
  @post = Post.new(title: params["title"], content: params["content"])
  @post.user_id = @user.id
  @post.save
  redirect "/user/#{@user.id}"
end

#user can search for another user
post '/posts/search' do
  @searched_user = User.find_by(name: params['search'])
  if (@searched_user)
    redirect "/user/posts/#{@searched_user.id}"
  else
    flash[:alert] = "No user by this name found"
    redirect "/user/#{session[:user_id]}"
  end
end

post '/users/update/:user_id' do
  @user = User.find(params["user_id"])
  @color = Color.where(user_id: params["user_id"])[0]
  @color.update(h1Color: params["h1Color"], bodyColor: params["bodyColor"], textColor: params["textColor"])
  redirect "/user/#{@user.id}"
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

  #trying to delete a user post
post '/posts/:id/delete' do
  @post = Post.find(params['id'])
  @post.destroy
  redirect "/user/#{session[:user_id]}"
end

post '/users/:id/delete' do
  @user = User.find(params['id'])
  @user.destroy
  redirect "/"
end
