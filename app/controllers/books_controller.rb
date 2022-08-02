class BooksController < ApplicationController
  def index
    @new_book = Book.new
    @books = Book.all
    @current_user = User.find(current_user.id)
  end

  def create
    @books = Book.all
    @new_book = Book.new(book_params)
    @new_book.user_id = current_user.id
    if @new_book.save
      redirect_to book_path(@new_book.id)
      flash[:notice] = "You have created book successfully."
    else
      render :index
    end
  end

  def show
    @book = Book.find(params[:id])
    @new_book = Book.new
    @new_book_comment = BookComment.new
    @user = User.find(@book.user_id)
  end

  def edit
    @book = Book.find(params[:id])
    if @book.user == current_user
      render 'edit'
    else
      redirect_to books_path
    end
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      redirect_to book_path(@book)
      flash[:notice] ="You have updated book successfully."
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
end
