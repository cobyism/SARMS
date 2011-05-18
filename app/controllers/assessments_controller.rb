class AssessmentsController < ApplicationController
  # GET /assessments
  # GET /assessments.xml
  def index
    @assessments = Assessment.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @assessments }
    end
  end

  # GET /assessments/1
  # GET /assessments/1.xml
  def show
    @assessment = Assessment.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @assessment }
    end
  end

  # GET /assessments/new
  # GET /assessments/new.xml
  def new
    @assessment = Assessment.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @assessment }
    end
  end

  # GET /assessments/1/edit
  def edit
    @assessment = Assessment.find(params[:id])
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
      format.html { redirect_to(assessments_url) }
      format.xml  { head :ok }
    end
  end
end
