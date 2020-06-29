class BooksController < ApplicationController


  before_action :authenticate_user!
  
  def index
  	@books = Book.all
    @book = Book.new
  end

  def show
    @book_new = Book.new
  	@book = Book.find(params[:id])
    @user = @book.user
  end

  def new
  	@book = Book.new
  end

  def create
    @books = Book.all
  	@book = Book.new(book_params)
    @book.user_id = current_user.id
  	if @book.save
    	redirect_to book_path(@book.id), notice: "book was successfully created"
    else
      render action: :index
    end
  end

  def edit
    @book = Book.find(params[:id])
    if current_user.id != @book.user_id
      redirect_to books_path
    end
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      redirect_to book_path(@book.id), notice:"Book was successfully updated."
    else
      render action: :edit
    end
  end

  def destroy
    book = Book.find(params[:id])
    book.destroy
    redirect_to books_path, notice:"book was successfully destroyed"
  end

  private
    def book_params
   	  params.require(:book).permit(:title, :body)
    end
end
