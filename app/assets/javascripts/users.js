/* global $, Stripe */
//Document Ready function
$(document).on('turbolinks:load', function(){
    var theForm = $('#pro_form');
    var submitBtn = $('#form-signup-btn')
    
    //Website html looks like: <meta name="stripe-key" content= "thekey">
    //This can be accessed by CSS by doing the command 'meta name="stripe-key".attr('content') We use this to pull for JS by adding the $ syntax'
    Stripe.setPublishableKey( $('meta[name="stripe-key"]').attr('content') );
    
    //When user clicks form submit btn
    submitBtn.click(function(event){
        
        //Prevent default submission behavior
        event.preventDefault();
        submitBtn.val("Processing").prop('disabled', true);
        
        //collect credit card fields
        var ccNum = $('#card_number').val();
        var cvcNum = $('#card_code').val();
        var expMonth = $('#card_month').val();
        var expYear = $('#card_year').val();
        
        //Use Stripe to check for card errors
        var error = false;
        
        //Validate card information
        if (!Stripe.card.validateCardNumber(ccNum)){
            error = true;
            alert("The credit card number appears to be invalid")
        }
        
        if (!Stripe.card.validateCVC(cvcNum)){
            error = true;
            alert("The credit card CVC number appears to be invalid")
        }
        
        if (!Stripe.card.validateExpiry(expMonth, expYear)){
            error = true;
            alert("The expiration date appears to be invalid")
        }
        
        if (error){
            submitBtn.prop('disabled', false).val("Sign Up");
        } else {
            //send card information to Stripe
            Stripe.createToken({
                number: ccNum,
                cvc: cvcNum,
                exp_month: expMonth,
                exp_year: expYear
            }, stripeResponseHandler);
        }
       return false;
    });
    
    //Stripe will return a card token
    function stripeResponseHandler(status, response){
        //get token from response
        var token = response.id;
        
        //inject card token into hidden field
        theForm.append( $('<input type="hidden" name="user[stripe_card_token]">').val(token) );
        
        //submit form to our Rails app
        theForm.get(0).submit();
    }
    
});

//Stripe will return a card token
//Inject card token as hidden field into form
//Submit form to our rails app

