import { LightningElement, track } from 'lwc';

export default class AddQuestionButtonComp extends LightningElement {

    @track isMoreQuesVisible = false;

    renderedCallback() {
        console.log('Component rendered');
        // Optionally, perform checks here or manipulate the DOM
    }


    handleAddMoreQuestions(event) {
        event.preventDefault();
        console.log('Nilisha, Now you are the Js File Entered');
        this.renderedCallback();
        this.isMoreQuesVisible = true;
        this.displayAddQuestionBlock();
    }

    displayAddQuestionBlock() {


    }
}