import { LightningElement, api } from 'lwc';

export default class ConfirmationModal extends LightningElement {
    // Private property to manage modal state
    _isOpen = false;

    @api
    get isOpen() {
        return this._isOpen;
    }

    set isOpen(value) {
        this._isOpen = value;
        // If the modal is opened, you may want to do something, like re-render
        if (value) {
            this.template.querySelector('.modal').classList.add('slds-fade-in-open');
        } else {
            this.template.querySelector('.modal').classList.remove('slds-fade-in-open');
        }
    }

    closeModal() {
        this._isOpen = false; // Use the setter to update the state
        const closeEvent = new CustomEvent('close');
        this.dispatchEvent(closeEvent);
    }

    handleConfirm() {
        const confirmEvent = new CustomEvent('confirm');
        this.dispatchEvent(confirmEvent);
        this.closeModal();
    }
}