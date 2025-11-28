import { LightningElement, track } from 'lwc';

export default class Displayisro extends LightningElement {
    queryTerm;
    value = '';
    @track satelliteList = [];
    @track showSatelliteList = false;

    // Store the full dataset of satellites to filter from
    fullSatelliteData = [];

    countries = [
        'ALGERIA',
        'ARGENTINA',
        'BELGIUM',
        'BRAZIL',
        'CANADA',
        'DENMARK',
        'FRANCE',
        'GERMANY',
        'INDONESIA',
        'ISRAEL',
        'ITALY',
        'JAPAN',
        'LUXEMBOURG',
        'NORWAY',
        'REPUBLIC OF KOREA',
        'SINGAPORE',
        'SWITZERLAND',
        'THE NETHERLANDS',
        'TURKEY',
        'UK',
        'USA'
    ];

    connectedCallback() {
        console.log('Connected Callback Fired');
        this.fetchSatelliteData();
    }

    // Fetches the data from the public endpoint
    async fetchSatelliteData() {
        console.log('Enter into fetchSatelliteData');
        console.log('Fetching data from endpoint ');
        const endpoint = 'https://isro.vercel.app/api/customer_satellites';
        try {
            console.log('Fetching data from endpoint : ' + endpoint);

            const response = await fetch(endpoint);
            const data = await response.json();
            console.log(' response.ok is : ' + response.ok);
            if (!response.ok) {
                throw new Error(`HTTP error! status: ${response.status}`);
            }
            console.log('Parsing data to JSON format');

            console.log('Data is : ', data);

            // The Api response structure is {customer_satellites: [...]}
            this.fullSatelliteData = data.customer_satellites;
            // Correct logging variable name here.
            console.log('this.fullSatelliteData is : ', this.fullSatelliteData);
            console.log('Successfully fetched and parsed data.');
        }
        catch (error) {
            console.error('Error fetching satellite data : ', error);
            // Consistent variable name
            this.showSatelliteList = true;
            this.satelliteList = [{ country: 'Error', id: 'Error', name: 'Could not load data' }];
        }
    }

    get finalArray() {
        const countryOptions = this.countries.map(country => {
            return {
                label: country,
                value: country
            };
        });

        const initialOptions = [
            {
                label: 'Choose a Country',
                value: ''
            }
        ];

        return [...initialOptions, ...countryOptions];
    }

    handleChange(event) {
        console.log('Enetered into HandleChange block');

        this.value = event.detail.value;
        console.log('Event detail value : ' + event.detail.value);
        console.log('Event detail label : ' + event.detail.label);
        const selectedCountry = this.value;
        console.log('Selected Country : ' + selectedCountry);
        this.queryTerm = selectedCountry;
        console.log('Query term : ' + this.queryTerm);

        if (this.fullSatelliteData.length > 0 && this.countries.includes(selectedCountry)) {
            const filteredSatellites = this.fullSatelliteData.filter(satellite => satellite.country.toUpperCase() === selectedCountry.toUpperCase())
            // Correct the typo: map from 'name', not 'launcher' as requested in your previous query.
            this.satelliteList = filteredSatellites.map(sat => sat.launcher);
            // Consistent variable name
            this.showSatelliteList = true;
            // Log the satelliteList, which now contains the IDs
            console.log('Satellite List (IDs): ', this.satelliteList);
        }
        else {
            this.showSatelliteList = false;
            this.satelliteList = [];
        }
    }
}