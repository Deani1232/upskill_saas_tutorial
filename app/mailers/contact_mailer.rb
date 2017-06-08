#Define a contact mailer class to use elsewhere in the program.
class ContactMailer < ActionMailer::Base
    default to: 'Deani1232@gmx.com'
    
    def contact_email(name, email, body)
        @name = name
        @email = email
        @body = body
        
        mail(from: email, subject: 'Contact Form Message')
    end
    
end