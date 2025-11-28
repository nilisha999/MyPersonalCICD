import { LightningElement } from 'lwc';
import jsPDFLibrary from '@salesforce/resourceUrl/jsPDFLibrary'; // Import static resources from Salesforce
import { loadScript } from 'lightning/platformResourceLoader'; // Import external javascript library like jsPDF library
export default class Generatepdfusingjspdf extends LightningElement {
    // Step 1 : Use 'renderedCallback' function to load jsPDF library
    jsPDFInitialize = false;
    renderedCallback() {
        if (!this.jsPDFInitialize) {
            console.log('status is - ', this.jsPDFInitialize);

            loadScript(this, jsPDFLibrary).then(() => {
                this.jsPDFInitialize = true;
                console.log('jsPDF library loaded successfully');
                console.log('After status is - ', this.jsPDFInitialize);
            }).catch((error) => {
                console.log('Error loading jsPDF library', error);
            });
        }
    }

    // Step 2 : Create a instance of jsPDF to generate PDF
    generatePDF() {
        console.log('On Button click status is - ', this.jsPDFInitialize);
        if (this.jsPDFInitialize) {
            // const { jsPDF } = window.jspdf;
            // const doc = new jsPDF(); // Initialize jsPDF instance, which represents the PDF document to be generated
            const doc = new window.jspdf.jsPDF(); // Initialize jsPDF instance, which represents the PDF document to be generated
            doc.text('Hello Nilisha !!', 10, 10);
            doc.save('nilishagenratesample.pdf'); // Saves the PDF as "nilisha genrate sample.pdf"
            console.log('PDF generated successfully !!');
        } else {
            console.log('jsPDF library not loaded yet !!');
        }
    }

}