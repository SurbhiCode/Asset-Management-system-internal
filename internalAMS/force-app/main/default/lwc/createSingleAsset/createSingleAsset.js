import { LightningElement } from 'lwc';

export default class CreateSingleAsset extends LightningElement {
    fields = ['Name', 'Type', 'Quantity']; // Add your fields here

    handleSuccess(event) {
        // Handle successful record creation
        this.dispatchEvent(new CustomEvent('close'));
    }

    handleCancel() {
        // Handle cancel button click
        this.dispatchEvent(new CustomEvent('close'));
    }
}