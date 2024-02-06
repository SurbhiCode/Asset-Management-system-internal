import { LightningElement,wire,track} from 'lwc';
import { getPicklistValues } from 'lightning/uiObjectInfoApi';
import OBJECT_FIELD from '@salesforce/schema/Asset__c.Equipments__c';
export default class Multiplee_asset_creeation extends LightningElement {
    @track isModalOpen = false;
    @track name = '';
    @track type = '';
    @track typeOptions = [];
    @wire(getPicklistValues, {
        recordTypeId: '$objectInfo.data.defaultRecordTypeId',
        fieldApiName: OBJECT_FIELD
    })
    wiredPicklistValues({ error, data }) {
        if (data) {
            this.typeOptions = data.values.map(option => ({
                label: option.label,
                value: option.value
            }));
        } else if (error) {
            console.error(error);
        }
    }
    openModal() {
        this.isModalOpen = true;
    }
    closeModal() {
        this.isModalOpen = false;
    }

   
}