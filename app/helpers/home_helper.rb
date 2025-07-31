# frozen_string_literal: true

module HomeHelper
  include ActionView::RecordIdentifier

  def following?(user)
    current_user&.followees&.include?(user)
    # using & to check if we are signed in and have followees
  end
end
