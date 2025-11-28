import { LightningElement, track } from 'lwc';

export default class SignUpComponent extends LightningElement {
    // Initial state is false, so the button is shown on load.
    @track showResend = false;

    // This method is called when the child dispatches the 'requestnewlink' event.
    handleRequestNewLink(event) {
        // Set state to true to hide the button and render the ResendVerifyLinkComponent.
        this.showResend = true;
    }
}