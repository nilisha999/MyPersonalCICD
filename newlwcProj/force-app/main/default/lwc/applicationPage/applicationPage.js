import { LightningElement } from 'lwc';

export default class ApplicationPage extends LightningElement {
    handleLogout() {
        // Dispatch a custom event to notify the parent component
        const logoutEvent = new CustomEvent('loggedout');
        this.dispatchEvent(logoutEvent);
    }
}