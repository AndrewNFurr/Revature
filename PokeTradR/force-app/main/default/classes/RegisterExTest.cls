@isTest
public class RegisterExTest {
	@isTest
    public static void resTest(){
        Test.startTest();
        //set the current page
        PageReference thispage = Page.TrainerProfile;
        Test.setCurrentPage(thispage);
        
        Trainer__c t = new Trainer__c(Name ='Test', Password__c ='123456', First_Name__c = 'A', Last_Name__c = 'B',Birthday__c =Date.newInstance(1991, 12, 21));
        ApexPages.StandardController sc = new ApexPages.StandardController(t);
        RegisterExtension temp = new RegisterExtension(sc);
        temp.fillInAdditionalInfo();
        Trainer__c myt = [SELECT Age__c, Dated_Joined__c, Status__c FROM Trainer__c WHERE Name = 'Test' LIMIT 1];
        test.stopTest();
       	System.debug(myt);
        System.assertNotEquals(null, myt.Age__c);
        System.assertEquals(System.today(), myt.Dated_Joined__c);
        System.assertEquals('Active', myt.Status__c);
    }
    @isTest
    public static void trans(){
        Test.startTest();
        //set the current page
        PageReference thispage = Page.RegisterConfirmation;
        Test.setCurrentPage(thispage);
               
        RegisterBackToLogin temp = new RegisterBackToLogin();
        PageReference page = temp.backToLogin();
        test.stopTest();
       
        System.assertNotEquals(thispage, page);
    }
}