import { LightningElement } from 'lwc';
import NAME_FIELD from '@salesforce/schema/Opportunity.Name'
import TYPE_FIELD from '@salesforce/schema/Opportunity.Type'
import STAGE_FIELD from '@salesforce/schema/Opportunity.StageName'
import AMOUNT_FIELD from '@salesforce/schema/Opportunity.Amount'

export default class OppRecordFormPage extends LightningElement {
    fields = [NAME_FIELD, TYPE_FIELD, STAGE_FIELD, AMOUNT_FIELD];
    objectApiName = 'Opportunity';
    recordId = '006Ig000002m7aQIAQ';
}