import { LightningElement, wire, track } from 'lwc';
import getAccountContacts from '@salesforce/apex/AccountContactControllerDT.getAccountContacts';
import fetchAccounts from '@salesforce/apex/ExampleController.fetchAccounts';

export default class DtTreeGridAccountContacts extends LightningElement {
    @track gridColumns = [
        { label: 'Account Name', fieldName: 'Name', type: 'text' },
        { label: 'Industry', fieldName: 'Industry', type: 'text' },
        { label: 'Contact Name', fieldName: 'LastName', type: 'text' }
    ];

    @track gridData = [];
    tempData;

    // Tree Grid
    // Transform data into hierarchical form
    @wire(getAccountContacts)
    wireAccountContactsTransform({ error, data }) {
        if (data) {
            console.log('Raw data:', data);
            this.gridData = this.transformData(data);
            console.log('Transformed data:', this.gridData);
        } else if (error) {
            console.error(error);
        }
    }

    transformData(accounts) {
        return accounts.map(account => ({
            id: account.Id,
            name: account.Name,
            _children: account.Contacts ? account.Contacts.map(contact => ({
                id: contact.Id,
                name: contact.LastName, // Ensure LastName is used here
                phone: contact.Phone,
                email: contact.Email
            })) : []
        }));
    }

    @wire(fetchAccounts)
    accountTreeData({ error, data }) {
        console.log('Inside wire');
        if (data) {
            let transformedData = JSON.parse(JSON.stringify(data));
            console.log('Data is ' + transformedData);

            for (let i = 0; i < transformedData.length; i++) {
                if (transformedData[i].Contacts) {
                    transformedData[i]._children = transformedData[i].Contacts.map(contact => ({
                        id: contact.Id,
                        LastName: contact.LastName
                    }));
                } else {
                    transformedData[i]._children = [];
                }
                delete transformedData[i].Contacts;
            }

            this.gridData = transformedData;
            console.log('Transformed Data: ', this.gridData);
        } else if (error) {
            console.error('Error fetching accounts: ', error);
        }
    }
}