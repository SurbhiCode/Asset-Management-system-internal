import { LightningElement, track } from 'lwc';

export default class AssetManager extends LightningElement {
    @track isSingleAssetModalOpen = false;
    @track isMultipleAssetModalOpen = false;

    openSingleAssetModal() {
        this.isSingleAssetModalOpen = true;
    }

    closeSingleAssetModal() {
        this.isSingleAssetModalOpen = false;
    }

    openMultipleAssetModal() {
        this.isMultipleAssetModalOpen = true;
    }

    closeMultipleAssetModal() {
        this.isMultipleAssetModalOpen = false;
    }
}