require_relative "../config/environment.rb"
require 'active_support/inflector'

class InteractiveRecord
  
  def self.table_name
    self.to_s.downcase.pluralize
  end
  
  def self.column_names
    DB[:conn].results_as_hash = true 
    sql = "pragma table_info('#{table_name}')"
    table_info = DB[:conn].execute(sql)
    columns = []
    
    table_info.each do |col|
      columns << col["name"]
    end
    columns.compact
  end
  
  def initialize(attrib = {})
      attrib.each do |key, value|
        self.send("#{key}=",value)
      end
  end
  
  def table_name_for_insert
    self.class.table_name
  end
    
    
end