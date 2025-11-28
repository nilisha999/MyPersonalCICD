import { LightningElement} from 'lwc';

export default class Newsignuppage extends LightningElement {
    handleRegister() {
        const allInputs = this.template.querySelectorAll('lightning-input');
        let isValid = true;

        allInputs.forEach(input => {
            if (!input.reportValidity()) {
                isValid = false;
            }
        });

        if (isValid) {
            console.log('All fields, including phone, are valid. Proceed with form submission.');
        } else {
            console.log('Form is invalid. Please fill in all required fields correctly.');
        }
    }
}