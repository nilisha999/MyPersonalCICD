import { LightningElement } from 'lwc';
import createNoteRecord from '@salesforce/apex/TestingNote.createNoteRecord';

const DEFAULT_note_form = {
  Name: "",
  Note_Description__c: ""
};

export default class NoteTakingApp extends LightningElement {
  showModal = false;
  noteRecord = { ...DEFAULT_note_form };
  
  formats = [
    'font',
    'size',
    'bold',
    'italic',
    'underline',
    'strike',
    'list',
    'indent',
    'align',
    'link',
    'clean',
    'table',
    'header',
    'color',
  ];

  createNoteHandler() {
    console.log("createNoteHandler called");
    this.showModal = true;
  }

  closeModalHandler() {
    console.log("closeModalHandler called");
    this.showModal = false;
    this.noteRecord = { ...DEFAULT_note_form };
  }

  saveNoteHandler(event) {
    event.preventDefault();
    console.log("saveNoteHandler called with noteRecord:", JSON.stringify(this.noteRecord));
    this.createNote();
  }

  changeHandler(event) {
    const { name, value } = event.target;
    console.log(`changeHandler called with name: ${name}, value: ${value}`);
    if (name && value !== undefined) {
      this.noteRecord = {
        ...this.noteRecord,
        [name]: value
      };
    } else {
      console.error("Change handler error: event target does not have the expected properties.");
    }
  }

  createNote() {
    console.log("createNote called with:", this.noteRecord);
    createNoteRecord({
      title: this.noteRecord.Name, 
      description: this.noteRecord.Note_Description__c
    })
    .then(() => {
      console.log("createNoteRecord successful");
      this.showModal = false;
    })
    .catch(error => {
      console.error("Error in createNote:", error);
      if (error && error.body && error.body.message) {
        console.error("Error message:", error.body.message);
      }
    });
  }
}