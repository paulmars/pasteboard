class SitefilesController < ApplicationController
  skip_before_filter :verify_authenticity_token, only: "create"

  def index
    board = Board.find_by_stub(params[:board_id])
    sitefiles = board.sitefiles.order("created_at ASC")

    render json: sitefiles.as_json
  end

  def create
    board = Board.find_by_stub(params[:board_id])

    if current_user.nil? || current_user != board.user
      render json: {success: false}
      return
    end

    sitefile = board.sitefiles.new
    sitefile.user = current_user
    sitefile.sitefile = params[:files]
    sitefile.extension = File.extname(params[:files].original_filename)
    sitefile.save!

    render json: {success: true}
  end
end
