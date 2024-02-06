// import { LightningElement ,track, wire } from 'lwc';
// // import getOptions from '@salesforce/apex/MyController.getOptions';
// import getAssets from '@salesforce/apex/MyController.getAssets';
// export default class Demo1 extends LightningElement {
    // @track selectedValue = '';
    // @track options = [];

    // @wire(getOptions)
    // wiredOptions({ error, data }) {
    //     if (data) {
    //         this.options = data.map(option => ({ label: option.Name, value: option.Id }));
    //     } else if (error) {
    //         console.error('Error fetching options:', error);
    //     }
    // }

    // handleChange(event) {
    //     this.selectedValue = event.detail.value;
    // }



//     @track searchTerm = '';
//     @track selectedAssetId = '';
//     @track filteredAssets = [];

//     @wire(getAssets, { searchTerm: '$searchTerm' })
//     wiredAssets({ error, data }) {
//         if (data) {
//             this.filteredAssets = data.map(asset => ({ label: asset.Name, value: asset.Id }));
//         } else if (error) {
//             console.error('Error fetching assets:', error);
//         }
//     }

//     handleSearchTermChange(event) {
//         this.searchTerm = event.target.value;
//     }

//     handleAssetSelection(event) {
//         this.selectedAssetId = event.detail.value;
//     }
// }

// myEmployeeSearchComponent.js
import { LightningElement, track,wire} from 'lwc';
import searchEmployees from '@salesforce/apex/MyController.searchEmployees';
const FIELDS = ['Employee__c.Id', 'Employee__c.Name']; // Add more fields as needed
export default class Demo1 extends LightningElement { 
    @track searchTerm = '';
    @track employeeId;
    handleSearchTermChange(event) {
        this.searchTerm = event.target.value;
    }

    @wire(searchEmployees, {
        recordId: '$employeeId',
        fields: FIELDS
    })
    wiredEmployee({ error, data }) {
        if (data) {
            // Handle the retrieved employee data if needed
            console.log('Employee Data:', data);
        } else if (error) {
            console.error('Error fetching employee data:', error);
        }
    }

    searchEmployee() {
        // You can add additional logic if needed
        this.employeeId = null; // Reset previous employeeId
        this.employeeId = this.searchTerm;
    }
}