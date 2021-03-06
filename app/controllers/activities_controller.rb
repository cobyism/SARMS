class ActivitiesController < ApplicationController
  
  before_filter :authenticate_user!
  before_filter :find_activity, :except => [:index, :new, :create]
  before_filter :find_unit
  before_filter :set_tab
  
  # GET /activities
  # GET /activities.xml
  def index
    @activities = Activity.all
    if params[:unit_id]
      @activities = @unit.activities
    end

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @activities }
    end
  end

  # GET /activities/1
  # GET /activities/1.xml
  def show
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @activity }
    end
  end

  # GET /activities/new
  # GET /activities/new.xml
  def new
    @activity = @unit.activities.build

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @activity }
    end
  end

  # GET /activities/1/edit
  def edit
  end

  # POST /activities
  # POST /activities.xml
  def create
    @activity = Activity.new(params[:activity])

    respond_to do |format|
      if @activity.save
        format.html { redirect_to(@activity, :notice => 'Activity was successfully created.') }
        format.xml  { render :xml => @activity, :status => :created, :location => @activity }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @activity.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /activities/1
  # PUT /activities/1.xml
  def update
    respond_to do |format|
      if @activity.update_attributes(params[:activity])
        format.html { redirect_to(@activity, :notice => 'Activity was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @activity.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /activities/1
  # DELETE /activities/1.xml
  def destroy
    @activity.destroy

    respond_to do |format|
      format.html { redirect_to(unit_activities_path(@unit), :notice => 'Activity was successfully deleted.') }
      format.xml  { head :ok }
    end
  end
  
  private
  
  def find_activity
    @activity = Activity.find(params[:id])
  end
    
  def find_unit
    if params[:unit_id]
      @unit = Unit.find(params[:unit_id])
    else
      if params[:id]
        @activity = Activity.find(params[:id])
        @unit = @activity.unit
      else
        @unit = nil
      end
    end
  end
  
  def set_tab
    @tab = 'units'
  end
end
