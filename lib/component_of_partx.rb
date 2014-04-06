require "component_of_partx/engine"

module ComponentOfPartx
  mattr_accessor :part_class, :show_part_path
  
  def self.part_class
    @@part_class.constantize
  end
end
