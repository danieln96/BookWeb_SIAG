class BooksController < ApplicationController
   before_action :require_admin, only: [:destroy, :edit, :update, :new, :create]
   before_action :set_book, only: [:show, :update, :edit, :destroy]
   before_action :check_book, only: [:create, :update]
   def index
       @books = Book.paginate(page: params[:page], per_page: 10)
   end
   def new
       @book = Book.new
   end
   def create
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
           @average = (@average.to_f / @book.opinions.size).to_f.round(2)
       end
       @lastpage = ((@book.id - Book.first.id + 1) / 10.to_f).ceil
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
       @book.opinions.destroy_all
       if @book.destroy
         flash[:danger] = "Pozyzja została usunięta"
         redirect_to books_path
       else
          redirect_to books_path
       end     
   end
   def search
      if !params[:orders]
          @books = Book.where('title LIKE :search OR author LIKE :search OR genre LIKE :search', search: "%#{params[:search].strip}%")
      else
          if params[:sort]== "ASC" || params[:sort] == "DESC"
            @books = Book.where('title LIKE :search OR author LIKE :search OR genre LIKE :search', search: "%#{params[:search].strip}%").order("#{params[:orders]} #{params[:sort]}")
          else
              flash[:danger] = "Zrobiłeś coś źle"
              redirect_to books_path
          end
      end
   end
   def authors
      @books = Book.all 
      @authors = Array.new
      @books.each do |book|
         if @authors.include? book.author
          
         else
             @authors << book.author
         end
      end
   end
   def getJSON
      @books = Book.all
      render json: @books.to_json(:include => :opinions)
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
    def check_book
        @book = Book.new(book_param)
        if Book.where(["title = ? and author = ?", "#{@book.title}", "#{@book.author}"]).exists?
                flash[:info] = "Taka książka już istnieje"
                redirect_to(request.env['HTTP_REFERER'])
        end
    end
end