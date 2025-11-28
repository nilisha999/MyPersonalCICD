import { LightningElement, wire } from "lwc";
import { api } from "lwc"
import jsPDFLibrary from "@salesforce/resourceUrl/jsPDFLibrary";
import { loadScript } from "lightning/platformResourceLoader";
// Step a) Get Project Invoices record data from salesforce
import { getRecord, getFieldValue } from 'lightning/uiRecordApi'

// Step B) - Get Project Invoices fields data from salesforce
import NAME_FIELD from '@salesforce/schema/Project_Invoices__c.Name'
import PROJECTS_FIELD from '@salesforce/schema/Project_Invoices__c.Projects__c'
import PROJECT_STAGE from '@salesforce/schema/Project_Invoices__c.Project_Stage__c'
import PROJECT_PRICE from '@salesforce/schema/Project_Invoices__c.Project_Price__c'
import INAPPROVAL_FIELD from '@salesforce/schema/Project_Invoices__c.In_Approval__c'
import OWNER_FIELD from '@salesforce/schema/Project_Invoices__c.OwnerId'

// Step C) - Get all the fields in an array variable
const fields = [NAME_FIELD, PROJECTS_FIELD, PROJECT_STAGE, PROJECT_PRICE, INAPPROVAL_FIELD, OWNER_FIELD];

export default class Generatepdfprojectinvoices extends LightningElement {
    // Step 1 : Initialized jsPDF const to false
    jsPDFInitialize = false;

    // Step 2: renderedCallBack
    renderedCallback() {
        if (!this.jsPDFInitialize) {
            console.log("Project Invoices Initialized status - ", this.jsPDFInitialize)
            loadScript(this, jsPDFLibrary)
                .then(
                    () => {
                        // Step 1 : - Assignment jsPDF const to true
                        this.jsPDFInitialize = true;
                        console.log("jsPDF library loaded successfully");
                        console.log("After status is - ", this.jsPDFInitialize);
                    }
                )
                .catch(
                    (error) => {
                        console.log("Error loading jsPDF library", error)
                    }
                );
        }
        // Step 3) - Load the JsPDF Library

    }
    // step d) 
    @api recordId;
    projectInvoiceName;
    projectStage;
    projects;
    projectPrice;
    inApproval;
    owner;

    //  Step E) - Get Project Invoices Data from Salesforce
    @wire(getRecord, { recordId: "$recordId", fields })
    projectinvoiceData({ data, error }) {
        if (data) {
            console.log('data is - ' + JSON.stringify(data))
            this.projectInvoiceName = getFieldValue(data, NAME_FIELD);
            this.projectStage = getFieldValue(data, PROJECT_STAGE);
            this.projects = getFieldValue(data, PROJECTS_FIELD);
            this.projectPrice = getFieldValue(data, PROJECT_PRICE);
            this.inApproval = getFieldValue(data, INAPPROVAL_FIELD);
            this.owner = getFieldValue(data, OWNER_FIELD);
        } else if (error) {
            console.log('Error value parse - ' + JSON.stringify(error));
        }
    }

    // Step f) ON CLICK OF GENERATE PDF BUTTON
    generatePDF() {
        console.log('On Button click status is - ', this.jsPDFInitialize);
        if (this.jsPDFInitialize) {
            console.log('jsPDFInitialize:', this.jsPDFInitialize);
            try {
                const doc = new window.jspdf.jsPDF();
                doc.text('Project Invoices Informations', 90, 20);
                doc.text(this.projectInvoiceName, 70, 120);
                doc.text('Project Invoice Name : ', 90, 30);
                doc.text(this.projects, 70, 130);
                doc.text('Projects : ', 90, 40);
                // doc.text(this.projectPrice, 70, 50); // Uncomment this line if needed
                doc.text('Project Price : ', 90, 50);
                doc.text(this.owner, 70, 100);
                doc.text('Owner : ', 90, 60);
                doc.text(this.projectStage, 70, 110);
                doc.text('Project Stage : ', 90, 70);
                //doc.text(this.inApproval, 70, 80); // Add this line if you have the inApproval variable
                doc.text('In Approval : ', 90, 80);
                //doc.text(this.inApproval, 90, 140);
                doc.line(60, 24, 145, 24);
                doc.setLineWidth(2);
                doc.setFontSize(14);
                //doc.setFont('arial black');
                console.log('Project invoice Information PDF is start save');
                doc.save('ProjectInvoiceInformation.pdf');
                console.log('Project Invoice Information PDF is save succesfully');
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