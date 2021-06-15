@isTest
public class LoginTest {
    @TestSetup
    public static void setup(){
        List<Trainer__c> temp = new List<Trainer__c>();
        for(Integer i=0; i<10; i++){
            Trainer__c t = new Trainer__c(Name ='Test' + i, Password__c ='123456', First_Name__c = 'A'+i, Last_Name__c = 'B'+i,Birthday__c =Date.newInstance(1991, 12, 21));
            temp.add(t);
        }
        
        insert temp;
    }
    @isTest
    public static void Login(){
        Test.startTest();
        //set the current page
        PageReference page = Page.Login;
        Test.setCurrentPage(page);
           
        //Controller - Success
        LoginClass log = new LoginClass();
        log.myusername = 'Test1';
        log.mypassword = '123456';
        PageReference nextpage = log.login();
        // Fail
        LoginClass log1 = new LoginClass();
        log1.myusername = 'Test69';
        log1.mypassword = '123456';
        PageReference nextpage1 = log1.login();
        
        LoginClass log2 = new LoginClass();
       	log2.myusername = '';
        log2.mypassword = '';
        
        LoginClass log3 = new LoginClass();
        log3.myusername = 'Test2';
        log3.mypassword = '12345612312';
        PageReference nextpage3 = log3.login();
        
        LoginClass register = new LoginClass();
        
        Test.stopTest();
        List <Trainer__c> check = [SELECT Id, Name FROM Trainer__c WHERE Name =: log.myusername LIMIT 1];
        
        
        System.assertEquals(check[0].Id, nextpage.getParameters().get('Id'));
        System.assertEquals(null, log2.login(), 'Please input username/password.');
        System.assertEquals(null, nextpage1, 'Username does not exist.');
        System.assertEquals(null, nextpage3, 'Username does not exist.');
        System.assertNotEquals(null, register.register());
    }
}