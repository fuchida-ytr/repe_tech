class HomeController < ApplicationController
  def index
    @admins = Admin.all
    @users = User.all
  end
end
