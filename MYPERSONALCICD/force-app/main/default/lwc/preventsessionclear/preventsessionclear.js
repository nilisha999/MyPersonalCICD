import { LightningElement } from 'lwc';
import basePath from '@salesforce/community/basePath';
import { NavigationMixin } from 'lightning/navigation';

export default class Preventsessionclear extends NavigationMixin(LightningElement) {
    handleLogout() {
        // Step 1: Define the relative path to your custom login page.
        // Replace '/s/login' with the actual path you found in Experience Builder.
        const customLoginPagePath = '/s/login'; 

        // Step 2: Construct the full logout URL with the startURL parameter.
        // encodeURIComponent is used to ensure the URL is formatted correctly.
        const logoutUrl = `${basePath}/secur/logout.jsp?startURL=${encodeURIComponent(customLoginPagePath)}`;
        
        // Step 3: Navigate to the constructed URL.
        this[NavigationMixin.Navigate]({
            type: 'standard__webPage',
            attributes: {
                url: logoutUrl
            }
        });
    }
}