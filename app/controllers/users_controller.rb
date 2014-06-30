class UsersController < ApplicationController
  before_action :set_user, only: [:show]

  def show
  end

  def leaderboard
    @users = User.all.order(points: :desc)
  end

  private

    def set_user
      @user = User.find(params[:id])
    end
end
