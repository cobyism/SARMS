class UsersController < ApplicationController
  # GET /users
  # GET /users.xml
  
  before_filter :authenticate_user!
  before_filter :set_tab

  def index
    per_page = 10
    if params[:scope] == 'students'
      @users = User.students.all.paginate :page => params[:page], :per_page => per_page
      @title = "Students"
    elsif params[:scope] == 'faculty'
      @users = User.faculty.all.paginate :page => params[:page], :per_page => per_page
      @title = "Faculty"
    elsif params[:scope] == 'admins'
      @users = User.admins.all.paginate :page => params[:page], :per_page => per_page
      @title = "Administrators"
    else
      @users = User.all.paginate :page => params[:page], :per_page => per_page
      @title = "All Users"
    end

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @users }
    end
  end

  # GET /users/1
  # GET /users/1.xml
  def show
    @user = User.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @user }
    end
  end

  # GET /users/new
  # GET /users/new.xml
  def new
    @user = User.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @user }
    end
  end

  # GET /users/1/edit
  def edit
    @user = User.find(params[:id])
  end

  # POST /users
  # POST /users.xml
  def create
    @user = User.new(params[:user])
    role = params[:user][:role]
    
    if role == 'Student'
      @user.is_faculty = false
      @user.is_admin = false
    elsif role == 'Faculty'
      @user.is_faculty = true
      @user.is_admin = false
    elsif role == 'Administrator'
      @user.is_faculty = true
      @user.is_admin = true
    end

    respond_to do |format|
      if @user.save
        format.html { redirect_to(@user, :notice => 'User was successfully created.') }
        format.xml  { render :xml => @user, :status => :created, :location => @user }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /users/1
  # PUT /users/1.xml
  def update
    @user = User.find(params[:id])
    role = params[:user][:role]
    
    if role == 'Student'
      @user.is_faculty = false
      @user.is_admin = false
    elsif role == 'Faculty'
      @user.is_faculty = true
      @user.is_admin = false
    elsif role == 'Administrator'
      @user.is_faculty = true
      @user.is_admin = true
    end

    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to(@user, :notice => "User was successfully updated.") }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.xml
  def destroy
    @user = User.find(params[:id])
    @user.destroy

    respond_to do |format|
      format.html { redirect_to(users_url) }
      format.xml  { head :ok }
    end
  end
  
  def set_tab
    if current_user.is_admin
      @tab = 'users'
    else
      @tab = 'my_account'
    end
  end
end
