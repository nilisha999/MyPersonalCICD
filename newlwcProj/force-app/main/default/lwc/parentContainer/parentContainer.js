import { LightningElement, track } from 'lwc';

export default class ParentContainer extends LightningElement {
    // Controls which component is rendered
    @track currentView = 'A'; 

    get isViewA() {
        return this.currentView === 'A';
    }

    get isViewB() {
        return this.currentView === 'B';
    }

    // Step 2: Parent listens, swaps the view state
    handleChildANavigation() {
    // This is the automatic, internal "action" you want.
    // It immediately changes the view state, which triggers LWC to render Child B.
    this.currentView = 'B'; 
}
}