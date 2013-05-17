
####### sass support ######
require 'sass'

get '/css/application.css' do
  scss :application
end


###### Home ######

get '/' do
  erb :index
end


###### Posts ######
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

get '/posts/:id' do |id|
  connected_id = session[:id]
  if connected_id
    @post = Post.find_by_id(id.to_i)
    @errors = []
    @list = Post.all
    erb :posts
  end
end

post '/posts' do 
  connected_id = session[:id]
  if connected_id
    existing_post = Post.find_by_title(params[:title])
    if existing_post
      existing_post[:title] = params[:title]
      existing_post[:content] = params[:content]
      existing_post[:published] = params[:published]
      existing_post.save
    else
      @post = Post.new(title: params[:title], content: params[:content], published: params[:published], user_id: connected_id)
      @post.save
      @list = Post.all
    end
    redirect '/posts'
  end
end


###### Blog ######

get '/blog/:num' do |num|
  @list = Post.where("published = true").order('updated_at DESC').limit(5).offset((num.to_i - 1) * 5)
  erb :blog
end

get '/blog/show/:id' do |id|
  @post = Post.find(id)
  redirect '/' unless @post
  erb :show
end


###### User #######
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
