class UsersController < ApplicationController

  def show
    user = User.find(params[:id])
    if user_signed_in? && current_user.id == user.id
      @nickname = user.nickname
    else
      redirect_to login_signup_index_path
    end
  end
end
