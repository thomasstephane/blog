
####### sass support ######
require 'sass'

get '/css/application.css' do
  scss :application
end

['/posts', '/posts/:id'].each do |path|
  before path do 
    redirect '/blog/1' unless session[:id]
  end
end

###### Home ######

get '/' do
  erb :index
end


###### Posts ######
get '/posts' do
  @post = Post.new
  @errors = []
  @list = Post.all
  erb :posts 
end

get '/posts/:id' do |id|
    @post = Post.find_by_id(id.to_i)
    @errors = []
    @list = Post.all
    erb :posts
end

post '/posts' do 
  connected_id = session[:id]

  if connected_id
    existing_post = Post.find_by_title(params[:title])

    p existing_post
    p params[:id]

    case
    when existing_post && existing_post.id == params[:id]
      Post.update(existing_post.id,title: params[:title], 
        content: params[:content], published: params[:published])
      existing_post.save
      @post = Post.new
    when existing_post && existing_post.id != params[:id]
      @post = Post.new
      @list = Post.all
      erb :posts
    else
      @post = Post.new(title: params[:title], content: params[:content], published: params[:published], user_id: connected_id)
      @post.save
    end
    @list = Post.all
    erb :posts
  end
end


###### Blog ######

get '/blog/:num' do |num|
  @list = Post.where("published = true").order('updated_at DESC').limit(10).offset((num.to_i - 1) * 5)
  @nb_post = Post.count(:conditions => "published = true") % 10
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
  name, password = params[:name], params[:password]
  if User.login(name, password)
    session[:id] = User.find_by_name(name).id
    redirect '/posts'
  else
    content_type :json
    {errors: "Nice try but no..."}.to_json
    # erb :user
  end
end

get '/logout' do 
  session[:id] = nil
  redirect to '/'
end
