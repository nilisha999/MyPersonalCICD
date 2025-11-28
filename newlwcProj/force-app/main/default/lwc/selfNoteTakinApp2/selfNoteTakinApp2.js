import { LightningElement, track, wire } from 'lwc';
import { createRecord } from 'lightning/uiRecordApi';
import MY_NOTE_OBJECT from '@salesforce/schema/My_Note__c';
import NAME_FIELD from '@salesforce/schema/My_Note__c.Name';
import NOTE_DESCRIPTION_FIELD from '@salesforce/schema/My_Note__c.Note_Description__c';
//import getNotes from '@salesforce/apex/NoteController.getNotes';
import { getListUi } from 'lightning/uiListApi';

export default class SelfNoteTakinApp2 extends LightningElement {
    @track noteTitle = '';
    @track noteContent = '';
    @track isModalOpen = false;
    @track showNote = false;
    savedNotes = []; // Initialize savedNotes as an empty array

    // Step 1 : Open the Modal form after click on Add Note Button
    openModal() {
        this.isModalOpen = true;
    }

    // Step 2 : It will close the form on Cancel Button
    closeModal() {
        this.isModalOpen = false;
    }

    // Step 1.1.2 : It will track all the input value fronm the form
    handleInputChange(event) {
        const field = event.target.dataset.id;
        if (field === 'title') {
            this.noteTitle = event.target.value;
        } else if (field === 'content') {
            this.noteContent = event.target.value;
        }
    }
    // Step 3: This create Note function create a my note record in sfdc
    createNote() {
        const fields = {};
        fields[NAME_FIELD.fieldApiName] = this.noteTitle;
        fields[NOTE_DESCRIPTION_FIELD.fieldApiName] = this.noteContent;

        const recordInput = {
            apiName: MY_NOTE_OBJECT.objectApiName,
            fields
        };

        // After creating record successfully it will clear the previous input fields
        // and close the modal form
        createRecord(recordInput)
            .then(() => {
                alert('Note Created Successfully');
                this.noteTitle = '';
                this.noteContent = '';
                this.closeModal();
                this.showNote();
            })
            .catch(error => {
                alert('Error Creating Note: ' + JSON.stringify(error));
            });
    }

    @wire(getListUi, {
        objectApiName: MY_NOTE_OBJECT.objectApiName,
        fields: [NAME_FIELD.fieldApiName, NOTE_DESCRIPTION_FIELD.fieldApiName]
    })
    listUi({ error, data }) {
        if (data) {
            this.savedNotes = data.records;
            this.showNote = true; // show the Notes section
            console.log(this.savedNotes);
        } else if (error) {
            console.error(error);
        }
    }

    // Step 5:show Note Function
    showNote() {
        refreshApex(this.savedNotes);
    }
}