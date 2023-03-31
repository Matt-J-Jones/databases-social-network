require 'user'
require 'database_connection'

class UsersRepository
  def all
    output = []
    sql = 'SELECT * FROM users;'
    result = DatabaseConnection.exec_params(sql, [])
    result.each {|item|
      user = User.new
      user.username = item["username"]
      user.email_address = item["email_address"]
      output << user
    }
    
    return output
  end

  def find(id)
    sql = 'SELECT username, email_address FROM users WHERE id = $1;'
    params = [id]
    result = DatabaseConnection.exec_params(sql, params)
    user = User.new
    user.username = result[0]["username"]
    user.email_address = result[0]["email_address"]
    return user
  end

  def create(user)
    sql = 'INSERT INTO users (username, email_address) VALUES ($1, $2);'
    params = [user.username, user.email_address]
    DatabaseConnection.exec_params(sql, params)
  end

  def delete(id)
    sql = 'DELETE FROM users WHERE id = $1;'
    params = [id]
    DatabaseConnection.exec_params(sql, params)
  end
end