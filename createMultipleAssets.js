
import { LightningElement, track, api } from 'lwc';
import getEquipmentsOptions from '@salesforce/apex/AssetApexController.getEquipmentsOptions';
import getBrandOptions from '@salesforce/apex/AssetApexController.getBrandOptions';
import getStatusOptions from '@salesforce/apex/AssetApexController.getStatusOptions';
import getLocationOptions from '@salesforce/apex/AssetApexController.getLocationOptions';
import IMAGE from "@salesforce/resourceUrl/backgroundimage";
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import createrecords from '@salesforce/apex/AssetApexController.createRecords';
import createsinglerecord from '@salesforce/apex/AssetApexController.createRecordssingle';
export default class CreateMultipleAssets extends LightningElement {

    // Track modal visibility
    @track showPhysicalModal = false;
    @track showDigitalModal = false;
    @track showHvacModal = false;

    // Track data and errors
    @track data = [];
    @track error;
    @track result = [];

     // Track form fields
    @track equipmentOptions = [];
    @track brandOptions = [];
    @track equipmentValues = '';
    @track brandnames = '';
    @track equipmentValuess;
    @track brandnamess;
    @track status;
    @track location;
    @track Number_of_Records=0;
    @track purchase_amount;
    @track purchase_date;

    // Image URL
    @track IMG = IMAGE;

     // Method to open Physical Asset modal
    createPhysicalAsset() {
        this.showPhysicalModal = true;
        
        getBrandOptions()
            .then((res) => {
                this.brandOptions = res.map((value) => ({ label: value, value }));    
                // this.brandOptions = res;
            })
            .catch((error) => {
                console.error('Error is' + JSON.stringify(error));
            });
        getEquipmentsOptions()
            .then((res) => {
                this.equipmentOptions = res.map((value) => ({ label: value, value }));
               
            })
            .catch((error) => {
                console.error('Error is' + JSON.stringify(error));
            });
        getStatusOptions()
            .then((res) => {
            this.statusOptions = res.map((value) => ({ label: value, value }));
            console.log('Line 64==' + JSON.stringify(this.statusOptions));
            })
            .catch((error) => {
            console.error('Error is' + JSON.stringify(error));
            });
        getLocationOptions()
            .then((res) => {
            this.locationOptions= res.map((value) => ({ label: value, value }));
            console.log('Line 64==' + JSON.stringify(this.locationOptions));
            })
            .catch((error) => {
            console.error('Error is' + JSON.stringify(error));
            });
    }

    // Method to open Digital Asset modal
    createDigitalAsset() {
        this.showDigitalModal = true;
        console.log('====> Entered');
        getBrandOptions()
        .then((res) => {
            this.brandOptions = res.map((value) => ({ label: value, value }));
            console.log('Line 64==' + JSON.stringify(this.brandOptions));
        })
        .catch((error) => {
            console.error('Error is' + JSON.stringify(error));
        });
        getEquipmentsOptions()
            .then((res) => {
                this.equipmentOptions = res.map((value) => ({ label: value, value }));
                console.log('Line 64==' + JSON.stringify(this.equipmentOptions));
            })
            .catch((error) => {
                console.error('Error is' + JSON.stringify(error));
            });
        getStatusOptions()
            .then((res) => {
            this.statusOptions = res.map((value) => ({ label: value, value }));
            console.log('Line 64==' + JSON.stringify(this.statusOptions));
            })
            .catch((error) => {
            console.error('Error is' + JSON.stringify(error));
            });
        getLocationOptions()
            .then((res) => {
            this.locationOptions= res.map((value) => ({ label: value, value }));
            console.log('Line 64==' + JSON.stringify(this.locationOptions));
            })
            .catch((error) => {
            console.error('Error is' + JSON.stringify(error));
            });
    }
    // Method to open HVAC Asset modal
    createHVACAsset() {
        this.showHvacModal = true;
        console.log('====> Entered');
        getBrandOptions()
        .then((res) => {
            this.brandOptions = res.map((value) => ({ label: value, value }));
            console.log('Line 64==' + JSON.stringify(this.brandOptions));
        })
        .catch((error) => {
            console.error('Error is' + JSON.stringify(error));
        });
        getEquipmentsOptions()
            .then((res) => {
                this.equipmentOptions = res.map((value) => ({ label: value, value }));
                console.log('Line 64==' + JSON.stringify(this.equipmentOptions));
            })
            .catch((error) => {
                console.error('Error is' + JSON.stringify(error));
            });
        getStatusOptions()
            .then((res) => {
            this.statusOptions = res.map((value) => ({ label: value, value }));
            console.log('Line 64==' + JSON.stringify(this.statusOptions));
            })
            .catch((error) => {
            console.error('Error is' + JSON.stringify(error));
            });
        getLocationOptions()
            .then((res) => {
            this.locationOptions= res.map((value) => ({ label: value, value }));
            console.log('Line 64==' + JSON.stringify(this.locationOptions));
            })
            .catch((error) => {
            console.error('Error is' + JSON.stringify(error));
            });
    }
    // Method to open HVAC Asset modal
    handleNameFieldChange(event) {
        this.brandnames = event.target.value;
        console.log('brandnames' + this.brandnames);
        
    }
    // Method to handle change in equipment field
    handleEquipmentFieldChange(event) {
        this.equipmentValues = event.target.value;
        console.log('equipments' + this.equipmentValues);
    }

