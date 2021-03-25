class Team < ApplicationRecord
  validates :name, presence: true
  belongs_to :ground, optional: true
  
  def self.selector(label, field)
    if field && !field.empty?
      where("#{label} = #{field}")
    else
      all
    end
  end
  
  def self.includer(label, field)
    if field && !field.empty?
      # where("#{label} like ?", "%#{field}%") #MySQL
      where("cast(#{label} as text) like ?", "%#{field}%") #PostgreSQL
    else
      all
    end
  end
end
