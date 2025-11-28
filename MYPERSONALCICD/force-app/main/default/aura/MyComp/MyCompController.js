({
	sendemail : function(component, event, helper) {
		alert('hii, sent an email to you');
        var email=helper.__e('txtEmail').value;
        if(email==''){
            alert('Email-Id is required');
        }else{}
	}
})