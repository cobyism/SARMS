class AtRiskEventsController < ApplicationController
  
  before_filter :find_enrollment, :only => [:new, :create]
  
  # GET /at_risk_events
  # GET /at_risk_events.xml
  def index
    @at_risk_events = AtRiskEvent.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @at_risk_events }
    end
  end
  
  # GET /at_risk_events
  # GET /at_risk_events.xml
  def monitor
    @units = Unit.all
    @at_risk_event = AtRiskEvent.new

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @at_risk_events }
    end
  end

  # GET /at_risk_events/1
  # GET /at_risk_events/1.xml
  def show
    @at_risk_event = AtRiskEvent.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @at_risk_event }
    end
  end

  # GET /at_risk_events/new
  # GET /at_risk_events/new.xml
  def new
    @at_risk_event = @enrollment.at_risk_events.build

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @at_risk_event }
    end
  end

  # GET /at_risk_events/1/edit
  def edit
    @at_risk_event = AtRiskEvent.find(params[:id])
  end

  # POST /at_risk_events
  # POST /at_risk_events.xml
  def create
    @at_risk_event = AtRiskEvent.new(params[:at_risk_event])

    respond_to do |format|
      if @at_risk_event.save
        format.html { redirect_to(monitor_at_risk_events_path, :notice => 'User was successfully notified.') }
        format.xml  { render :xml => @at_risk_event, :status => :created, :location => @at_risk_event }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @at_risk_event.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /at_risk_events/1
  # PUT /at_risk_events/1.xml
  def update
    @at_risk_event = AtRiskEvent.find(params[:id])

    respond_to do |format|
      if @at_risk_event.update_attributes(params[:at_risk_event])
        format.html { redirect_to(@at_risk_event, :notice => 'At risk event was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @at_risk_event.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /at_risk_events/1
  # DELETE /at_risk_events/1.xml
  def destroy
    @at_risk_event = AtRiskEvent.find(params[:id])
    @at_risk_event.destroy

    respond_to do |format|
      format.html { redirect_to(monitor_at_risk_events_path, :notice => 'Notification was successfully cancelled.') }
      format.xml  { head :ok }
    end
  end
  
  private
  
  def find_enrollment
    if params[:enrollment_id]
      @enrollment = Enrollment.find(params[:enrollment_id])
    end
  end
end
