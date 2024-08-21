module Transactions
  class ZeroAmount < StandardError
  end

  class InsufficientBalance < StandardError
  end

  class SameSourceAndTargetAccount < StandardError
  end
end