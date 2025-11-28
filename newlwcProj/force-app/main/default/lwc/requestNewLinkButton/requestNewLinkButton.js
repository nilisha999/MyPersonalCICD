import { LightningElement } from 'lwc';

export default class RequestNewLinkButton extends LightningElement {
    handleClick() {
        // 1. Create a custom event
        const newLinkEvent = new CustomEvent('requestnewlink');

        // 2. Dispatch the event to notify the parent component
        this.dispatchEvent(newLinkEvent);
    }
}