class Client < ActiveRecord::Base

	enum level: { a_list: 0, b_list: 1, c_list: 2}
	enum status: { initial: 0, verified: 1, qualified: 2, disqualified: 3, inactive: 4, active: 5}

  dragonfly_accessor :image

  belongs_to :user

  scope :user_is, ->(user) { where(user: user) }
  scope :no_user, -> { where(user_id: nil) }

  class << self

    def search(query)
		  query = "%#{query}%"
		  first_names = arel_table[:first_name].matches(query)
		  last_name = arel_table[:last_name].matches(query)
		  where(first_name.or(last_name))
		end

	end # class << self

  def owner?(user)
    self.user_id == user.id
  end

  # image as dragonfly attachment with static fallback
  # so you can chain :process, :thumb, :url, etc.
  # @return [Dragonfly::Attachment]
  def image_attachment
    if self.image && self.image.image
      self.image
    else
      Dragonfly.app(:static).fetch_file(File.join(Rails.root, 'app/assets/images/client-no-image.png'))
    end
  end
end
