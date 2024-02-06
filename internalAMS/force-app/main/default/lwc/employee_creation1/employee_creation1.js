import { LightningElement, api, wire } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import { NavigationMixin } from 'lightning/navigation';
import { createRecord } from 'lightning/uiRecordApi';
import { getObjectInfo } from 'lightning/uiObjectInfoApi';
import Phone__c from '@salesforce/schema/Employee__c.Phone__c';
import Location__c from '@salesforce/schema/Employee__c.Location__c';
import Email__c from '@salesforce/schema/Employee__c.Email__c';
import Employee_Name__c from '@salesforce/schema/Employee__c.Employee_Name__c';
import Department_Name__c from '@salesforce/schema/Employee__c.Department_Name__c';
import Joining_Date__c from '@salesforce/schema/Employee__c.Joining_Date__c';
import employee from '@salesforce/schema/Employee__c'; 
import 	Name from '@salesforce/schema/Employee__c.Name';
import { RefreshEvent } from "lightning/refresh";
//import EMPLOYEEBACKGROUND from "@salesforce/resourceUrl/employeebackground";
 
export default class EmployeeCreation1 extends NavigationMixin(LightningElement) {
   
    //Img = IMAGES;
    fields = [Employee_Name__c, Phone__c, Location__c, Email__c, Department_Name__c, Joining_Date__c];
    isShowModal=false;
    Employeetemp=true;
    isShowsecondModal = false;
    //recordid='';
    handleSuccess(event) {
        const recordId = event.detail.id;
        const evt = new ShowToastEvent({
                title: 'Employee Created ',
                message: 'Record Created Successfully!!',
                variant: 'success',
    
            });
            
        this[NavigationMixin.Navigate]({
            type: 'standard__recordPage',
            attributes: {
                recordId: recordId,
                //objectApiName: 'Employee__c',
                actionName: 'view',
            }
        });
        this.dispatchEvent(evt);
        //console.log('evet Id50',event.detail.id);


     }
    

// navigateToRecordPage(event){

//     console.log('evet Id',event.detail.id);
//     const evt = new ShowToastEvent({
//         title: 'Record Created Successfully!',
//         message: 'Record Created Successfully!!'+ event.detail.id,
//         variant: 'success',
        
//     });
//     this.dispatchEvent(evt);

//       // Option 1: Using NavigationMixin.GenerateUrl
//     //   this[NavigationMixin.GenerateUrl]({
//     //     type: 'standard__recordPage',
//     //     attributes: {
//     //         recordId: event.detail.id,
//     //         objectApiName: 'Employee__c',
//     //         actionName: 'view',
//     //     },
//     // }).then(url => {
//     //     window.location.href = url;
//     // });

//     // Option 2: Using NavigationMixin.Navigate
    
// }

// // handleRecordClick() {
// //     this[NavigationMixin.GenerateUrl]({
// //         type: 'standard__recordPage',
// //         attributes: {
// //             recordId: recordid,
// //             actionName: 'view',
// //         },
// //     });
// // }



//
 }