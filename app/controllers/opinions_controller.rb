class OpinionsController < ApplicationController
    def new
       @opinion  = Opinion.new 
    end
    def create
       book_id = cookies[:bookid]
       cookies.delete :bookid
       @opinion = Opinion.new(opinion_param)
       @opinion.user_id = current_user.id
       @opinion.book_id = book_id
       if !Opinion.where("user_id = ? AND book_id = ?", @opinion.user_id, @opinion.book_id ).exists?
           if @opinion.save
               flash[:success] = "Opinia została dodana"
               redirect_to book_path(@opinion.book_id)
           else
               flash[:danger] = "Wymagane jest podanie wszystkich opcji. Opis może mieć max 1000 znaków. Wartość oceny od 1 do 5."
               redirect_to book_path(@opinion.book_id)
           end
       else
           flash[:danger] = "Dodałeś już opinię do tej książki"
           redirect_to book_path(@opinion.book_id) 
       end
    end
    def show
       @opinions = Opinion.where(book_id: @book.id) 
       @opinions = @opinions.paginate(page: params[:page], per_page: 3)
    end
    def destroy
        @opinion = Opinion.find(params[:id])
        if current_user.id == @opinion.user_id || current_user.admin?
            bid = @opinion.book_id
            @opinion.destroy
            flash[:danger] = "Usunięto opinię"
            redirect_to book_path(bid)
        else
            flash[:danger] = "Musisz być właścicielem opinii"
            redirect_to book_path(@opinion.book_id)
        end
    end
    def index
        @opinions = Opinion.where(user_id: session[:user_id])
    end
    private
    def opinion_param
        params.require(:opinion).permit(:description, :rate) 
    end
end