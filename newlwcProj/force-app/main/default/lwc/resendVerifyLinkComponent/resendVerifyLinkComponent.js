import { LightningElement, wire, track } from 'lwc'; // <-- FIX: 'track' is correctly imported
import resendLink from '@salesforce/apex/VerificationController.resendVerificationLink';
import getContactDetails from '@salesforce/apex/VerificationController.getVerificationContactDetails';

export default class ResendVerifyLinkComponent extends LightningElement {
    @track userEmail;
    @track userPhone;
    @track isResendSuccessful = false;
    @track isResending = true; // Start as TRUE to show spinner immediately

    // Fetches contact details via @wire when this component loads
    @wire(getContactDetails)
    wiredUserDetails({ error, data }) {
        if (data) {
            this.userEmail = data.Email;
            this.userPhone = data.Phone;
        } else if (error) {
            console.error('Error fetching user details:', error);
            this.userEmail = 'Not available';
            this.userPhone = 'Not available';
        }
    }
    
    // Automatically trigger the resend action when the component is inserted
    connectedCallback() {
        this.handleResendAction();
    }

    handleResendAction() {
        this.isResending = true;
        
        resendLink()
            .then(result => {
                this.isResendSuccessful = true;
                console.log('Verification link resent successfully. Apex Result:', result);
            })
            .catch(error => {
                this.isResendSuccessful = false;
                console.error('Failed to resend link. Apex Error:', JSON.stringify(error));
            })
            .finally(() => {
                this.isResending = false;
            });
    }
}