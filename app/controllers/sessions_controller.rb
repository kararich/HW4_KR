class SessionsController < ApplicationController
  def new
  end

  def create
    @user = User.find_by({ "email" => params["email"] })

    if @user.present? && BCrypt::Password.new(@user["password"]) == params["password"]
      session["user_id"] = @user["id"]
      cookies.signed[:user_id] = { value: @user["id"], expires: 1.week.from_now }
      flash["notice"] = "Hello."
      redirect_to "/places"
    else
      flash["notice"] = "Nope."
      redirect_to "/login"
    end
  end

  def destroy
    session["user_id"] = nil
    cookies.delete(:user_id)
    flash["notice"] = "Goodbye."
    redirect_to "/login"
  end
end

  