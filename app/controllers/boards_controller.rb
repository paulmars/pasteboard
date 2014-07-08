class BoardsController < ApplicationController

  def index
    if user_signed_in?
      @boards = current_user.boards.order("created_at DESC")
    else
      render template: "boards/outside"
    end
  end

  def create
    board = current_user.boards.create
    redirect_to board
  end

  def show
    @board = Board.find_by_stub(params[:id])

    if @board.nil?
      render text: "no board found"
    end
  end

  def destroy
    @board = current_user.boards.find_by_stub(params[:id])
    @board.destroy!

    redirect_to root_url
  end

end
