get '/' do
  # @success = params[:msg]
  erb :index
end

post '/manage' do 
  @post = Post.new(title: params[:title], content: params[:content])
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
