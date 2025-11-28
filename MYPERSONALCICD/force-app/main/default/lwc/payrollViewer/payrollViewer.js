import { LightningElement, wire } from 'lwc';
import getMyPayrollSlips from '@salesforce/apex/PayrollController.getMyPayrollSlips';

export default class PayrollViewer extends LightningElement {
    // Use the wire service to automatically call the Apex method
    @wire(getMyPayrollSlips)
    wiredPayrolls; // The wired data is available in the wiredPayrolls.data and wiredPayrolls.error properties
}