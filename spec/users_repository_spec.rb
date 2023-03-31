require 'users_repository'
require 'database_connection'
require 'user'

RSpec.describe UsersRepository do
  def reset_books_table
    seed_sql = File.read('spec/seeds.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'social_network_test'})
    connection.exec(seed_sql)
  end

  before(:each) do
    reset_books_table
  end

  it "returns list of users" do
    output = []
    users = UsersRepository.new
    user_list = users.all
    usernames = [
    "SparkleLioness",
    "NeonUnicorn12",
    "ElectricPenguin",
    "CosmicKitten",
    "TigerStripedFox"]

    user_list.each { |user|
      output << user.username
    }
   
    expect(output.length).to eq 5
    expect(output).to eq usernames
    expect(user_list[1].username).to eq "NeonUnicorn12"
  end

  it "returns a single user" do
    users = UsersRepository.new
    user = users.find("2")
    expect(user.username).to eq "NeonUnicorn12"
  end

  it "deletes a user" do
    output = []
    users = UsersRepository.new
    users.delete("4")
    user_list = users.all
    usernames = [
    "SparkleLioness",
    "NeonUnicorn12",
    "ElectricPenguin",
    "TigerStripedFox"]
    
    user_list.each { |user|
      output << user.username
    }
   
    expect(output.length).to eq 4
    expect(output).to eq usernames
  end

  it "creates a user" do
    users = UsersRepository.new
    output = []
    new_user = User.new
    new_user.username ='RainbowDragonfly'
    new_user.email_address = 'RainbowDragonfly88@hotmail.com'
    users.create(new_user)
    
    user_list = users.all
    usernames = [
    "SparkleLioness",
    "NeonUnicorn12",
    "ElectricPenguin",
    "CosmicKitten",
    "TigerStripedFox",
    "RainbowDragonfly"]

    user_list.each { |user|
      output << user.username
    }
   
    expect(output.length).to eq 6
    expect(output).to eq usernames
    expect(user_list[5].username).to eq "RainbowDragonfly"
  end
end