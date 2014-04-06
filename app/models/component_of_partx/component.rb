module ComponentOfPartx
  class Component < ActiveRecord::Base
    attr_accessor :part_name, :part_id_noupdate
    attr_accessible :last_updated_by_id, :name, :part_id, :qty, :spec, :unit, :production_start_date, :production_finish_date,
                    :part_name,
                    :as => :role_new
    attr_accessible :last_updated_by_id, :name, :qty, :spec, :unit, :production_start_date, :production_finish_date,
                    :part_name, :part_id_noupdate,
                    :as => :role_update   
                    
    belongs_to :part, :class_name => ComponentOfPartx.part_class.to_s
    belongs_to :last_updated_by, :class_name => 'Authentify::User'
    
    validates_presence_of :name, :qty, :unit 
    validates :part_id, :numericality => {:greater_than => 0, :only_integer => true}
    validates :qty, :numericality => {:greater_than_or_equal_to => 0, :only_integer => true}
    validates :name, :uniqueness => {:scope => :part_id, :case_sensitive => false, :message => I18n.t('No duplicate name')}  
    validate :dynamic_validate 
    
    def dynamic_validate
      wf = Authentify::AuthentifyUtility.find_config_const('dynamic_validate', 'component_of_partx')
      eval(wf) if wf.present?
    end           
  end
end
