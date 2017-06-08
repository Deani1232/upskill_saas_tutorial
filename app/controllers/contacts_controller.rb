class ContactsController < ApplicationController
    def new
        @contact = Contact.new
    end
    
    def create
        #Create a new contact with the params passed in the private code block below
        #It is assigned this way for security purposes.
        #The contact @instanceVariable is referring to the new contact object created
        #above. The contact created above is following a blueprint laid out in the model folder.
        
        @contact = Contact.new(contact_params)
        if @contact.save
            
            #Assign these variables to send email.
            name = params[:contact][:name]
            email = params[:contact][:name]
            body = params[:contact][:comments]
            
            #Mail with assigned variables above and using the method defined in the mailer folderr
            #for contact mailer. The ContactMailer class is defined in the mailers folder.
            ContactMailer.contact_email(name, email, body).deliver
            
            #Let the user know that it was successful by sending the message to new_contact_path
            #The view will interpret how the flash appears. This view is in the application view and
            #is accessable on each page.
            flash[:success] = "Message Sent."
            redirect_to new_contact_path
        else
            flash[:danger] = @contact.errors.full_messages.join(", ")
            redirect_to new_contact_path
        end
    end
    
    private
        def contact_params
            params.require(:contact).permit(:name, :email, :comments)
        end
end