class BooksController < ApplicationController
   before_action :require_admin, only: [:destroy, :edit, :update, :new, :create]
   before_action :set_book, only: [:show, :update, :edit, :destroy]
   def index
       @books = Book.paginate(page: params[:page], per_page: 10)
   end
   def new
       @book = Book.new
   end
   def create
       @book = Book.new(book_param)
       if @book.save
          flash[:success] = "Książka została prawidłowo dodana"
          redirect_to books_path
       else
          render 'new'
       end
   end
   def show
       @opinion = Opinion.new
       if !@book.opinions.empty?
           @average = 0
           @book.opinions.each { |o| @average += o.rate }
           @average = @average / @book.opinions.size
       end
       cookies[:bookid] = @book.id
   end
   def edit
   end
   def update
       if @book.update(book_param)
          flash[:success] = "Pozycja została edytowana"
          redirect_to books_path
       else
          render 'edit'
       end
   end
   def destroy
       if @book.destroy
         flash[:danger] = "Pozyzja została usunięta"
         redirect_to books_path
       else
          redirect_to books_path
       end     
   end
   private
   def set_book
      begin
         @book = Book.find(params[:id])
      rescue
         flash[:danger] = "Coś sknociłeś"
         redirect_to root_path
      ensure
         
      end
   end
   def book_param
      params.require(:book).permit(:title, :author, :genre)
   end
    def require_admin
        if !logged_in? || (logged_in? and !current_user.admin?)
            flash[:danger] = "Tylko admin może zrobić coś takiego"
            redirect_to root_path
        end
    end
end