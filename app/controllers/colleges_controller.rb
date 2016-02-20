class CollegesController < ApplicationController
  before_action :find_college, except: [:index, :new, :create]

  def show

  end

  def index
    @colleges = College.all.order('name ASC')
  end

  def new
    @college = College.new
  end

  def create
    @college = College.new(college_params)
    if @college.save
      redirect_to colleges_path
    else 
      redirect_to colleges_path
    end
  end

  def edit

  end

  def update
    if @college.update(college_params)
    #render_data("success")
      redirect_to colleges_path
    else
      render_error("error")
    end
  end

  def destroy

  end


  private

  def find_college
    @college = College.find(params[:id])
  end

  def college_params
    params.require(:college).permit(:name)
  end
end
