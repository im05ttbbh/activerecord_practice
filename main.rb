require 'active_record'
require 'pp'
require 'active_support/all'
require "logger"

Time.zone_default = Time.find_zone! 'Tokyo'
ActiveRecord::Base.default_timezone = :local

# ActiveRecord::Base.logger = Logger.new(STDOUT)

ActiveRecord::Base.establish_connection(
  "adapter" => "sqlite3",
  "database" => "./myapp.db"
)

class User < ActiveRecord::Base
  has_many :comments, dependent: :destroy
end

class Comment < ActiveRecord::Base
  belongs_to :user
end

User.delete_all

User.create(name: "tanaka", age: 19)
User.create(name: "takahashi", age: 25)
User.create(name: "hayashi", age: 31)
User.create(name: "mizutani", age: 28)
User.create(name: "otuka", age: 35)


Comment.delete_all

Comment.create(user_id: 1, body: "hello-1")
Comment.create(user_id: 1, body: "hello-2")
Comment.create(user_id: 3, body: "hello-3")

User.find(1).destroy
pp Comment.select("id, user_id, body").all