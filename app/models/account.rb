class Account < ApplicationRecord
  has_many :target_transactions, class_name: 'Transaction', foreign_key: 'target_account_id'
  has_many :source_transactions, class_name: 'Transaction', foreign_key: 'source_account_id'

  belongs_to :customer, foreign_key: 'customers_id'

  include TypeValidatable

  validates_type :account_type, AccountConstant::Type
  validates :balance, :account_type, presence: true
  validates :account_number, presence: true, uniqueness: true
end