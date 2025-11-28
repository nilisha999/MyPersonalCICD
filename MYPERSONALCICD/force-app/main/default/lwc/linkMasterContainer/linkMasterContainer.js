import { LightningElement, track } from 'lwc';

// Constants for view states
const VIEW_REQUESTER = 'requester';
const VIEW_CONTACT = 'contact';

export default class LinkMasterContainer extends LightningElement {
    // State variable to control which component is visible
    @track currentView = VIEW_REQUESTER; 

    // Getter property to check if the Requester view should be displayed
    get isRequesterView() {
        return this.currentView === VIEW_REQUESTER;
    }

    // Getter property to check if the Contact Details view should be displayed
    get isContactDetailsView() {
        return this.currentView === VIEW_CONTACT;
    }

    /**
     * Handles the 'requestlink' custom event from the first child component.
     * This method represents the 'backend' logic where the parent is called.
     */
    handleLinkRequest(event) {
        // 1. Parent component is internally called/triggered
        console.log('--- Parent (Controller) Triggered by Child 1 ---');
        
        // 2. Parent automatically calls/triggers the display of the second child
        // by updating the state variable.
        this.currentView = VIEW_CONTACT;

        // The LWC framework automatically re-renders the template, hiding <c-link-requester> 
        // and showing <c-contact-details>.
    }
}