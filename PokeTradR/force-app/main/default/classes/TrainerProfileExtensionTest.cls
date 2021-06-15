@isTest
public class TrainerProfileExtensionTest {
	@isTest
    public static void trans(){
        Test.startTest();
        //set the current page
        PageReference thispage = Page.TrainerProfile;
        Test.setCurrentPage(thispage);
        
        Trainer__c t = new Trainer__c();
        ApexPages.StandardController sc = new ApexPages.StandardController(t);
        TrainerProfileExtension temp = new TrainerProfileExtension(sc);
        PageReference page = temp.login();
        test.stopTest();
       
        System.assertNotEquals(thispage, page);
    }
    
}