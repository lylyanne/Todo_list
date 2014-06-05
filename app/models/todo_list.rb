class TodoList < ActiveRecord::Base
	validates :title, presence: true
	validates :description, length: {minimum: 3 }
end
