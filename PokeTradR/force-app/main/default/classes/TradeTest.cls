@isTest
public class TradeTest {
	
    @isTest static void testTradeExtension() {
        PageReference testPage = Page.TradeSelectionPage;
        Trainer__c test1 = new Trainer__c (
            Name='Test1'
        );
        Trainer__c test2 = new Trainer__c (
            Name='Test2'
        );
        insert test1;
        insert test2;
        List<Trainer__c> tList = [
            SELECT Id, Name
            FROM Trainer__c
            WHERE Name Like '%Test%'
        ];
        
        Trade__c testTrade = new Trade__c(
            Name='TestTrade',
            Trainer_Name__c=tList[0].Id,
            Recipient__c=tList[1].Id,
            Status__c='New'
        );
        
        insert testTrade;
        
        Offer__c testOffer = new Offer__c(
        	Name='TestOffer',
            Owner__c=tList[0].Id,
            Trainer_Name__c=tList[1].Id,
            Trade__c=testTrade.Id,
            Accepted__c='Accepted'
        );
        Offer__c testOffer2 = new Offer__c(
        	Name='TestOffer2',
            Owner__c=tList[0].Id,
            Trainer_Name__c=tList[1].Id,
            Trade__c=testTrade.Id,
            Accepted__c='Pending'
        );
        
        insert testOffer;
        insert testOffer2;
        Test.startTest();
        Test.setCurrentPage(testPage);
        TradeExtension ext = new TradeExtension(new ApexPages.StandardController(testTrade));
        TradeExtension.currentId = [
            SELECT Id
            FROM Trade__c
            WHERE Name='TestTrade'
            LIMIT 1
        ].Id;
        
        PageReference pr = Page.TradePage;
        pr.getParameters().put('id', TradeExtension.currentId);

        ext.saveOfferChanges();
        Test.stopTest();
        System.assertEquals(TradeExtension.currentId, testTrade.Id);
        System.assertEquals(ext.goToTrade().getUrl(), pr.getUrl());
        System.assertEquals(True, ext.offers.size()>0);
        System.assertEquals('TestOffer', ext.currOffer.Name);
        System.assertEquals(True, ext.recipientTrainer != null);
        System.assertEquals(True, ext.getRecBio() != null);
        System.assertEquals(True, ext.getRecName() != null);
        System.assertEquals(True, ext.getRecRank() != null);
        System.assertEquals('Declined', ext.offers[1].Accepted__c);
    }
    
    @isTest static void testNegative() {
        Trainer__c tester4 = new Trainer__c (
            Name='Tester3'
        );
        Trainer__c tester3 = new Trainer__c (
            Name='Tester4'
        );
        insert tester3;
        insert tester4;
        List<Trainer__c> tList2 = [
            SELECT Id, Name
            FROM Trainer__c
            WHERE Name Like '%Tester%'
        ];
        Trade__c testTrade2 = new Trade__c(
            Name='TestTrade2',
            Trainer_Name__c=tList2[0].Id,
            Recipient__c=tList2[1].Id,
            Status__c='New'
        );
        
        Test.startTest();
        TradeExtension ext2 = new TradeExtension(new ApexPages.StandardController(testTrade2));
        PageReference pr2 = Page.TradePage;
        Test.stopTest();
        System.assertEquals(False, ext2.offers.size()>0);
        System.assertEquals(null, ext2.currOffer.Name);
        System.assertEquals(True, ext2.recipientTrainer == null);
        System.assertEquals(False, ext2.getRecBio() != null);
        System.assertEquals(False, ext2.getRecName() != null);
        System.assertEquals(False, ext2.getRecRank() != null);
    }
}