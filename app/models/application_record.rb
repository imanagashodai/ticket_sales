class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
  
  def self.selector(label, field)
    if field && !field.empty?
      where("#{label} = #{field}")
    else
      all
    end
  end
  
  def self.created_selector(date)
    if date && !date.empty?
      where(created_at: date.in_time_zone.all_day)
    else
      all
    end
  end
  
  def self.updated_selector(date)
    if date && !date.empty?
      where(updated_at: date.in_time_zone.all_day)
    else
      all
    end
  end
  
  def self.datetime_selector(date)
    if date && !date.empty?
      where(datetime: date.in_time_zone.all_day)
    else
      all
    end
  end
  
  def self.includer(label, field)
    if field && !field.empty?
      where("#{label} like '%#{field}%'")
    else
      all
    end
  end
end
