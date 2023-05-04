class UrlsController < ApplicationController
  before_action :set_url, only: [:show]

  def show
    @url.increment!(:visit_count)
    redirect_to @url.original_url, allow_other_host: true
  end

  def create
    @url = Url.new(url_params)
    @url.user = current_user if user_signed_in?

    if @url.save
      render json: { short_code: @url.short_url }, status: :created
    else
      render json: { errors: @url.errors }, status: :unprocessable_entity
    end
  end

  private

  def set_url
    @url = Url.find_by(short_url: params[:short_code])
    render json: { error: "Short URL not found" }, status: :not_found unless @url
  end

  def url_params
    params.require(:url).permit(:original_url)
  end
end
