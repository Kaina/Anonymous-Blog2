get '/post/new' do
  @post = Post.create(params[:id])

  erb :new
end

get '/post/:post_id' do
  @post = Post.find(params[:post_id])
  @tags = @post.tags
  puts @tags
  puts "***********************************"
  erb :show_post
end

get '/post/:post_id/edit' do
  @post = Post.find(params[:post_id])
  erb :edit_post
end

get '/post/:post_id/delete' do
  @post = Post.destroy(params[:post_id])
  redirect to '/'
end

post '/posts' do
  @post = Post.create(title: params[:post][:title], author_name: params[:post][:author_name], body: params[:post][:body])
  list_of_tags = params[:post][:tags]
  list_of_tags.split(", ").each do |tag|
    new_tag = Tag.find_or_create_by_name(tag)
    # @post.tags.find_or_create_by_name(tag)
    @post.tags << new_tag
  end
  redirect "/post/#{@post.id}"
end

post '/post/:post_id/edit' do
  @post = Post.find(params[:post_id])
  @post.update_attributes(title: params[:title], body: params[:body])
  tags = params[:tags]
  tags.split(', ').each do |tag|
    new_tag = Tag.find_or_create_by_name(tag)
    @post.tags << new_tag
  end
  redirect "/post/#{@post.id}"
end



