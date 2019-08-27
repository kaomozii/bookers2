class BooksController < ApplicationController
  before_action :authenticate_user!
  def index
  	@users = User.all
  	@book = Book.new
  	@books = Book.all
    @user = User.all
  end

  def create
  	@book = Book.new(book_params)
    @book.user_id = current_user.id
  	if @book.save
  	   redirect_to book_path(@book),notice: "successfully"
     else
      @books = Book.all
      @user = User.all
      render :index
      # booksのindex.html.erbを表示させてるだけ
    end
  end

  def show
    @book = Book.find(params[:id])
    # @books = Book.where(user_id: current_user.id)
    # @books = current_user.books
    @booknew = Book.new
  end


  def update
  	@book =Book.find(params[:id])
    @book.update(book_params)
    if @book.update(book_params)
    redirect_to book_path(@book.id),notice: "successfully"
    else
      render :edit
    end
  end

  def edit
    @book = Book.find(params[:id])
    if @book.user != current_user
    redirect_to books_path
    end
  end

  def destroy
    book = Book.find(params[:id])
    book.destroy
    redirect_to books_path
  end

  private
  def book_params
  	params.require(:book).permit(:title,:body)
  end
end