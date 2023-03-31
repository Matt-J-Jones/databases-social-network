require 'post_repository'
require 'database_connection'
require 'post'

class PostRepositorty
  def all
    output = []
    sql = 'SELECT * FROM posts;'
    result = DatabaseConnection.exec_params(sql, [])

    result.each { |item|
      post = Post.new
      post.title = item["title"]
      post.content = item["content"]
      post.views = item["views"]
      post.user_id = item["user_id"]
      output << post
    }
    return output
  end

  def find(id)
    sql = 'SELECT * FROM posts WHERE id = $1;'
    params = [id]
    result = DatabaseConnection.exec_params(sql, params)
    output = Post.new
    output.title = result[0]["title"]
    output.content = result[0]["content"]
    output.views = result[0]["views"]
    output.user_id = result[0]["user_id"]
    return output
  end

  def create(post)
    sql = 'INSERT INTO posts (title, content, views, user_id) VALUES ($1, $2, $3, $4);'
    params = [post.title, post.content, post.views, post.user_id]
    DatabaseConnection.exec_params(sql, params)
  end

  def delete(id)
    sql = 'DELETE FROM users WHERE id = $1;'
    params = [id]
    DatabaseConnection.exec_params(sql, params)
  end

  def update(id, edit)
    sql = 'UPDATE posts SET content = $2 WHERE id=$1'
    params = [id, edit]
    DatabaseConnection.exec_params(sql, params)
  end
end