class SchoolsController < ApplicationController

  def new
    @school = School.new
  end

  def create
    @school = School.new(school_params)
    if @school.save
      ENV['EMAIL_CLIENT'] = @school.mail

      ENV['EMAIL_PASSWORD'] = @school.password

      ENV['CLIENT_ID'] = @school.client

      ENV['CLIENT_SECRET'] = @school.secret

      @school.secret = nil
      @school.client = nil
      @school.password = nil
      @school.mail = nil
      @school.save

      redirect_to school_path(@school)
    else
      render 'new'
    end
  end

  def show


  end

  def edit
  end

  def update
  end

  def index
  end

  private

  def school_params
    params.require(:school).permit(:name, :url, :mail, :password, :client, :secret)
  end
end
