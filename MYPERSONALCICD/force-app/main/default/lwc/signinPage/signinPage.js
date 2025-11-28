import { LightningElement, api } from 'lwc';

export default class SignInPage extends LightningElement {
    username = '';
    password = '';

    handleUsernameChange(event) {
        this.username = event.target.value;
    }

    handlePasswordChange(event) {
        this.password = event.target.value;
    }

    handleLogin() {
        // In a real-world scenario, you would perform validation
        // and a call to an Apex method for authentication here.

        // Example: Check if fields are not empty
        if (this.username && this.password) {
            // For this example, we'll just simulate a successful login
            console.log('Attempting to log in...');
            
            // Dispatch a custom event to notify the parent component
            const loginEvent = new CustomEvent('loggedin', {
                detail: {
                    username: this.username,
                    isSuccess: true // In a real app, this would be based on Apex response
                }
            });
            this.dispatchEvent(loginEvent);

        } else {
            console.error('Username and password are required.');
        }
    }
}