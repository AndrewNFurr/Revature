@IsTest
public class TrainerTriggerTest {
    
    //Testing when Rank starts at Rookie status
    @IsTest
    public static void rookieTrainer(){

        
	Test.startTest();
    //test trainer created and inserted
	Trainer__c newT = new Trainer__c(Name = 'Test01', Trades_Made__c = 0, Offers_Made__c = 0);
	insert newT;
	
    //SOQL query for that trainer and assigning it to a variable    
	Trainer__c testT = [SELECT Id FROM Trainer__c WHERE Name = 'Test01' LIMIT 1];

	//Loop to insert a new trade under that test Trainer
    List<Trade__c> trList = new List<Trade__c>();  
    List<Offer__c> OffList = new List<Offer__c>();    
	for(Integer i=0; i<1; i++){
		Trade__c newTr = new Trade__c(Name = 'Test Trade', Trainer_Name__c = testT.Id, Status__c = 'New', Asking_For__c = 'Money');
		trList.add(newTr);
	
	}
    insert trList;
    //SOQL query for that new Trade that was created    
    List<Trade__c> testTr = [SELECT Id FROM Trade__c WHERE Name = 'Test Trade'];
    
    //Loop to insert a new offer under that Test Trainer and Test Trade   
    for(Integer i=0; i<1; i++){
    Offer__c newOff = new Offer__c(Name = 'Test Offer', Trainer_Name__c = testT.Id, Trade__c = TestTr[0].Id);
		OffList.add(newOff);
    }     
    insert offList;

	//Pulling all relevant fields that should be affected by the above insertions
	List<Trainer__c> t2 = [SELECT Trades_Made__c, Offers_Made__c, Rank__c FROM Trainer__c WHERE Name = 'Test01' LIMIT 1];
	Test.stopTest(); 
	
    //Trades Made and Offers Made should increase by 1 and status should remain at Rookie    
    System.assertEquals(1, t2[0].Trades_Made__c);
    System.assertEquals(1, t2[0].Offers_Made__c);    
    System.assertEquals('Rookie', t2[0].Rank__c);
}
    //Testing when Rank reaches Intermediate status.  
    @IsTest
    public static void intermediateTrainer(){

	Test.startTest();
    //Our test trainer will have 24 trades made instead since 25 combined trades and offers is Intermediate rank    
	Trainer__c newT = new Trainer__c(Name = 'Test01', Trades_Made__c = 24, Offers_Made__c = 0);
	insert newT;

	Trainer__c testT = [SELECT Id FROM Trainer__c WHERE Name = 'Test01' LIMIT 1];


    List<Trade__c> trList = new List<Trade__c>();  
    List<Offer__c> OffList = new List<Offer__c>();    
	for(Integer i=0; i<1; i++){
		Trade__c newTr = new Trade__c(Name = 'Test Trade', Trainer_Name__c = testT.Id, Status__c = 'New', Asking_For__c = 'Money');
		trList.add(newTr);
	
	}
    insert trList;
    List<Trade__c> testTr = [SELECT Id FROM Trade__c WHERE Name = 'Test Trade'];
        
    for(Integer i=0; i<1; i++){
    Offer__c newOff = new Offer__c(Name = 'Test Offer', Trainer_Name__c = testT.Id, Trade__c = TestTr[0].Id);
		OffList.add(newOff);
    }     
    insert offList;


	List<Trainer__c> t2 = [SELECT Trades_Made__c, Offers_Made__c, Rank__c FROM Trainer__c WHERE Name = 'Test01' LIMIT 1];
	Test.stopTest(); 
	
    //Testing only the rank up to Intermediate since combined they should have 26   
    System.assertEquals('Intermediate', t2[0].Rank__c);
}
    //Testing when Rank reaches Expert status
    @IsTest
    public static void expertTrainer(){

	Test.startTest();
    //Our test trainer will have 49 trades made instead since 50 combined trades and offers is Expert rank    
	Trainer__c newT = new Trainer__c(Name = 'Test01', Trades_Made__c = 49, Offers_Made__c = 0);
	insert newT;

	Trainer__c testT = [SELECT Id FROM Trainer__c WHERE Name = 'Test01' LIMIT 1];


    List<Trade__c> trList = new List<Trade__c>();  
    List<Offer__c> OffList = new List<Offer__c>();    
	for(Integer i=0; i<1; i++){
		Trade__c newTr = new Trade__c(Name = 'Test Trade', Trainer_Name__c = testT.Id, Status__c = 'New', Asking_For__c = 'Money');
		trList.add(newTr);
	
	}
    insert trList;
    List<Trade__c> testTr = [SELECT Id FROM Trade__c WHERE Name = 'Test Trade'];
        
    for(Integer i=0; i<1; i++){
    Offer__c newOff = new Offer__c(Name = 'Test Offer', Trainer_Name__c = testT.Id, Trade__c = TestTr[0].Id);
		OffList.add(newOff);
    }     
    insert offList;


	List<Trainer__c> t2 = [SELECT Trades_Made__c, Offers_Made__c, Rank__c FROM Trainer__c WHERE Name = 'Test01' LIMIT 1];
	Test.stopTest(); 
	
    //Testing only the rank up to Expert since combined they should have 51    
    System.assertEquals('Expert', t2[0].Rank__c);
}
     //Testing when Rank reaches Master status
    @IsTest
    public static void masterTrainer(){

	Test.startTest();
    //Our test trainer will have 74 trades made instead since 75 combined trades and offers is Expert rank     
	Trainer__c newT = new Trainer__c(Name = 'Test01', Trades_Made__c = 74, Offers_Made__c = 0);
	insert newT;

	Trainer__c testT = [SELECT Id FROM Trainer__c WHERE Name = 'Test01' LIMIT 1];


    List<Trade__c> trList = new List<Trade__c>();  
    List<Offer__c> OffList = new List<Offer__c>();    
	for(Integer i=0; i<1; i++){
		Trade__c newTr = new Trade__c(Name = 'Test Trade', Trainer_Name__c = testT.Id, Status__c = 'New', Asking_For__c = 'Money');
		trList.add(newTr);
	
	}
    insert trList;
    List<Trade__c> testTr = [SELECT Id FROM Trade__c WHERE Name = 'Test Trade'];
        
    for(Integer i=0; i<1; i++){
    Offer__c newOff = new Offer__c(Name = 'Test Offer', Trainer_Name__c = testT.Id, Trade__c = TestTr[0].Id);
		OffList.add(newOff);
    }     
    insert offList;


	List<Trainer__c> t2 = [SELECT Trades_Made__c, Offers_Made__c, Rank__c FROM Trainer__c WHERE Name = 'Test01' LIMIT 1];
	Test.stopTest(); 
	
    //Testing only the rank up to Master since combined they should have 76   
    System.assertEquals('Master', t2[0].Rank__c);
}
    
