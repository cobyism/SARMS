class ResponsesController < ApplicationController
  
  before_filter :authenticate_user!
  before_filter :find_at_risk_event
  before_filter :set_tab
  
  # GET /responses
  # GET /responses.xml
  def index
    @responses = Response.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @responses }
    end
  end

  # GET /responses/1
  # GET /responses/1.xml
  def show
    @response = Response.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @response }
    end
  end

  # GET /responses/new
  # GET /responses/new.xml
  def new
    @response = @at_risk_event.responses.build

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @response }
    end
  end

  # GET /responses/1/edit
  def edit
    @response = Response.find(params[:id])
  end

  # POST /responses
  # POST /responses.xml
  def create
    @response = Response.new(params[:response])
    @enrollment = @response.at_risk_event.enrollment

    respond_to do |format|
      if @response.save
        format.html { redirect_to(@enrollment, :notice => 'Response was successfully created.') }
        format.xml  { render :xml => @response, :status => :created, :location => @response }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @response.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /responses/1
  # PUT /responses/1.xml
  def update
    @response = Response.find(params[:id])

    respond_to do |format|
      if @response.update_attributes(params[:response])
        format.html { redirect_to(@response, :notice => 'Response was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @response.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /responses/1
  # DELETE /responses/1.xml
  def destroy
    @response = Response.find(params[:id])
    @enrollment = @response.at_risk_event.enrollment
    @response.destroy

    respond_to do |format|
      format.html { redirect_to(@enrollment, :notice => 'Response was successfully removed.') }
      format.xml  { head :ok }
    end
  end
  
  private
  
  def find_at_risk_event
    if params[:at_risk_event_id]
      @at_risk_event = AtRiskEvent.find(params[:at_risk_event_id])
      @enrollment = @at_risk_event.enrollment
    end
  end
  
  def set_tab
    @tab = 'units'
  end
end
