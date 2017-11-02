class BuildingsController < ApplicationController
  helper_method :filter_rooms

  def index

  end

  def filter
    filter_rooms
    
    ret = []
    @rooms.select(:building_id).group(:building_id).each do |data|
      building_name = Building.find_by_id(data.building_id).name
      ret << ({id: data.building_id, name: building_name})
    end
    render json: ret 
  end
  
  def search
  end
  
  def session_helper_user_id
      session[:user_id]
  end
  
  def show
    if session_helper_user_id == nil
      flash[:notice] = "Please log in."
      redirect_to buildings_path
      return
    end
    
    filter_rooms
    building_id = params[:id] 
    @building = Building.find_by_id(building_id)
    
    if @building.blank?
      flash[:notice] = "This building does not exist."
      redirect_to buildings_path
    end
    
    @rooms = @rooms.where(:building_id => building_id)
    @rooms.each do |room|
      if room.misc == nil then room.misc = "N/A" end
      if room.facilities == nil then room.facilities = "N/A" end
    end
  end
  
  def filter_rooms
    @rooms = Room.all
    if params[:StudentAccessible]
      @rooms = @rooms.where("facilities LIKE '%ADA-Student Accessible%'")
    end
    if params[:Whiteboard]
      @rooms = @rooms.where("facilities LIKE '%Board-White%' OR facilities LIKE '%Board-Front%' OR facilities LIKE '%Board-Chalk%'")
    end
    if params[:AV]
      @rooms = @rooms.where("facilities LIKE '%AV%'")
    end
    if params.key?(:room_type)
      if params[:room_type] != "Any"
        @rooms = @rooms.where(:misc => params[:room_type])
      end
    end
    if params.key?(:capacity) and params[:capacity] != "Any"
      low, high = params[:capacity].split(",")
      @rooms = @rooms.where("capacity >= ?", low.to_i)
      if high != "-"
        @rooms = @rooms.where("capacity <= ?", high.to_i)
      end
    end
  end
  
end
