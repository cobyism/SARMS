class FacultyAssignmentsController < ApplicationController
  # GET /faculty_assignments
  # GET /faculty_assignments.xml
  def index
    @faculty_assignments = FacultyAssignment.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @faculty_assignments }
    end
  end

  # GET /faculty_assignments/1
  # GET /faculty_assignments/1.xml
  def show
    @faculty_assignment = FacultyAssignment.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @faculty_assignment }
    end
  end

  # GET /faculty_assignments/new
  # GET /faculty_assignments/new.xml
  def new
    @faculty_assignment = FacultyAssignment.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @faculty_assignment }
    end
  end

  # GET /faculty_assignments/1/edit
  def edit
    @faculty_assignment = FacultyAssignment.find(params[:id])
  end

  # POST /faculty_assignments
  # POST /faculty_assignments.xml
  def create
    @faculty_assignment = FacultyAssignment.new(params[:faculty_assignment])

    respond_to do |format|
      if @faculty_assignment.save
        format.html { redirect_to(@faculty_assignment, :notice => 'Faculty assignment was successfully created.') }
        format.xml  { render :xml => @faculty_assignment, :status => :created, :location => @faculty_assignment }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @faculty_assignment.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /faculty_assignments/1
  # PUT /faculty_assignments/1.xml
  def update
    @faculty_assignment = FacultyAssignment.find(params[:id])

    respond_to do |format|
      if @faculty_assignment.update_attributes(params[:faculty_assignment])
        format.html { redirect_to(@faculty_assignment, :notice => 'Faculty assignment was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @faculty_assignment.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /faculty_assignments/1
  # DELETE /faculty_assignments/1.xml
  def destroy
    @faculty_assignment = FacultyAssignment.find(params[:id])
    @faculty_assignment.destroy

    respond_to do |format|
      format.html { redirect_to(faculty_assignments_url) }
      format.xml  { head :ok }
    end
  end
end
