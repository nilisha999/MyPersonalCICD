import { LightningElement, api, track } from 'lwc';

export default class ChildQuestionBlock extends LightningElement {
    @track questionText = '';
    @api recordId;
    @api questionTextSave = '';
    @api progressValue = '';

    handleQuestionChange(event) {
        // eslint-disable-next-line @lwc/lwc/no-api-reassignments
        this.questionText = event.target.value;
        console.log('Child - Your Ques is :- ', this.questionText);
    }

    handleSave() {
        console.log('Child Save Button clicked');
        this.handleDisplayQues(this.questionText);
    }

    handleRemove() {
        // Dispatch a custom event to notify the parent component to remove this block
        const removeEvent = new CustomEvent('remove', {
            detail: { id: this.recordId }
        });
        this.dispatchEvent(removeEvent);
    }

    handleDisplayQues(ques) {
        // eslint-disable-next-line @lwc/lwc/no-api-reassignments
        this.progressValue = ques;
        const selectedEvent = new CustomEvent('progressvaluechange', {
            detail: { progressValue: ques }
        });
        this.dispatchEvent(selectedEvent);
        console.log('Final Ques is - ', ques);
    }
}