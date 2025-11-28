import { LightningElement, wire, track } from 'lwc';
import getAccountContacts from '@salesforce/apex/AccountContactControllerDT.getAccountContacts';

const columns = [
    { label: 'Account Name', fieldName: 'AccountName', type: 'text' },
    { label: 'Contact Name', fieldName: 'ContactName', type: 'text' },
    { label: 'Contact Phone', fieldName: 'ContactPhone', type: 'phone' },
    { label: 'Contact Email', fieldName: 'ContactEmail', type: 'email' }
];

export default class DtAccountsContacts extends LightningElement {
    @track accountData;
    columns = columns;

    @wire(getAccountContacts)
    wireAccountContacts(result) {
        if (result.data) {
            this.accountData = result.data.map(account => {
                const contacts = account.Contacts || [];
                return {
                    Id: account.Id,
                    AccountName: account.Name,
                    ContactName: contacts.map(contact => contact.Name).join(', '),
                    ContactPhone: contacts.map(contact => contact.Phone).join(', '),
                    ContactEmail: contacts.map(contact => contact.Email).join(', ')
                };
            });
        } else if (result.error) {
            console.error(result.error);
        }
    }

    // Tree Grid
    // Transfor data into hirerachical form

    @wire(getAccountContacts)
    wireAccountContactsTransform({ error, data }) {
        if (data) {
            this.accountData = this.transformData(data);
        }
        else if (error) {
            console.error(error)
        }
    }

    transformData(accounts) {
        return accounts.map(account => ({
            id: account.Id,
            name: account.Name,
            _children: account.Contacts ? account.Contacts.map(contact => ({
                id: contact.Id,
                name: contact.Name,
                phone: contact.Phone,
                email: contact.Email
            }

            )

            ) : []
        }))
    }

}