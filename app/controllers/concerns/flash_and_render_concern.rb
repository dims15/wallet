module FlashAndRenderConcern
  extend ActiveSupport::Concern

  def set_flash_and_render(message, flash_type = :notice, template = :new)
    flash.now[flash_type] = message
    render template
  end
end
