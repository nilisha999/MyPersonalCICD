/*import { LightningElement } from 'lwc';
import { NavigationMixin } from 'lightning/navigation';

export default class LogoutButton extends NavigationMixin(LightningElement) {
    handleLogout() {
        // First clear session
        fetch('/secur/logout.jsp', { mode: 'no-cors' })
            .finally(() => {
                // Immediately go to Google
                window.location.replace('https://www.google.com');
            });
    }
}*/

import { LightningElement } from 'lwc';

export default class LogoutButton extends LightningElement {
    handleLogout() {
        // Kill session in the background
    fetch('/secur/logout.jsp', { mode: 'no-cors' })
        .finally(() => {
            // Replace current history entry with Google
            window.location.replace('https://www.google.com');
        });
    }
}