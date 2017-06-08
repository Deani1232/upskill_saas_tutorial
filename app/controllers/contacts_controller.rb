class ContactsController < ApplicationController
    def new
        @contact = Contact.new
    end
    
    #POST request /contacts
    def create
        #Create a new contact with the params passed in the private code block below
        #It is assigned this way for security purposes.
        #The contact @instanceVariable is referring to the new contact object created
        #above. The contact created above is following a blueprint laid out in the model folder.
        
        #This mass assigns form fields into Contact object
        @contact = Contact.new(contact_params)
        
        #Save the contact object to the database.
        if @contact.save
            
            #Assign these variables to send email.
            
            #Remember: In Ruby, a hash value is retrieved by doing hashname[:hashkey]
            #This will evaluate to the hash's key value. This premise is used below, but more complicated.
            
            #Why we access params the way we do: -------------------------------------------|
            #params is a hash. Contact is a hash bult with more hashes inside of it.
            #It looks like this: "contact" => {"name"=>"John Doe"}
            
            #To access these parameters, you must first access the contact hash key,
            #Then you need to access the key inside the contact hash.
            #So to pull the name you would do: [:contact] to open up the first hash,
            #Then you would do [:name] to open up the second hash. These are nested within
            #each other.
            
            #params hashmap:
            #utf8
            #authenticity_token
            #contact
            #   |- name
            #   |- email
            #   |- comments
            
            name = params[:contact][:name]
            email = params[:contact][:email]
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