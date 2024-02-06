import { LightningElement, track } from 'lwc';
import IMAGEE from "@salesforce/resourceUrl/blurimage";

export default class DemoCSS extends LightningElement {
    @track img = IMAGEE;
    
}