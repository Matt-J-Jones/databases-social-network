require 'post_repository'
require 'database_connection'
require 'post'

RSpec.describe PostRepositorty do
  def reset_books_table
    seed_sql = File.read('spec/seeds.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'social_network_test'})
    connection.exec(seed_sql)
  end

  before(:each) do
    reset_books_table
  end

  it "returns list of posts" do
    post_titles = [
      "Happy Friday!",
      "Travel Dreams",
      "Yum!",
      "Nature Walk",
      "Fitness Journey"
    ]
    
    posts = PostRepositorty.new
    post_list = posts.all
    expect(post_list.length).to eq 5
    expect(post_list[4].title).to eq "Fitness Journey"
  end

  it "returns single post" do
    posts = PostRepositorty.new
    result = posts.find(2)
    expect(result.title).to eq "Travel Dreams"
    expect(result.content).to eq "Wanderlust taking over my soul."
  end

  it "creates a post" do
    posts = PostRepositorty.new
    new_post = Post.new
    new_post.title = "New Recipe Alert"
    new_post.content = "Check out my latest culinary creation"
    new_post.views = "1812"
    new_post.user_id = "2"

    posts.create(new_post)
    result = posts.all

    expect(result.length).to eq 6
    expect(result[5].content).to eq new_post.content
  end

  it "deletes a post" do
    posts = PostRepositorty.new
    posts.delete(5)
    result = posts.all
    expect(result.length).to eq 4
  end

  it "updates a post" do
    posts = PostRepositorty.new
    post_to_update = 3
    old_content = "Pizza and Netflix tonight"
    new_content = "Check out my latest culinary creation"

    unedited_post = posts.find(post_to_update)
    expect(unedited_post.content).to eq old_content

    posts.update(post_to_update, new_content)

    edited_post = posts.find(post_to_update)
    expect(edited_post.content).to eq new_content
  end

end