     // Method to close Physical Asset modal
    closeModalOne() {
        this.showPhysicalModal = false;
    }
     // Method to close Digital Asset modal
    closeModalTwo() {
        this.showDigitalModal = false;
    }
    // Method to close HVAC Asset modal
    closeModalThree() {
        this.showHvacModal = false;
    }
    // Method to handle change in equipment field 
    handleEquipmentFieldChange(event){
        this.equipmentValuess = event.detail.value;
    }
    // Method to handle change in brand name field 
    handleNameFieldChange(event){
        this.brandnamess= event.detail.value;
    }
    // Method to handle change in status field
    handleStatusFieldChange(event)
    {
        this.status=event.detail.value;
    }
    // Method to handle change in location field
    handlelocationFieldChange(event)
    {
        this.location=event.detail.value;
    }
    // Method to handle change in the number of records field
    handleRecordFieldChange(event)
    {
        this.Number_of_Records=event.detail.value;
    }
     // Method to handle change in the purchase amount field
    purchaseamount(event)
    {
        this.purchase_amount=event.detail.value;

    }
    // Method to handle change in the posting date field
    PostingDateChange(event)
    {
        this.purchase_date=event.detail.value;

    }
     // Method to save records for Digital and HVAC modals
    saveFirstPopup2() 
    {
    if(this.equipmentValuess != null){
        createsinglerecord({ equipmentValuess: this.equipmentValuess,
            brandnamess: this.brandnamess,
            status: this.status,
            location: this.location,
            purchasedate:this.purchase_date,
            Amount:this.amount
            })
            .then(result => {
                this.showDigitalModal=false;
                this.showHvacModal=false;
                this.showPhysicalModal=false;
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: 'Success',
                        message: 'Records created successfully',
                        variant: 'success'
                    })
                );
                this.equipmentValues='';
                this.brandnamess='';
                this.status='';
                this.location=''; 
                this.amount=0;
                ;
            })
            .catch(error => {
                // Handle error
                console.error('Error creating records:', error.body.message);

                this.dispatchEvent(
                    new ShowToastEvent({
                        title: 'Error',
                        message: 'Error creating records: ' + error.body.message,
                        variant: 'error'
                        })
                    );
                });
        }
        else{
            alert('Please fill the Required fields ')
        }
    }
    // Method to save records for Physical modal
    saveFirstPopup() {
    if(this.equipmentValuess != null && this.Number_of_Records != 0){
        createrecords({ equipmentValuess: this.equipmentValuess,
            brandnamess: this.brandnamess,
            status: this.status,
            location: this.location,
            purchasedate:this.purchase_date,
            Amount:this.amount,
            Number_of_Records: this.Number_of_Records})
            .then(result => {
                this.showPhysicalModal=false;
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: 'Success',
                        message: 'Records created successfully',
                        variant: 'success'
                    })
                );
                this.equipmentValues='';
                this.brandnamess='';
                this.status='';
                this.location='';
                
                this.amount=0;
                
            })
            .catch(error => {
                // Handle error
                console.error('Error creating records:', error.body.message);

                this.dispatchEvent(
                    new ShowToastEvent({
                        title: 'Error',
                        message: 'Error creating records: ' + error.body.message,
                        variant: 'error'
                    })
                );
            });

    }else{
        alert('Please fill the Required fields ')
         }   
    }
}
