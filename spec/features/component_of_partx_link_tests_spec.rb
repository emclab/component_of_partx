require 'spec_helper'

describe "LinkTests" do
  describe "GET /component_of_partx_link_tests" do
    mini_btn = 'btn btn-mini '
    ActionView::CompiledTemplates::BUTTONS_CLS =
        {'default' => 'btn',
         'mini-default' => mini_btn + 'btn',
         'action'       => 'btn btn-primary',
         'mini-action'  => mini_btn + 'btn btn-primary',
         'info'         => 'btn btn-info',
         'mini-info'    => mini_btn + 'btn btn-info',
         'success'      => 'btn btn-success',
         'mini-success' => mini_btn + 'btn btn-success',
         'warning'      => 'btn btn-warning',
         'mini-warning' => mini_btn + 'btn btn-warning',
         'danger'       => 'btn btn-danger',
         'mini-danger'  => mini_btn + 'btn btn-danger',
         'inverse'      => 'btn btn-inverse',
         'mini-inverse' => mini_btn + 'btn btn-inverse',
         'link'         => 'btn btn-link',
         'mini-link'    => mini_btn +  'btn btn-link'
        }
    before(:each) do
      @pagination_config = FactoryGirl.create(:engine_config, :engine_name => nil, :engine_version => nil, :argument_name => 'pagination', :argument_value => 30)
      piece_unit = FactoryGirl.create(:engine_config, :engine_name => nil, :engine_version => nil, :argument_name => 'piece_unit', :argument_value => "set, piece")
      z = FactoryGirl.create(:zone, :zone_name => 'hq')
      type = FactoryGirl.create(:group_type, :name => 'employee')
      ug = FactoryGirl.create(:sys_user_group, :user_group_name => 'ceo', :group_type_id => type.id, :zone_id => z.id)
      @role = FactoryGirl.create(:role_definition)
      ur = FactoryGirl.create(:user_role, :role_definition_id => @role.id)
      ul = FactoryGirl.build(:user_level, :sys_user_group_id => ug.id)
      @u = FactoryGirl.create(:user, :user_levels => [ul], :user_roles => [ur])
      
      user_access = FactoryGirl.create(:user_access, :action => 'index', :resource =>'component_of_partx_components', :role_definition_id => @role.id, :rank => 1,
        :sql_code => "ComponentOfPartx::Component.order('created_at DESC')")
        
        
      user_access = FactoryGirl.create(:user_access, :action => 'create', :resource => 'component_of_partx_components', :role_definition_id => @role.id, :rank => 1,
        :sql_code => "")
      user_access = FactoryGirl.create(:user_access, :action => 'create', :resource =>'component_of_partx_components', :role_definition_id => @role.id, :rank => 1,
        :sql_code => "")
      user_access = FactoryGirl.create(:user_access, :action => 'update', :resource =>'component_of_partx_components', :role_definition_id => @role.id, :rank => 1,
        :sql_code => "")
      user_access = FactoryGirl.create(:user_access, :action => 'update', :resource =>'component_of_partx_components', :role_definition_id => @role.id, :rank => 1,
        :sql_code => "")
      user_access = FactoryGirl.create(:user_access, :action => 'show', :resource =>'component_of_partx_components', :role_definition_id => @role.id, :rank => 1,
        :sql_code => "record.last_updated_by_id == session[:user_id]")
      
        
      #@pur_sta = FactoryGirl.create(:commonx_misc_definition, 'for_which' => 'bom_status')
      @part = FactoryGirl.create(:sourced_partx_part) 
      
      visit '/'
      #save_and_open_page
      fill_in "login", :with => @u.login
      fill_in "password", :with => @u.password
      click_button 'Login'
    end
    it "works! (now write some real specs)" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      task = FactoryGirl.create(:component_of_partx_component, :part_id => @part.id, :last_updated_by_id => @u.id)
      visit components_path
      #save_and_open_page
      page.should have_content('Components')
      click_link 'Edit'
      page.should have_content('Edit Component')
      save_and_open_page
      fill_in 'component_name', :with => 'a test bom'
      click_button 'Save'
      #should no error if data is wrong in edit
      visit components_path
      #save_and_open_page
      page.should have_content('Components')
      click_link 'Edit'
      page.should have_content('Edit Component')
      save_and_open_page
      fill_in 'component_name', :with => ''
      click_button 'Save'
      save_and_open_page
      
      visit new_component_path(:part_id => @part.id)
      save_and_open_page
      page.should have_content('New Component')
      fill_in 'component_name', :with => 'a test bom'
      fill_in 'component_spec', :with => 'a test spec'
      fill_in 'component_qty', :with => 100
      select('piece', :from => 'component_unit')
      click_button 'Save'
      #with data error in new
      visit new_component_path(:part_id => @part.id)
      save_and_open_page
      page.should have_content('New Component')
      fill_in 'component_name', :with => ''
      fill_in 'component_spec', :with => 'a test spec'
      fill_in 'component_qty', :with => 100
      select('piece', :from => 'component_unit')
      click_button 'Save'
      save_and_open_page
    end
  end
end
