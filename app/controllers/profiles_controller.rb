class ProfilesController < ApplicationController
    
    # GET Request to users/:user_id/profile/new
    def new
        @profile = Profile.new
    end
    
    #POST Request to /users/:user_id/profile
    def create
        #Ensure we have the user who is filling out the form
        @user = User.find( params[:user_id] )
        
        #Create profile linked to this specific user
        @profile = @user.build_profile( profile_params )
        
        if @profile.save
            flash[:success] = "Profile Updated!"
            redirect_to user_path( params[:user_id] )
        else
            render action: :new
        end
    end
    
    private
        def profile_params
            params.require(:profile).permit(:first_name, :last_name, :job_title, :phone_number, :contact_email, :description)
        end
end