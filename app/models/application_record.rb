class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
  
  def self.selector(label, field)
    if field && !field.empty?
      where("#{label} = #{field}")
    else
      all
    end
  end
  
  def self.includer(label, field)
    label = label.to_s
    if field && !field.empty?
      where("#{label} like ?", "%#{field}%") #MySQL
      # where("cast(#{label} as text) like ?", "%#{field}%") #PostgreSQL
    else
      all
    end
  end
end
