import { LightningElement } from 'lwc';

export default class NestedDataTable extends LightningElement {
    myFunction(id) {
        const element = this.template.querySelector(`#${id}`);
        if (element) {
            if (!element.classList.contains("w3-show")) {
                element.classList.add("w3-show");
            } else {
                element.classList.remove("w3-show");
            }
        }
    }
}