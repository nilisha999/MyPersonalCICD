import { LightningElement } from 'lwc';
import { loadStyle } from 'lightning/platformResourceLoader';
import OPEN_SANS from '@salesforce/resourceUrl/static1';  // Make sure the static resource name is correct
import ROBOTO from '@salesforce/resourceUrl/static2';  // Correct name for the second font

export default class SelfExperimentDT extends LightningElement {
    // The connectedCallback() method to load fonts dynamically when the component is inserted into the DOM
    connectedCallback() {
        // Load the styles from the static resources
        Promise.all([
            loadStyle(this, OPEN_SANS),  // Load Open Sans font style
            loadStyle(this, ROBOTO)      // Load Roboto font style
        ])
            .then(() => {
                console.log('Fonts Loaded Successfully');
            })
            .catch(error => {
                console.error('Error loading fonts: ', error);
            });
    }

    // Handle the icon click to toggle table row details
    handleIconClick(event) {
        const clickedElement = event.target;

        // Check if the clicked element is a 'span' with 'fa' class (FontAwesome icon)
        if (clickedElement.tagName === 'SPAN' && clickedElement.classList.contains('fa')) {
            const parentTr = clickedElement.closest('tr');  // Find the closest parent <tr> element

            // If the icon is rotated (indicating the details are visible), collapse the details
            if (clickedElement.classList.contains('fa-rotate-90')) {
                clickedElement.classList.remove('fa-rotate-90');  // Remove rotation class

                const nextTr = parentTr.nextElementSibling;  // Get the next <tr> for details
                if (nextTr && nextTr.classList.contains('tr-detail')) {
                    const detailCells = nextTr.querySelectorAll('td');
                    detailCells.forEach(cell => {
                        cell.style.padding = '0';  // Reset padding
                    });

                    // Hide the detail row and remove it
                    nextTr.querySelector('div').style.display = 'none'; // Slide-up effect
                    nextTr.remove();
                    parentTr.classList.remove('tr-selected');  // Remove the selected style
                }
                return;
            }

            // If the icon is not rotated, expand the details row
            clickedElement.classList.add('fa-rotate-90');  // Add rotation class

            // Avoid adding duplicate detail row if it already exists
            const nextTr = parentTr.nextElementSibling;
            if (nextTr && nextTr.classList.contains('tr-detail')) return;

            parentTr.classList.add('tr-selected');  // Add selected style to the parent row

            // Clone the <tr> for the details and insert it after the current row
            const trDetail = this.template.querySelector('#tr-detail').cloneNode(true);
            trDetail.classList.remove('hidden');  // Remove hidden class
            parentTr.insertAdjacentElement('afterend', trDetail);  // Insert the details after the parent row

            // Show the content inside the detail row (SlideDown effect simulation)
            const detailDiv = trDetail.querySelector('div');
            detailDiv.style.display = 'block';  // Set display to 'block' for showing the content
        }
    }
}