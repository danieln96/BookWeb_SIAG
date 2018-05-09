class OpinionsController < ApplicationController
    def new
       @opinion  = Opinion.new 
    end
    def create
       @opinion = Opinion.new(opinion_param)
       @opinion.user_id = current_user.id
       @opinion.book_id = cookies[:bookid]
       cookies.delete :bookid
       if !Opinion.where("user_id = ? AND book_id = ?", @opinion.user_id, @opinion.book_id ).exists?
           if @opinion.save
               flash[:success] = "Opinia została dodana"
               redirect_to book_path(@opinion.book_id)
           else
               flash[:danger] = "Wystąpił błąd"
               redirect_to root_path
           end
       else
           redirect_to book_path(@opinion.book_id), notice: "Dodałeś już opinię do tej książki"
       end
    end
    def show
       @opinions = Opinion.where(book_id: @book.id) 
       @opinions = @opinions.paginate(page: params[:page], per_page: 3)
    end
    def destroy
        @opinion = Opinion.find(params[:id])
        bid = @opinion.book_id
        @opinion.destroy
        flash[:danger] = "Usunięto opinię"
        redirect_to book_path(bid)
        
    end
    def index
        @opinions = Opinion.where(user_id: session[:user_id])
    end
    private
    def opinion_param
        params.require(:opinion).permit(:description, :rate) 
    end
end