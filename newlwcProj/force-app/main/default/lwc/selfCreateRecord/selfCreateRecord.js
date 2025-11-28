import { LightningElement, track } from 'lwc';
import { createRecord } from 'lightning/uiRecordApi';
import MY_NOTE_OBJECT from '@salesforce/schema/My_Note__c';
import NAME_FIELD from '@salesforce/schema/My_Note__c.Name';
import NOTE_DESCRIPTION_FIELD from '@salesforce/schema/My_Note__c.Note_Description__c';

export default class SelfCreateRecord extends LightningElement {
    @track noteTitle = '';
    @track noteContent = '';

    handleInputChange(event) {
        const field = event.target.dataset.id;
        if (field === 'title') {
            this.noteTitle = event.target.value;
        } else if (field === 'content') {
            this.noteContent = event.target.value;
        }
    }

    createNote() {
        const fields = {};
        fields[NAME_FIELD.fieldApiName] = this.noteTitle;
        fields[NOTE_DESCRIPTION_FIELD.fieldApiName] = this.noteContent;

        const recordInput = {
            apiName: MY_NOTE_OBJECT.objectApiName,
            fields
        };

        createRecord(recordInput)
            .then(() => {
                alert('Note created successfully');
                this.noteTitle = '';
                this.noteContent = '';
            })
            .catch(error => {
                alert('Error creating note: ' + JSON.stringify(error));
            });
    }
}