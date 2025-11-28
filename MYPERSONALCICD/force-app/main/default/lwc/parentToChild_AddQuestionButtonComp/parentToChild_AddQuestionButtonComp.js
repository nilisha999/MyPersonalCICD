import { LightningElement, track } from 'lwc';

export default class ParentToChild_AddQuestionButtonComp extends LightningElement {
    @track questions = [];
    idCounter = 0;
    @track progressValue = 0;

    handleAddMoreQuestions(event) {
        event.preventDefault();
        const newId = `question-${this.idCounter++}`;
        console.log('Nilisha, Entered PARENT Handle More Questions method - ', newId);

        // Add a new question block with a unique ID
        this.questions = [...this.questions, { id: newId, text: '' }];
        console.log('Nilisha, PARENT Handle this Questions Array - ', this.questions);
    }

    handleRemoveQuestion(event) {
        const id = event.detail.id;
        this.questions = this.questions.filter(question => question.id !== id);
    }
    handleProgressValueChange(event) {
        this.progressValue = event.detail.progressValue;
    }
    handleSaveQuestion(event) {
        const newQuestion = {
            id: Date.now(),
            text: event.detail.text
        };
        this.questions = [...this.questions, newQuestion];
    }
}