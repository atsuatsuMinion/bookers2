class BooksController < ApplicationController
  before_action :authenticate_user!
  def index
    @newbook = Book.new
    @books = Book.all
    @user = current_user
  end

  def create
    @books = Book.all
    @newbook = Book.new(book_params)
    @newbook.user_id = current_user.id
    if @newbook.save
      flash[:notice] = "You have created book successfully."
      redirect_to book_path(@newbook.id)
    else
      @user = current_user
      render :index
    end
  end

  def show
    @newbook = Book.new
    @book = Book.find(params[:id])
    @user = User.find(@book.user_id)
    @book_comment = BookComment.new
  end

  def edit
    @book = Book.find(params[:id])
    is_matching_login_user_book
  end

  def update
    @book = Book.find(params[:id])
    is_matching_login_user_book
    if @book.update(book_params)
      flash[:notice] = "You have updated book successfully."
      redirect_to book_path(@book.id)
    else
      render :edit
    end
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to books_path
  end

private
  def book_params
    params.require(:book).permit(:title, :body)
  end

  def is_matching_login_user_book
    unless @book.user_id == current_user.id
      redirect_to books_path
    end
  end

end
