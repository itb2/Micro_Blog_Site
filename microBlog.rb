require 'rubygems'
require 'sinatra'
require 'sinatra/activerecord'
set :database, "sqlite3:myblogdb.sqlite3"
require './models'
enable :sessions

get '/' do
	erb :welcome
end

post '/sign-in' do
	#do stuff with sessions
	 @user = User.where(email: params[:email]).first  
	 if @user.password == params[:password]
	    session[:user_id] = @user.id
	    puts session[:user_id]
	 	redirect '/home'   
	 else
	    redirect '/login-failed'   
	 end
end

get '/sign-out' do
	#do stuff with sessions
 	session[:user_id] = nil
	redirect '/'
end

get '/register' do

	erb :register
end

post '/registering' do

	User.create(
		email: params[:email],
		password: params[:password],
		fname: params[:fname],
		lname: params[:lname],
		location: params[:location],
		bio: params[:bio],
		birthday: params[:birthday].to_s,
		joined_at: DateTime.now
	)

	redirect '/'
end

get '/home' do

	@user = User.where(id: session[:user_id]).first 
	
	erb :home
end

post '/home/posting' do
	@user = User.where(id: params[:id]).first
	Post.create(
		userName: @user.fname+" " +@user.lname,
		userId: @user.id,
		text: params[:post],
		title: params[:ptitle],
		posted_at: DateTime.now
		)
	#do some stuff
	redirect '/home'
end

get '/deleting' do
	usery = Post.where(id: params[:id]).first

	if session[:user_id] == usery.userId
		Post.delete(params[:id])
	else
		flash = { success: "You cant delete other people's posts, silly goose!"}
	end

	redirect '/home'
end

get '/profile' do
	@user1 = User.where(id: params[:id]).first
	erb :profile

end

get '/settings' do
	@user = User.where(id: session[:user_id]).first
	erb :settings

end

post '/updating' do
	User.update(
		email: params[:email],
		password: params[:password],
		fname: params[:fname],
		lname: params[:lname],
		location: params[:location],
		bio: params[:bio],
		birthday: params[:birthday],
		)
	redirect '/profile'

end

not_found do
  halt 404, 'page not found'
end














