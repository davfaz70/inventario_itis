class ToolsController < ApplicationController
  before_action :authenticate_admin!, only: [:new, :edit, :destroy]
  before_action :authenticate_student!, only: [:prenotate]
  def index
  end

  def new
  end

  def create
  end

  def show
  end

  def prenotate
  end

  def edit
  end

  def update
  end

  def destroy
  end
end
