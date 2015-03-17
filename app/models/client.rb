class Client < ActiveRecord::Base

	enum level: { a_list: 0, b_list: 1, c_list: 2}
	enum status: { initial: 0, verified: 1, qualified: 2, disqualified: 3, inactive: 4, active: 5}

  has_one :user

  def owner?(user)
    self.user_id == user.id
  end
end
