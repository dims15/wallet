class Transaction < ApplicationRecord
  belongs_to :target_account, class_name: 'Account', optional: true
  belongs_to :source_account, class_name: 'Account', optional: true

  include TypeValidatable

  validate :ensure_one_account_id_present
  validates_type :transaction_type, TransactionConstant::Type
  
  private

  def ensure_one_account_id_present
    unless target_account_id.present? || source_account_id.present?
      errors.add(:base, "Either target_account_id or source_account_id must be present")
    end
  end
end
