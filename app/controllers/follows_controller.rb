class FollowsController < ApplicationController
    before_action :set_user_follow, only: [:create_follow, :unfollow]
    before_action :get_user_follows, only: [:followings_index, :followers_index]
    
    # GET /follows
    # GET /following
    # Despliega los usuarios a quien sigue el usuario actual
    def followings_index
        #binding.pry
        json_response(@user_followings)
    end

    # Despliega los usuarios que siguen al usuario actual
    def followers_index
        json_response(@user_followers)
    end

    # Sigue a un usuario por medio de su username
    # Crea una instancia y le manda como user_id: el usuario actual, y en following_id: hace un llamado al metodo @following_id
    # Del metodo @following_id solicita el id del parametro username al cual es llamado.
    def create_follow
        follower = @current_user.follows.create(user_id: @current_user.id, following_id: @following_id)
        json_response(follower, :created)
    end

    # Elimina la relacion del usuario actual con el seguidor que se desea dejar de seguir
    # Se logra buscando en la tabla follows del usuario actual, busca al usuario actual y el usuario que se busca dejar de seguir
    # Y se elimina de la tabla defollows.
    def unfollow
        @current_user.follows.find_by(user_id: @current_user.id, following_id: @following_id).destroy
        head :no_content
    end

    private

    # Buscamos el id del usuario al que se busca seguir por medio del parametro username
    def get_user_follows
        @user_followings = if @current_user.username == params[:username]
            @current_user.followings
        else
            @current_user.followings.find_by!(username: params[:username]).followings
        end
        @user_followers = if @current_user.username == params[:username]
            @current_user.followers
        else
            @current_user.followings.find_by!(username: params[:username]).followers
        end
    end
    
    def set_user_follow
        @following_id = User.find_by!(username: params[:username]).id
    end

end
