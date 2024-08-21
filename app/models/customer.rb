class Customer < ApplicationRecord
	has_many :accounts, foreign_key: 'customers_id'

	include TypeValidatable

	validates :email, presence: true, uniqueness: true
  validates_type :customer_type, CustomerConstant::Type

	def authenticate(password)
		self.password == password
	end
end
