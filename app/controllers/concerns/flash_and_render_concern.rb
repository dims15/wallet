module FlashAndRenderConcern
  extend ActiveSupport::Concern

  def set_flash_and_render(message, redirect_path = root_path, flash_type = :notice)
    flash[flash_type] = message
    redirect_to redirect_path
  end
end
