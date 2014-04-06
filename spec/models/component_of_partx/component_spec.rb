require 'spec_helper'

module ComponentOfPartx
  describe Component do
    it "should be OK" do
      c = FactoryGirl.build(:component_of_partx_component)
      c.should be_valid
    end
    
    it "should reject nil name" do
      c = FactoryGirl.build(:component_of_partx_component, :name => nil)
      c.should_not be_valid
    end
    
    it "should reject nil unit" do
      c = FactoryGirl.build(:component_of_partx_component, :unit => nil)
      c.should_not be_valid
    end
    
    it "should reject dup name for same project and manufacturer" do
      c = FactoryGirl.create(:component_of_partx_component, :name => "nil")
      c1 = FactoryGirl.build(:component_of_partx_component, :name => "Nil", :part_id => c.part_id)
      c1.should_not be_valid
    end
    
    it "should take 0 qty" do
      c = FactoryGirl.build(:component_of_partx_component, :qty => 0)
      c.should be_valid
    end
    
    it "should reject 0 partt_id" do
      c = FactoryGirl.build(:component_of_partx_component, :part_id => 0)
      c.should_not be_valid
    end

  end
end
