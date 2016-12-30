class User < ActiveRecord::Base
	has_many :posts
	has_many :comments
	has_many :colors
end

class Post < ActiveRecord::Base
	belongs_to :user
	has_many :comments
end

class Comment < ActiveRecord::Base
	belongs_to :user
	belongs_to :post
end

class Color < ActiveRecord::Base
	belongs_to :user
end