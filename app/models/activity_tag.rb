# == Schema Information
#
# Table name: activity_tags
#
#  id         :integer          not null, primary key
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class ActivityTag < ApplicationRecord
  validates_presence_of :name
end
