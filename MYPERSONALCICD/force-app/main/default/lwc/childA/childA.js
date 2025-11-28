// childA.js
import { LightningElement } from 'lwc';

export default class ChildA extends LightningElement {
    // childA.js
    handleClick() {
        const navEvent = new CustomEvent('navigatecontact');
        this.dispatchEvent(navEvent); // Event is fired UP to the parent
    }
}