import { LightningElement, track } from 'lwc';

export default class Multistepform extends LightningElement {
    @track currentStep = 4;
    currentStatusButton() {
        this.statusChanged();
    }
    statusChanged(event) {
        const currentValue = event.target.value;
        console.log('Current Status value - ', currentValue);
        this.currentStep = currentValue;
        console.log('Next Stage - ', this.currentStep);
    }
}