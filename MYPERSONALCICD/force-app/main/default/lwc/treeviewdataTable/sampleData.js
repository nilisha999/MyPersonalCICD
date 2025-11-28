// Parent columns definition
export const PARENT_COLUMNS_DEFINITION = [
    { type: 'text', fieldName: 'accountName', label: 'Account Name' },
    { type: 'phone', fieldName: 'phone', label: 'Phone Number' },
    { type: 'text', fieldName: 'employees', label: 'Employees' },
    { type: 'url', fieldName: 'accountOwner', label: 'Account Owner', typeAttributes: { label: { fieldName: 'accountOwnerName' } } },
    { type: 'text', fieldName: 'billingCity', label: 'Billing City' },
];

// Child columns definition
export const CHILD_COLUMNS_DEFINITION = [
    { type: 'text', fieldName: 'accountName', label: 'Account Name' },
    { type: 'text', fieldName: 'employees', label: 'Employees' },
    { type: 'email', fieldName: 'email', label: 'Email Id' },
    { type: 'phone', fieldName: 'phone', label: 'Phone Number' },
    { type: 'url', fieldName: 'accountOwner', label: 'Account Owner', typeAttributes: { label: { fieldName: 'accountOwnerName' } } },
    { type: 'text', fieldName: 'billingCity', label: 'Billing City' },
];

// Sample data with potential nested children
export const UPDATED_DATA_WITH_CHILDREN = [
    {
        name: '123555',
        accountName: 'Rewis Inc',
        employees: 3100,
        phone: '837-555-0100',
        accountOwner: 'http://salesforce.com/fake/url/jane-doe',
        accountOwnerName: 'Jane Doe',
        billingCity: 'Phoeniz, AZ',
    },
    {
        name: '123556',
        accountName: 'Acme Corporation',
        employees: 10000,
        phone: '837-555-0100',
        accountOwner: 'http://salesforce.com/fake/url/jane-doe',
        accountOwnerName: 'John Doe',
        billingCity: 'San Francisco, CA',
        _children: [
            {
                name: '123556-A',
                accountName: 'Acme Corporation (Bay Area)',
                employees: 3000,
                phone: '837-555-0100',
                accountOwner: 'http://salesforce.com/fake/url/jane-doe',
                accountOwnerName: 'John Doe',
                billingCity: 'New York, NY',
                _children: [
                    {
                        name: '123556-A-A',
                        accountName: 'Acme Corporation (Oakland)',
                        employees: 745,
                        email: 'nilisha99@gmail.com',
                        phone: '837-555-0100',
                        accountOwner: 'http://salesforce.com/fake/url/jane-doe',
                        accountOwnerName: 'John Doe',
                        billingCity: 'New York, NY',
                    },
                    {
                        name: '123556-A-B',
                        accountName: 'Acme Corporation (San Francisco)',
                        employees: 578,
                        email: 'nilisha99@gmail.com',
                        phone: '837-555-0100',
                        accountOwner: 'http://salesforce.com/fake/url/jane-doe',
                        accountOwnerName: 'Jane Doe',
                        billingCity: 'Los Angeles, CA',
                    },
                ],
            },
        ],
    },
];