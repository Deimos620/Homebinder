/**
 * @author jdurante
 */

$("#emailSignupButton").click(function() {
    $.ajax({
		type: "POST",
        url: "process.php",
        data: $("#emailSignupForm").serialize(), // serializes the form's elements.
        success: function(data){
           	var json = jQuery.parseJSON(data);
           	if(json.success == true){
           		$("#emailSignUpBlock").hide();
           		$("#thankYouBlock").fadeIn();
           	}
           	else{
           		$("#errorMessage").html(json.message);
           		$("#errorMessage").fadeIn();
           	}
        }
    });

    return false; // avoid to execute the actual submit of the form.
});

(function($){
    $.fn.rotate = function(params){
        return this.each(function(index, el){
            var defaults = {
                text : [],
                interval : 6000
            };
            
            var options = $.extend({}, defaults, params);
            var i = 0;
            
            if(options.text.length){
                setInterval(function(){
                    i = i < options.text.length -1 ? ++i : 0;
                    $(el).fadeOut(function(){ 
                        $(this).text(options.text[i]).fadeIn();
                    });
                }, options.interval);
            }
        });
    };
})(jQuery);