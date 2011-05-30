class AttendancesController < ApplicationController
  
  before_filter :find_attendance, :except => [:index, :new, :create]
  before_filter :find_enrollment
  before_filter :find_activity
  before_filter :find_enrollments
  before_filter :find_activities
  before_filter :find_unit
  before_filter :set_tab
  
  # GET /attendances
  # GET /attendances.xml
  def index
    @attendances = Attendance.all
    if @enrollment
      @attendance = @enrollment.attendances.build
    elsif @activity
      @attendance = @activity.attendances.build
    end

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @attendances }
    end
  end

  # GET /attendances/1
  # GET /attendances/1.xml
  def show
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @attendance }
    end
  end

  # GET /attendances/new
  # GET /attendances/new.xml
  def new
    @attendance = @enrollment.attendances.build

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @attendance }
    end
  end

  # GET /attendances/1/edit
  def edit
  end

  # POST /attendances
  # POST /attendances.xml
  def create
    @attendance = Attendance.new(params[:attendance])

    respond_to do |format|
      if @attendance.save
        if @activity
          format.html { redirect_to(activity_attendances_path(@activity), :notice => 'Attendance was successfully created.') }
        else
          format.html { redirect_to(enrollment_attendances_path(@enrollment), :notice => 'Attendance was successfully created.') }
        end
        format.xml  { render :xml => @attendance, :status => :created, :location => @attendance }
      else
        format.html { redirect_to(enrollment_attendances_path(@enrollment), :alert => 'That student is already marked as attended for that activity.') }
        format.xml  { render :xml => @attendance.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /attendances/1
  # PUT /attendances/1.xml
  def update
    respond_to do |format|
      if @attendance.update_attributes(params[:attendance])
        format.html { redirect_to(@attendance, :notice => 'Attendance was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @attendance.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /attendances/1
  # DELETE /attendances/1.xml
  def destroy
    @attendance.destroy

    respond_to do |format|
      if @activity
        format.html { redirect_to(activity_attendances_path(@activity), :notice => 'Attendance was successfully deleted.') }
      else
        format.html { redirect_to(enrollment_attendances_path(@enrollment), :notice => 'Attendance was successfully deleted.') }
      end
      format.xml  { head :ok }
    end
  end
  
  private
  
  def find_attendance
    @attendance = Attendance.find(params[:id])
  end
    
  def find_enrollment
    if params[:enrollment_id]
      @enrollment = Enrollment.find(params[:enrollment_id])
    else
      if params[:id]
        @attendance = Attendance.find(params[:id])
        @enrollment = @attendance.enrollment
      else
        @enrollment = nil
      end
    end
  end
  
  def find_activities
    if @enrollment
      @activities = @enrollment.unit.activities.all
    end
  end
  
  def find_activity
    if params[:activity_id]
      @activity = Activity.find(params[:activity_id])
    else
      if params[:id]
        @attendance = Attendance.find(params[:id])
        @activity = @attendance.activity
      else
        @activity = nil
      end
    end
  end
  
  def find_enrollments
    if @activity
      @enrollments = @activity.unit.enrollments.all
    end
  end
  
  def find_unit
    if @activity
      @unit = @activity.unit
    end
  end
  
  def set_tab
    @tab = 'units'
  end
end
