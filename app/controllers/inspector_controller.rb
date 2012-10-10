require 'coderay'
class InspectorController < ApplicationController
  layout "graffity_layout"

  def index
  end

  def current_items
    graffity_action = Graffity::Action.reverse_order(:start).first
    if graffity_action
      @title = "#{graffity_action.controller}##{graffity_action.name}"
      @graffity_template = Graffity::Template.where(:req_id => graffity_action.req_id, :partial => false).first
      @graffity_partials = Graffity::Template.where(:req_id => graffity_action.req_id, :partial => true)
    end
    render :current_items, :layout => false
  end

  def coderay
    @graffity_template = Graffity::Template.where(:id => params[:id]).first
    render :coderay, :layout => false
  end

end