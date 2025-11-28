import { LightningElement, wire, api } from 'lwc';
import getAccounts from '@salesforce/apex/AccountController.getAccounts';
import getRelatedContacts from '@salesforce/apex/TreeViewController.getRelatedContacts';
import { PARENT_COLUMNS_DEFINITION, CHILD_COLUMNS_DEFINITION, UPDATED_DATA_WITH_CHILDREN } from './sampleData';

export default class TreeviewdataTable extends LightningElement {
    accounts;
    error;
    treeData = [];

    @api recordId; // Parent recordId (Account)

    // Wire the Apex method to automatically fetch the data
    @wire(getAccounts)
    wiredAccounts({ error, data }) {
        if (data) {
            this.accounts = data;
            this.error = undefined;
        } else if (error) {
            this.error = error;
            this.accounts = undefined;
        }
    }

    @wire(getRelatedContacts, { accountId: '$recordId' })
    wireContacts({ error, data }) {
        if (data) {
            this.treeData = [
                {
                    id: this.recordId,
                    name: 'Name', // Account Name
                    children: data.map(contact => ({
                        id: contact.Id,
                        name: contact.Name
                    }))
                }
            ];
        } else if (error) {
            console.error(error);
        }
    }

    // Define the columns for the tree grid
    parentColumns = PARENT_COLUMNS_DEFINITION;
    childColumns = CHILD_COLUMNS_DEFINITION;

    // Sample data provided to the tree grid
    treeGridData = UPDATED_DATA_WITH_CHILDREN;

    // Handle row toggle to dynamically change columns for child rows
    handleRowToggle(event) {
        const rowData = event.detail.row;
        if (rowData._children) {
            this.updateColumnsForChildren(rowData._children);
        }
    }

    // Update columns for child rows recursively
    updateColumnsForChildren(children) {
        children.forEach(child => {
            if (child._children) {
                this.updateColumnsForChildren(child._children);
            } else {
                // Update columns for child row
                child.columns = this.childColumns;
            }
        });
    }

    // Function to dynamically set the appropriate columns based on row level
    getColumns(rowData, isChild) {
        return isChild ? this.childColumns : this.parentColumns;
    }

    // Render rows recursively
    renderRow(rowData, isChild = false) {
        const columns = this.getColumns(rowData, isChild);

        // Render the row with the appropriate column definitions
        this.renderColumns(rowData, columns);

        if (rowData._children) {
            rowData._children.forEach(child => this.renderRow(child, true));
        }
    }

    // Function to render columns dynamically for each row
    renderColumns(data, columns) {
        columns.forEach(col => {
            const value = data[col.fieldName] || 'N/A';  // Default value if field is missing
            console.log(`${col.label}: ${value}`);  // Simulate rendering the value (e.g., print or display in UI)
        });
    }

    connectedCallback() {
        this.treeGridData.forEach(row => this.renderRow(row));
    }
}