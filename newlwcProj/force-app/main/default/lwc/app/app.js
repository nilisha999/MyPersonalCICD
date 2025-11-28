import { LightningElement } from 'lwc';

export default class App extends LightningElement {
    isLoggedIn = false;

    // This method is called by the signInPage's custom event
    handleLogin(event) {
        const { isSuccess } = event.detail;

        if (isSuccess) {
            this.isLoggedIn = true;
            // Pushing a new state to the history to prevent back navigation
            history.pushState(null, null, location.href);
            console.log('User logged in successfully.');
        } else {
            console.error('Login failed.');
        }
    }

    // This method is called by the applicationPage's custom event
    handleLogout() {
        this.isLoggedIn = false;
        // Replacing the current history state to prevent back navigation
        history.replaceState(null, null, location.href);
        console.log('User logged out.');
    }
}