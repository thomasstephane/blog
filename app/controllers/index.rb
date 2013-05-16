get '/' do
  # @success = params[:msg]
  erb :index
end

post '/manage' do 
  @post = Post.new(title: params[:title], content: params[:content], published: params[:published])
  if @post.save
    redirect '/posts'
  else
    erb :posts
  end
end

get '/posts' do
  @post = Post.new
  @list = Post.all
  erb :posts
end

#sass support
require 'sass'

get '/css/application.css' do
  scss :application
end


get '/posts/:id' do
  @post = Post.find(params[:id])
  redirect '/' unless @post
  erb :show
end
