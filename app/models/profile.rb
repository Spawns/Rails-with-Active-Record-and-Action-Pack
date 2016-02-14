class Profile < ActiveRecord::Base
  belongs_to :user

  validates :gender, inclusion: { in: %w(male female) }
  validate :names
  validate :male_named_sue

  def names
  	if first_name.nil? && last_name.nil?
  	  errors.add(:first_name, "first_name and last_name both could not be null at a time")
  	end
  end

  def male_named_sue
  	if first_name == "Sue" && gender == "male"
  	  errors.add(:gender, "Why would a 'Male' have a name 'Sue' ? ")
  	end
  end

  def self.get_all_profiles(min,max)
    Profile.where("birth_year BETWEEN ? AND ?",min, max).order(birth_year: :asc)  
  end
end