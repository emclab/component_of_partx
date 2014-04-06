require_dependency "component_of_partx/application_controller"

module ComponentOfPartx
  class ComponentsController < ApplicationController
    before_filter :require_employee
    before_filter :load_parent_record
        
    def index
      @title = t('Components')
      @components = params[:component_of_partx_components][:model_ar_r]  #returned by check_access_right
      @components = @components.where(:part_id => @part.id) if @part       
      @components = @components.page(params[:page]).per_page(@max_pagination) 
      @erb_code = find_config_const('component_index_view', 'component_of_partx')
    end
  
    def new
      @title = t('New Component')
      @component = ComponentOfPartx::Component.new()
      @qty_unit = find_config_const('piece_unit').split(',').map(&:strip)
      @erb_code = find_config_const('component_new_view', 'component_of_partx')
    end
  
    def create
      @component = ComponentOfPartx::Component.new(params[:component], :as => :role_new)
      @component.last_updated_by_id = session[:user_id]
      if @component.save
        redirect_to URI.escape(SUBURI + "/authentify/view_handler?index=0&msg=Successfully Saved!")
      else
        @part = ComponentOfPartx.part_class.find_by_id(params[:component][:part_id]) if params[:component].present? && params[:component][:part_id].present?
        @qty_unit = find_config_const('piece_unit').split(',').map(&:strip)
        flash[:notice] = t('Data Error. Not Saved!')
        render 'new'
      end
    end
  
    def edit
      @title = t('Update Component')
      @component = ComponentOfPartx::Component.find_by_id(params[:id])
      @qty_unit = find_config_const('piece_unit').split(',').map(&:strip)
      @erb_code = find_config_const('component_edit_view', 'component_of_partx')
    end
  
    def update
      @component = ComponentOfPartx::Component.find_by_id(params[:id])
      @component.last_updated_by_id = session[:user_id]
      if @component.update_attributes(params[:component], :as => :role_update)
        redirect_to URI.escape(SUBURI + "/authentify/view_handler?index=0&msg=Successfully Updated!")
      else
        @part = ComponentOfPartx.part_class.find_by_id(params[:component][:part_id]) if params[:component].present? && params[:component][:part_id].present?
        @qty_unit = find_config_const('piece_unit').split(',').map(&:strip)
        flash[:notice] = t('Data Error. Not Updated!')
        render 'edit'
      end
    end
  
    protected
    def load_parent_record
      @part = ComponentOfPartx.part_class.find_by_id(params[:part_id]) if params[:part_id].present?
      @part = ComponentOfPartx.part_class.find_by_id(ComponentOfPartx::Component.find_by_id(params[:id]).part_id) if params[:id].present?
    end
  end
end
