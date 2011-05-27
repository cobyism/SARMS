class PerformancesController < ApplicationController
  
  before_filter :find_performance, :except => [:index, :new, :create]
  before_filter :find_enrollment
  before_filter :find_assessments
  
  # GET /performances
  # GET /performances.xml
  def index
    @performances = Performance.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @performances }
    end
  end

  # GET /performances/1
  # GET /performances/1.xml
  def show
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @performance }
    end
  end

  # GET /performances/new
  # GET /performances/new.xml
  def new
    @performance = @enrollment.performances.build

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @performance }
    end
  end

  # GET /performances/1/edit
  def edit
  end

  # POST /performances
  # POST /performances.xml
  def create
    @performance = Performance.new(params[:performance])

    respond_to do |format|
      if @performance.save
        format.html { redirect_to(@performance, :notice => 'Performance was successfully created.') }
        format.xml  { render :xml => @performance, :status => :created, :location => @performance }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @performance.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /performances/1
  # PUT /performances/1.xml
  def update
    respond_to do |format|
      if @performance.update_attributes(params[:performance])
        format.html { redirect_to(@performance, :notice => 'Performance was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @performance.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /performances/1
  # DELETE /performances/1.xml
  def destroy
    @performance.destroy

    respond_to do |format|
      format.html { redirect_to(performances_url) }
      format.xml  { head :ok }
    end
  end
  
  private
  
  def find_performance
    @performance = Performance.find(params[:id])
  end
    
  def find_enrollment
    if params[:enrollment_id]
      @enrollment = Enrollment.find(params[:enrollment_id])
    else
      if params[:id]
        @performance = Performance.find(params[:id])
        @enrollment = @performance.enrollment
      else
        @enrollment = nil
      end
    end
  end
  
  def find_assessments
    if @enrollment
      @assessments = @enrollment.unit.assessments.all
    end
  end
end