    //This method tests the error that pops up when a Trainer account is deleted
    @isTest
    public static void preventDeleteTrainer(){
        //Creating two new trainers; One that can be deleted and the other cannot
            List<Trainer__c> tList = new List<Trainer__c>();
        	Trainer__c newT = new Trainer__c(Name = 'Test01', Trades_Made__c = 0, Offers_Made__c = 0);
       	 	Trainer__c newT2 = new Trainer__c(Name = 'Test02', Trades_Made__c = 1, Offers_Made__c = 0);
        
        	//Adding them to a list
        	tList.add(newT);
        	tList.add(newT2);
                
        	Test.startTest();
        		//Inserting the list of both trainers into database
        		insert tList;
            	//Attempting to delete both trainers
        		Database.DeleteResult[] result = Database.delete(tList, true);
        
        	Test.stopTest();
        	List<Trainer__c> test = [SELECT Id FROM Trainer__c WHERE Name LIKE 'Test%'];
            System.assertEquals(1, test.size());  
        	         
    }
    @isTest
    public static void testExceptionDelete(){
        
        List<Trainer__c> tList = new List<Trainer__c>();
        Trainer__c newT = new Trainer__c(Name = 'Test01', Trades_Made__c = 0, Offers_Made__c = 0);
        tList.add(newT);
        insert tList;
        
        List<Trainer__c> tList2 = [SELECT Id FROM Trainer__c WHERE Name LIKE 'Test%'];
        Boolean exceptionThrown = false;
        
        Try{
            Database.DeleteResult[] result = Database.delete(tList2);        	
        
        	}
        Catch(Exception e){
            exceptionThrown = true;
            
            Boolean expectedExceptionThrown = (e.getMessage().contains('Trainer needs to have no Active Trades or Offers to delete.')) ? true : false;
            system.assertEquals(true, expectedExceptionThrown, e.getMessage());
        }
        System.assertEquals(true, exceptionThrown, 'No exception was thrown');
          
    }

}