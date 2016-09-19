$(document).ready(function(){
	// Stripe initialization
	var stripe_key = $("meta[name='STRIPE_KEY']").attr("content");
	Stripe.setPublishableKey(stripe_key);
	
	// Bind the upgrade button
	$("#beginUpgradeSubsc").bind("click", function(){
		//showPaymentForm();
		showCouponForm();
		$('#rowSubscription').addClass('hide');
		//$('#beginUpgradeSubsc').addClass('hide');
	});
	
	$('#couponForm').bind('submit', function(evt){
		evt.preventDefault();
		onSubmitCouponForm();
	});
	
	$("#cancelCoupon").bind("click", function(){
		onCancelCouponForm();
	});
	
	// Bind submit on the form to intercept it
	$("#paymentForm").submit(function(evt){
		evt.preventDefault();
		onSubmitPaymentForm();
	});
	
	// bind to cancel upgrade button
	$("#cancelUpgradeButton").bind("click", function(){
		hidePaymentForm();
		$("#rowSubscription").removeClass("hide");
	});
	
	// Bind the cancel subscription button
	$("#cancelSubsc").bind("click", function(){
		onCancelSubscription();
	});
	
	// Bind the update payment method button
	$("#updateSubscCard").bind("click", function(){
		showPaymentForm();
		$('#updateSubscCard').addClass('hide');
	});
	
	// bind to cancel update
	$("#cancelUpdateButton").bind("click", function(){
		hidePaymentForm();
		$("#updateSubscCard").removeClass("hide");
	});

});

function showCouponForm(){
	$("#rowCoupon").removeClass('hide');
	$('#couponFormContainer').slideDown(400, function(){
		$('#coupon').focus();
	});
}

function onSubmitCouponForm(){
	$("#processingRequest").modal(
    	{
    		backdrop: 'static',
    		show: true
    	}
    );
    
	$.get('/plans/standard', function(data){
		var $form = $('#couponForm');
		var coupon = $form.find('#coupon').val();
		var subtotal = data.amount;
		var discount = 0;
		var total = subtotal;
		
		if (typeof coupon == 'undefined' || coupon.match(/^\s*$/)) {
			// No coupon entered
			updateTotals(subtotal, discount, total);
			hideCouponForm();
			showPaymentForm();
		} else {
			$.get('/coupons/' + coupon, function(data){
				$('#paymentForm').find("#coupon_id").val(coupon);
				if (data.amount_off == null){
					discount = subtotal * (data.percent_off / 100);
				} else {
					discount = data.amount_off;	
				}
				total = subtotal - discount;
				
				if (total == 0 && (data.duration == 'forever' || data.duration == 'once')){
					submitUpgrade();
				} else {
					updateTotals(subtotal, discount, total);
					hideCouponForm();
					showPaymentForm();
				}
			}).fail(function(e){
				var $form = $("#couponForm");
				$form.find('.coupon-errors').text(e.responseText);
			    $form.find('.coupon-errors').removeClass('hide');
			    $("#processingRequest").modal('hide');
			});
		}
	});
}

function hideCouponForm(){
	$("#couponFormContainer").slideUp(400, function(){
		$('#rowCoupon').addClass('hide');
	});
}

function onCancelCouponForm(){
	$("#couponFormContainer").slideUp(400, function(){
		$('#rowCoupon').addClass('hide');
		$("#rowSubscription").removeClass("hide");
	});
}

function showPaymentForm(){
	$("#rowForm").removeClass('hide');
	$('#paymentFormContainer').slideDown(400, function(){
		$('#cardNum').focus();
	});
}

function hidePaymentForm(){
	$('#paymentFormContainer').slideUp(400, function(){
		$('#rowForm').addClass('hide');
	});
}

function onSubmitPaymentForm(){
	var $form = $("#paymentForm");

  	// Disable the submit button to prevent repeated clicks
    $("#processingRequest").modal(
    	{
    		backdrop: 'static',
    		show: true
    	}
    );

    Stripe.createToken($form, function(status, response){
    	if (response.error){
			// Show the errors on the form
		    $form.find('.payment-errors').text(response.error.message);
		    $form.find('.payment-errors').removeClass('hide');
		    //$form.find('.btn').prop('disabled', false);
		    $("#processingRequest").modal('hide');
		} else {
			// token contains id, last4, and card type
		    var token = response.id;
			// Insert the token into the form so it gets submitted to the server
			$form.append($('<input id="stripe_token" type="hidden" name="stripe_token" />').val(token));
			
			var currentPlanId = $form.find('#planId').val();
			if (currentPlanId == 'free'){
				// upgrade the subscription
				submitUpgrade();
			} else {
				// Update payment method with the new payment method
				submitUpdate();
			}
   		}
   });
}

function updateTotals(subtotal, discount, total){
	var $table = $("#tableTotals");
	$table.find('#cellSubTotal').text('$' + (subtotal / 100).toFixed(2));
	$table.find('#cellDiscount').text('$' + (discount / 100).toFixed(2));
	$table.find('#cellTotal').text('$' + (total / 100).toFixed(2));
	
	hidePaymentForm();
	$("#processingRequest").modal('hide');
	$('.payment-errors').addClass('hide');
}

function submitUpgrade(){
	$("#processingRequest").modal(
   		{
    		backdrop: 'static',
    		show: true
    	}
    );
    
	var $form = $("#paymentForm");
	
	var data = { 
		"subscription": {
			id: $form.find("#subscId").val(),
			stripe_token:$form.find("#stripe_token").val(),
			plan_id:"standard",
			coupon_id:$form.find("#coupon_id").val(),
			action:'upgrade'
		}
	};
			    
	$.ajax({
		type:'PUT',
		url:'/subscriptions/' + data.subscription.id,
		data:data,
		dataType:'json',
		success: function(data){
			onSuccess(data, "Thank your for upgrading your subscription.");
		},
		error: onError
	});
}

function submitUpdate(){
	var $form = $("#paymentForm");
	
	var data = {
		"subscription": {
			id: $form.find("#subscId").val(),
			stripe_token:$form.find("#stripe_token").val(),
			action:'update'
		}};
				
		$.ajax({
			type:'PUT',
			url:'/subscriptions/' + data.subscription.id,
			data:data,
			dataType:'json',
			success: function(data){
				onSuccess(data, "Your payment information has been updated.");
			},
			error: onError
		});
}

function onCancelSubscription(){
	var subsc_id = $("#paymentForm").find("#subscId").val();
	var data = { 
		"subscription": {
			id: subsc_id,
			plan_id:"free",
			action:'cancel'
	}};
	
	$("#processingRequest").modal('show');
			
	$.ajax({
    	type:'PUT',
    	url:'/subscriptions/' + subsc_id,
		data:data,
		dataType:'json',
		success: function(data){
			onSuccess(data, "Your subscription has been reverted to the free plan.");
		},
		error: onError
    });
}

function onSuccess(data, msg){
	// Hide everything and display a message
	$("#subscription-table").addClass("hide");
	$("#beginUpgradeSubscBlock").addClass("hide");
	$("#cancelSubscBlock").addClass("hide");
	$("#updateSubscCardBlock").addClass("hide");
	$("#ccBlock").addClass("hide");
	$("#paymentFailedNotification").addClass("hide");
	$("#notifyUserBlock").text(msg).removeClass("hide");
	$("#processingRequest").modal('hide');
}

function onError(xhr, status, error){
	$(".payment-errors").text(xhr.responseText);
	$(".payment-errors").removeClass("hide");
	$("#processingRequest").modal('hide');
}
