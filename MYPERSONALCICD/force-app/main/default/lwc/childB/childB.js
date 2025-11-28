import { LightningElement, api, track } from 'lwc';

export default class ChildB extends LightningElement {
    @track showContent = false;

    // Step 3: Public Method the Parent calls
    @api
    activateDisplay() {
        // Toggle the internal state to show the details
        this.showContent = true;
    }
}