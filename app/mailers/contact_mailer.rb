#Define a contact mailer class to use elsewhere in the program.
#This is like a model, but for an email. It's a blueprint.
class ContactMailer < ActionMailer::Base
    default to: 'Deani1232@gmx.com'
    
    def contact_email(name, email, body)
        @name = name
        @email = email
        @body = body
        
        mail(from: email, subject: 'Contact Form Message')
    end
    
end