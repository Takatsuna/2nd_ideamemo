class UsersController < ApplicationController
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    #def user_params
    #  params.require(:user).permit(:role)
    #end
    ROLES=%w[admin user]
  
end
