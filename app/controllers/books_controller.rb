class BooksController < ApplicationController
  before_action :set_book, only: %i[edit update destroy]
  before_action :authenticate_user!, except: %i[index show]

  def index
    @books = Book.all
    binding.pry
  end

  def show
    @title = 'Detail Book'
    @book = Book.find_by(id: params[:id])
    if @book.nil?
      @author = ''
      @supplier = ''
    else
      @author = Author.find_by(id: @book.author_id)
      @supplier = Supplier.find_by(id: @book.supplier_id)
    end
  end

  def new
    @book = Book.new
    @authors = Author.all
    @suppliers = Supplier.all
  end

  def create
    @book = Book.new(list_params)
    if @book.save
      redirect_to books_path
    else
      flash.now[:alert] = 'Invalid input value !!!'
      render :new
    end
  end

  def edit
    redirect_to books_path if @book.nil?
  end

  def update
    if @book.update(list_params)
      redirect_to books_path
    else
      flash.now[:alert] = 'Invalid input value !!!'
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    flash[:error] = ' No Book !!!' unless @book&.destroy
    redirect_to books_path
  end

  private

  def set_book
    @book = Book.find_by(id: params[:id])
  end

  def list_params
    params.require(:book).permit(:title, :year_published, :isbn, :price, :out_of_print, :views, :supplier_id,
                                 :author_id)
  end
end
