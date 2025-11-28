import { LightningElement } from 'lwc';

export default class LinkRequester extends LightningElement {
    /**
     * Handles the button click and dispatches a custom event 
     * named 'requestlink' to the parent component.
     */
    handleClick() {
        // Create the custom event. It's best practice to use all lowercase for event names.
        const requestEvent = new CustomEvent('requestlink', {
            bubbles: true, // Allows the event to bubble up the DOM
            composed: true, // Allows the event to pass the shadow boundary
        });

        // Dispatch the event
        this.dispatchEvent(requestEvent);
    }
}