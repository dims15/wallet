class Customer < ApplicationRecord
	validates :email, presence: true, uniqueness: true

	def authenticate(password)
		self.password == password
	end
end
