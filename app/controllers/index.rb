get '/' do
  erb :index
end

get '/posts' do
  @user = session[:id]
  if @user
    @post = Post.new
    @errors = []
    @list = Post.all
    erb :posts
  else
    redirect '/blog/1'
  end
end

post '/posts' do 
  connected_id = session[:id]
  if connected_id
    @post = Post.new(title: params[:title], content: params[:content], published: params[:published], user_id: connected_id)
    @post.save
    @list = Post.all
    erb :posts
  end
end


get '/blog/:num' do |num|
  @list = Post.order('updated_at DESC').limit(5).offset((num.to_i - 1) * 5)
  erb :blog
end

#sass support
require 'sass'

get '/css/application.css' do
  scss :application
end


get '/posts/:id' do |id|
  @post = Post.find(id)
  redirect '/' unless @post
  erb :show
end

get '/user' do
  erb :user
end

post '/user' do 
  name = params[:name]
  password = params[:password]
  if User.login(name, password)
    session[:id] = User.find_by_name(name).id
    redirect '/posts'
  else
    redirect '/user'
  end
end

get '/logout' do 
  session[:id] = nil
  redirect to '/'
end
