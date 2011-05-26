class FacultyAssignmentsController < ApplicationController
  
  before_filter :find_faculty_assignment, :except => [:index, :new, :create]
  before_filter :find_user
  before_filter :find_units, :only => [:new, :edit]
  
  # GET /faculty_assignments
  # GET /faculty_assignments.xml
  def index
    @faculty_assignments = FacultyAssignment.all
    if params[:user_id]
      @faculty_assignments = @user.faculty_assignments
    end

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @faculty_assignments }
    end
  end

  # GET /faculty_assignments/1
  # GET /faculty_assignments/1.xml
  def show

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

  # POST /faculty_assignments
  # POST /faculty_assignments.xml
  def create
    @faculty_assignment = FacultyAssignment.new(params[:faculty_assignment])

    respond_to do |format|
      if @faculty_assignment.save
        format.html { redirect_to(user_faculty_assignments_path(@user), :notice => 'Faculty assignment was successfully created.') }
        format.xml  { render :xml => @faculty_assignment, :status => :created, :location => @faculty_assignment }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @faculty_assignment.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /faculty_assignments/1
  # DELETE /faculty_assignments/1.xml
  def destroy
    @faculty_assignment.destroy

    respond_to do |format|
      format.html { redirect_to(user_faculty_assignments_url(@user), :notice => 'Faculty assignment was successfully deleted.') }
      format.xml  { head :ok }
    end
  end
  
  private
  
  def find_faculty_assignment
    @faculty_assignment = FacultyAssignment.find(params[:id])
  end
  
  def find_units
    @units = Unit.all
  end
  
  def find_user
    if params[:user_id]
      @user = User.find(params[:user_id])
    else
      if params[:id]
        @user = @faculty_assignment.user
      else
        @user = nil
      end
    end
  end
  
end
