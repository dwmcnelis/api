class Lead < ActiveRecord::Base

  def owner?(user)
    self.user_id == user.id
  end
end
