class Api::V1::SpecificationsController < ApplicationController
  before_action :authorize_request, except: :index
  before_action :check_admin, except: [:index, :show]

  def index
    specifications = Specification.all
    render json: specifications, status: 200
  end

  def create
    specification = Specification.new(
      name: specification_params[:name],
    )
    if specification.save
      render json: specification, status: 200
    else
      render json: {error: "Error creating specification"}
    end
  end

  def show
    specification = Specification.find_by(id: params[:id])
    if specification
      render json: specification, status: 200
    else
      render json: {error: "Specification Not Found"}
    end
  end

  def update
    specification = Specification.find_by(id: params[:id])

    if specification
      if specification.update(specification_params)
        render json: specification, status: 200
      else
        render json: { error: "Error updating specification!" }, status: 422
      end
    else
      render json: { error: "Specification not found." }, status: 404
    end
  end

  def destroy
    specification = Specification.find_by(id: params[:id])

    if specification
      specification.destroy
      render json: { message: "Specification successfully deleted." }, status: 200
    else
      render json: { error: "Specification not found." }, status: 404
    end
  end

  private
    def specification_params
      params.require(:specification).permit(:name)
    end
end
