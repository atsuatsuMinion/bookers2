class UsersController < ApplicationController
  def index
    @users = User.all
    @newbook = Book.new
    @user = current_user
  end

  def create
    @books = Book.all
    @newbook = Book.new(book_params)
    @newbook.user_id = current_user.id
    if @newbook.save
      redirect_to book_path(@newbook.id)
    else
      render :index
    end
  end

  def show
    @newbook = Book.new
    @user = User.find(params[:id])
    @books = @user.books
  end

  def edit
    @user = User.find(current_user.id)
  end

  def update
    @user = User.find(params[:id])
    @user.update(user_params)
    flash[:notice] = "You have updated user successfully."
    redirect_to user_path(@user.id)
  end

private
  def book_params
    params.require(:book).permit(:title, :body)
  end

  def user_params
    params.require(:user).permit(:title, :profile_image, :introduction)
  end

end