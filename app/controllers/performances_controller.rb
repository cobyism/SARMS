class PerformancesController < ApplicationController
  
  before_filter :find_performance, :except => [:index, :new, :create]
  before_filter :find_enrollment
  before_filter :find_enrollments
  before_filter :find_assessment
  before_filter :find_assessments
  before_filter :find_unit
  before_filter :set_tab
  
  # GET /performances
  # GET /performances.xml
  def index
    @performances = Performance.all
    if @enrollment
      @performance = @enrollment.performances.build
    elsif
      @performance = @assessment.performances.build
    end

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
    @performance = @assessment.performances.build
    @enrollment = Enrollment.find(params[:enrollment_id])
    @performance.enrollment_id = @enrollment.id
    if @enrollment
      @form_object = [@enrollment, @performance]
    else
      @form_object = @performance
    end

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
        format.html { redirect_to(enrollment_performances_path(@enrollment), :notice => 'Performance was successfully created.') }
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
      format.html { redirect_to(enrollment_performances_path(@enrollment), :notice => "Result was successfully removed.") }
      format.xml  { head :ok }
    end
  end
  
  private
  
  def find_performance
    if params[:id] != 'new'
      @performance = Performance.find(params[:id])
    end
  end
    
  def find_enrollment
    if params[:enrollment_id]
      @enrollment = Enrollment.find(params[:enrollment_id])
    elsif params[:assessment_id]
      @assessment = Assessment.find(params[:assessment_id])
      @enrollment = @assessment.enrollment
    else
      if params[:id]
        @performance = Performance.find(params[:id])
        @enrollment = @performance.enrollment
      else
        @enrollment = nil
      end
    end
  end
  
  def find_assessment
    if params[:assessment_id]
      @assessment = Assessment.find(params[:assessment_id])
      @enrollment = @assessment.enrollment
    end
  end
  
  def find_assessments
    if @enrollment
      @assessments = @enrollment.unit.assessments.all
    end
    if params[:enrollment_id]
      @assessments = Enrollment.find(params[:enrollment_id]).unit.assessments.all
    end
  end
  
  def find_enrollments
    if @assessment
      @enrollments = @assessment.unit.enrollments.all
    end
  end
  
  def find_unit
    if @assessment
      @unit = @assessment.unit
    end
  end
  
  def set_tab
    @tab = 'units'
  end
end
