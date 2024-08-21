module TypeValidatable
  extend ActiveSupport::Concern

  included do
    def self.validates_type(attribute, type_class)
      validates attribute, presence: true, inclusion: { in: type_class.constants.map { |c| type_class.const_get(c) } }
    end
  end
end