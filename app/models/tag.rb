# app/models/tag.rb

class DuplicateTagError < StandardError; end


class Tag < ActiveRecord::Base

  include Concerns::AsEnum

  enum as: as_enum

  belongs_to :for, polymorphic: true
  belongs_to :user
  has_many :taggings, dependent: :destroy

  #validates_presence_of :as

  validates_presence_of :name
  #validates_uniqueness_of :name, if: :validates_name_uniqueness?
  validates_length_of :name, maximum: 128

  # def validates_name_uniqueness?
  #   true
  # end

  scope :most_used, ->(limit = 20) { order('taggings_count desc').limit(limit) }
  scope :least_used, ->(limit = 20) { order('taggings_count asc').limit(limit) }

  scope :tagged_as_any, ->(as = ['type']) { where(as: as_code(as)) }
  scope :tagged_as, ->(as = 'type') { tagged_as_any(as) }

  scope :user_is, ->(user) { where(user: user) }
  scope :no_user, -> { where(user_id: nil) }

  class << self

    def search(query)
      query = "%#{query}%"
      name = arel_table[:name].matches(query)
      aliases = arel_table[:aliases].matches(query)
      description = arel_table[:description].matches(query)
      where(name.or(aliases).or(description))
    end

    def named(name)
      where(arel_table[:name].matches(name.gsub(/[%_]/, '\\\\\0'),true))
    end

    def named_any(list)
      where(arel_table[:name].matches_any(list.map {|e| e.gsub(/[%_]/, '\\\\\0')},true))
    end

    def named_like(name)
      where(arel_table[:name].matches("%#{name.gsub(/[%_]/, '\\\\\0')}%",true))
    end

    def named_like_any(list)
      where(arel_table[:name].matches_any(list.map {|e| "%#{e.gsub(/[%_]/, '\\\\\0')}%"},true))
    end

    def find_or_create(as, name, description=nil, user_id=nil)
      Tag.where(as: as, name: name, description: description, user_id: user_id).first || create(as: as, name: name, description: description, user_id: user_id)
    end

    def find_or_create_with_like_by_name(name)
      named_like(name).first || create(name: name)
    end

    def find_or_create_all_with_like_by_name(*list)
      list = Array(list).flatten

      return [] if list.empty?

      existing_tags = named_any(list)

      list.map do |tag_name|
        comparable_tag_name = comparable_name(tag_name)
        existing_tag = existing_tags.find { |tag| comparable_name(tag.name) == comparable_tag_name }
        begin
          existing_tag || create(name: tag_name)
        rescue ActiveRecord::RecordNotUnique
          # Postgres aborts the current transaction with
          # PG::InFailedSqlTransaction: ERROR:  current transaction is aborted, commands ignored until end of transaction block
          # so we have to rollback this transaction
          raise DuplicateTagError.new("'#{tag_name}' has already been taken")
        end
      end
    end

    private

    def comparable_name(str)
      unicode_downcase(str.to_s)
    end

    def unicode_downcase(string)
      if ActiveSupport::Multibyte::Unicode.respond_to?(:downcase)
        ActiveSupport::Multibyte::Unicode.downcase(string)
      else
        ActiveSupport::Multibyte::Chars.new(string).downcase.to_s
      end
    end

    def as_8bit_ascii(string)
      if defined?(Encoding)
        string.to_s.dup.force_encoding('BINARY')
      else
        string.to_s.mb_chars
      end
    end

    def sanitize_sql_for_named_any(tag)
      sanitize_sql(['LOWER(name) = LOWER(?)', as_8bit_ascii(unicode_downcase(tag))])
    end

  end # class << self

  def ==(object)
    super || (object.is_a?(Tag) && name == object.name)
  end

  def to_s
    name
  end

  def count
    read_attribute(:count).to_i
  end

  def owner?(user)
    self.user_id == user.id
  end

  def unowned?
    self.user_id.nil?
  end


end