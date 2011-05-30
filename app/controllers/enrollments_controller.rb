class EnrollmentsController < ApplicationController
  
  before_filter :authenticate_user!
  before_filter :find_enrollment, :except => [:index, :new, :create]
  before_filter :find_user
  before_filter :find_unit
  before_filter :find_units, :only => [:new, :create]
  before_filter :find_users, :only => [:new, :create]
  before_filter :set_tab
  
  # GET /enrollments
  # GET /enrollments.xml
  def index
    @enrollments = Enrollment.all
    if params[:user_id]
      @enrollments = @user.enrollments
    elsif params[:unit_id]
      @enrollments = @unit.enrollments
    end

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @enrollments }
    end
  end

  # GET /enrollments/1
  # GET /enrollments/1.xml
  def show
    @note = @enrollment.notes.build
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @enrollment }
    end
  end

  # GET /enrollments/new
  # GET /enrollments/new.xml
  def new
    @enrollment = Enrollment.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @enrollment }
    end
  end

  # POST /enrollments
  # POST /enrollments.xml
  def create
    @enrollment = Enrollment.new(params[:enrollment])

    respond_to do |format|
      if @enrollment.save
        if @unit
          format.html { redirect_to(unit_enrollments_url(@unit), :notice => 'Enrollment was successfully created.') }
        else
          format.html { redirect_to(user_enrollments_url(@user), :notice => 'Enrollment was successfully created.') }
        end
        format.xml  { render :xml => @enrollment, :status => :created, :location => @enrollment }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @enrollment.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /enrollments/1
  # DELETE /enrollments/1.xml
  def destroy
    @enrollment.destroy

    respond_to do |format|
      if @unit
        format.html { redirect_to(unit_enrollments_url(@unit), :notice => 'Enrollment was successfully deleted.') }
      else
        format.html { redirect_to(user_enrollments_url(@user), :notice => 'Enrollment was successfully deleted.') }
      end
      format.xml  { head :ok }
    end
  end
  
  private
  
  def find_enrollment
    @enrollment = Enrollment.find(params[:id])
  end
  
  def find_units
    @units = Unit.all
  end
  
  def find_users
    @users = User.students.all
  end
  
  def find_user
    if params[:user_id]
      @user = User.find(params[:user_id])
    else
      if params[:id]
        @user = @enrollment.user
      else
        @user = nil
      end
    end
  end
  
  def find_unit
    if params[:unit_id]
      @unit = Unit.find(params[:unit_id])
    else
      if params[:id]
        @unit = @enrollment.unit
      else
        @unit = nil
      end
    end
  end
  
  def set_tab
    if @user
      if current_user.id == @user.id
        @tab = 'units'
      else
        if current_user.is_staff?
          @tab = 'units'
        else
          @tab = 'users'
        end
      end
    else
      @tab = 'units'
    end
  end
end
