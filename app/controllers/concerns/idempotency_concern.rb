# app/controllers/concerns/idempotency_concern.rb
module IdempotencyConcern
  extend ActiveSupport::Concern

  included do
    before_action :validate_idempotency_key, only: :create
  end

  private

  def validate_idempotency_key(redirect_path = nil)
    idempotency_key = params[:idempotency_key]

    return if idempotency_key.blank?

    cached_result = Rails.cache.read(idempotency_key)

    if cached_result
      message = JSON.parse(cached_result)['message']

      flash[:notice] = message
      redirect_to redirect_path
    end
  end

  def store_response_in_redis(message = nil)
    idempotency_key = params[:idempotency_key]

    return if idempotency_key.blank?

    response_data = { message: message || response.body }

    Rails.cache.write(idempotency_key, response_data.to_json, expires_in: 1.hours)
  end
end
