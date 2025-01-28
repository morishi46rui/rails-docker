class Api::V1::ExamplesController < ApplicationController
  def index
    render json: { message: "This is the index action" }, status: :ok
  end
end
