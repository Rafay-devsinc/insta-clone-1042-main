# frozen_string_literal: true

module RequestsHelper
  def requested?(user)
    current_user&.requestees&.include?(user)
    # using & to check if we are signed in and have already requested the user
  end

  def is_following?(user)
    current_user.followees.include?(user)
    # Relationship.find_by(follower_id: 4,followee_id: 1).present?
  end
end
