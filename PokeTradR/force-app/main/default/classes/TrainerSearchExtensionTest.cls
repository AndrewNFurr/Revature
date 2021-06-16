@isTest
public class TrainerSearchExtensionTest {
	
   @testSetup
    public static void newTR(){
     //create a trainer being reported, query it, and use the id as the relationship field.
     Trainer__c newT = new Trainer__c(
     		Name = 'Testy Dummy'
     );
        
      insert newT;  
     
     Trainer__c newTrainer = [SELECT Id, Name FROM Trainer__c WHERE Name=:'Testy Dummy'];
        
    Complaint__c newTrainerComplaint = new Complaint__c(
        Trainer_Being_Reported__c = 'Testy Dummy',
        Trainer_Reported__c = newTrainer.Id,
    	Reason__c = 'Harassment',
    	Issue__c = 'shshshs'
		);
        insert newTrainerComplaint;
        
    }
    
    
    @isTest
    public static void searchTest(){
 
        Test.startTest();
        PageReference pageRef = Page.TrainerComplaints;
        Test.setCurrentPage(pageRef);
        
        TrainerSearchExtension TSE = new TrainerSearchExtension(new apexPages.standardController([SELECT Trainer_Being_Reported__c FROM Complaint__c]));
		TSE.userInput = 'Testy Dummy';
        TSE.isSearched = true;
        TSE.returnMatchingComplaints();
        list<Complaint__c> newComplaint = TSE.searchComplaints;
        String name = newComplaint[0].Trainer_Being_Reported__c;
        Test.stopTest();
        
        system.assertEquals('Testy Dummy', name);
    }
    

}