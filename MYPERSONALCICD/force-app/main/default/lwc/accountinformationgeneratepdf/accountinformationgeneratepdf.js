import { LightningElement, wire, api } from "lwc";
import jsPDFLibrary from "@salesforce/resourceUrl/jsPDFLibrary";
import { loadScript } from "lightning/platformResourceLoader";
// Step : A) Get Account Record data from Salesforce
import { getRecord, getFieldValue } from 'lightning/uiRecordApi';

// Step : B) Get Account fields data from Salesforce
import NAME_FIELD from '@salesforce/schema/Account.Name'
import PHONE_FIELD from '@salesforce/schema/Account.Phone'
import RATING_FIELD from '@salesforce/schema/Account.Rating'
import TYPE_FIELD from '@salesforce/schema/Account.Type'
import WEBSITE_FIELD from '@salesforce/schema/Account.Website'
import INDUSTRY_FIELD from '@salesforce/schema/Account.Industry'
import ANNUAL_REVENUE_FIELD from '@salesforce/schema/Account.AnnualRevenue'
import BILLING_STREET_FIELD from '@salesforce/schema/Account.BillingStreet'

// Step C) Get all the fields in an Array variable
const fields = [NAME_FIELD, PHONE_FIELD,
    RATING_FIELD,
    TYPE_FIELD, WEBSITE_FIELD
    , INDUSTRY_FIELD, ANNUAL_REVENUE_FIELD, BILLING_STREET_FIELD
];


export default class Accountinformationgeneratepdf extends LightningElement {
    // Step 1 : Initialized jsPDF const to false
    jsPDFInitialize = false;

    // Step 2 : renderedCallBack
    renderedCallback() {
        if (!this.jsPDFInitialize) {
            console.log("Account Initialized status - ", this.jsPDFInitialize);
            // Step 3 : Load the JsPDF Library
            loadScript(this, jsPDFLibrary)
                .then(() => {
                    // Step 1 : Assignment jsPDF const to true
                    this.jsPDFInitialize = true;
                    console.log("jsPDF library loaded successfully");
                    console.log("After status is - ", this.jsPDFInitialize);
                })
                .catch((error) => {
                    console.log("Error loading jsPDF library", error);
                });
        }
    }

    // Step D) : 
    @api recordId;
    accountName;
    phone;
    rating;
    type;
    website;
    industry;
    annualRevenue;
    billingStreet;

    // Step E) :Get Account Data from Salesforce
    @wire(getRecord, { recordId: "$recordId", fields })

    accountData({ data, error }) {
        if (data) {
            console.log('data is - ' + JSON.stringify(data))
            this.accountName = getFieldValue(data, NAME_FIELD);
            this.phone = getFieldValue(data, PHONE_FIELD);
            this.rating = getFieldValue(data, RATING_FIELD);
            this.type = getFieldValue(data, TYPE_FIELD);
            this.website = getFieldValue(data, WEBSITE_FIELD);
            this.industry = getFieldValue(data, INDUSTRY_FIELD);
            this.annualRevenue = getFieldValue(data, ANNUAL_REVENUE_FIELD);
            this.billingStreet = getFieldValue(data, BILLING_STREET_FIELD);
        } else if (error) {
            console.log('Error value parse - ' + JSON.stringify(error))
        }
    }

    // STEP F) ON CLICK OF GENERATE PDF BUTTON
    generatePDF() {
        console.log('On Button click status is - ', this.jsPDFInitialize);
        if (this.jsPDFInitialize) {
            console.log('jsPDFInitialize:', this.jsPDFInitialize);
            try {
                const doc = new window.jspdf.jsPDF();
                doc.text('Account Information', 10, 20);
                doc.text('Account Name : ', 30, 60);
                doc.text('Account Name : ', 30, 60);
                doc.text('Type : ', 30, 70);
                doc.text('Industry : ', 30, 80);
                doc.text('Website : ', 30, 100);
                doc.text('Billing Street : ', 30, 110);
                doc.text('Phone : ', 30, 120);
                doc.text(this.accountName, 70, 60);
                doc.text(this.type, 70, 70);
                doc.text(this.industry, 70, 80);
                doc.text(this.website, 70, 100);
                doc.text(this.billingStreet, 70, 110);
                doc.text(this.phone, 70, 120);
                doc.line(60, 24, 145, 24);
                doc.setLineWidth(2);
                doc.setFontSize(14);
                /*doc.set_font('Times');*/
                console.log('Account Information PDF is start save');
                doc.save('AccountInformation.pdf');
                console.log('Account Information PDF is save succesfully');
            }
            catch (error) {
                console.log('Error in genrating PDF', JSON.stringify(error));
            }
        }
        else {
            console.log('jsPDF library is not loaded');
        }

    }

}