import { LightningElement } from 'lwc';

export default class NoteTakingAppModal extends LightningElement {
  showModal = false;
  createNoteHandler(){
    this.showModal = true;
  }
}