class AssessmentsController < ApplicationController
  
  before_filter :find_assessment, :except => [:index, :new, :create]
  before_filter :find_unit
  before_filter :set_tab
  
  # GET /assessments
  # GET /assessments.xml
  def index
    @assessments = Assessment.all
    if params[:unit_id]
      @assessments = @unit.assessments
    end

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @assessments }
    end
  end

  # GET /assessments/1
  # GET /assessments/1.xml
  def show

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @assessment }
    end
  end

  # GET /assessments/new
  # GET /assessments/new.xml
  def new
    @assessment = @unit.assessments.build

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @assessment }
    end
  end

  # GET /assessments/1/edit
  def edit
  end

  # POST /assessments
  # POST /assessments.xml
  def create
    @assessment = Assessment.new(params[:assessment])

    respond_to do |format|
      if @assessment.save
        format.html { redirect_to(@assessment, :notice => 'Assessment was successfully created.') }
        format.xml  { render :xml => @assessment, :status => :created, :location => @assessment }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @assessment.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /assessments/1
  # PUT /assessments/1.xml
  def update
    @assessment = Assessment.find(params[:id]) 

    respond_to do |format|
      if @assessment.update_attributes(params[:assessment])
        format.html { redirect_to(@assessment, :notice => 'Assessment was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @assessment.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /assessments/1
  # DELETE /assessments/1.xml
  def destroy
    @assessment = Assessment.find(params[:id])
    @assessment.destroy

    respond_to do |format|
      format.html { redirect_to(unit_assessments_path(@unit), :notice => 'Assessment was successfully deleted.') }
      format.xml  { head :ok }
    end
  end
  
  
  private
  
  def find_assessment
    @assessment = Assessment.find(params[:id])
  end
    
  def find_unit
    if params[:unit_id]
      @unit = Unit.find(params[:unit_id])
    else
      if params[:id]
        @assessment = Assessment.find(params[:id])
        @unit = @assessment.unit
      else
        @unit = nil
      end
    end
  end
  
  def set_tab
    @tab = 'units'
  end
end
