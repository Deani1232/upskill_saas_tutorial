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
        //collect credit card fields
        var ccNum = $('#card_number').val();
        var cvcNum = $('#card_code').val();
        var expMonth = $('#card_month').val();
        var expYear = $('#card_year').val();
        
        //send card information to Stripe
        Stripe.createToken({
            number: ccNum,
            cvc: cvcNum,
            exp_month: expMonth,
            exp_year: expYear
        }, stripeResponseHandler);
       
    });
    
});

//Stripe will return a card token
//Inject card token as hidden field into form
//Submit form to our rails app

