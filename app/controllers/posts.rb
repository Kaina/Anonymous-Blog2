get 'post/:post_id' do
  @post = Post.find(params[:post_id])
  erb :show_post
end

get '/posts/new' do
  # @post = Post.create(params[:id])
  # @message = "this is our individual post page"
  erb :new
end

get '/posts/:id' do
  @post = Post.find(params[:id])
  @message = "this is our individual post page"
  @tags = @post.tags
  erb :show
end

get '/posts/:id/edit' do
  puts params.inspect
  @post = Post.find(params[:id])
  @message = "this is our individual edit page"
  erb :edit
end

post '/posts' do
  @post = Post.create(params[:post])
  
  params[:tag][:tag_name].split(', ').each do |tag|
    @post.tags.find_or_create_by_tag_name(tag)
  end

  @tags = @post.tags
  erb :show
end

post '/posts/:id' do
  @post = Post.find(params[:id])
  @post.update_attributes(params[:post])
  @message = "this is our individual edit page"
  redirect to("/posts/#{@post.id}")
end

post '/posts/:id/delete' do
  # @post = Post.destroy(params[:id])
  redirect to '/'
end
