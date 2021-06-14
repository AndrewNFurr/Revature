@IsTest
public class PokemonClassTest {

    //Setting up a test entry to search
    @TestSetup
    public static void testCreate(){
        Pokemon__c p = new Pokemon__c(
            Name='01 Test',
            Pokemon__c='Bulbasaur',
            Status__c='Approved'       
        );
        
        insert p;
    }    
    
    //Testing for the search function
    @IsTest 
    public static void testSearch(){
        Test.startTest();
            //Setting up our page reference for the visualforce page
            PageReference pageRef = Page.PokemonPage;
            Test.setCurrentPage(pageRef);
            //Pokemon search works off the Pokemon__c field which contains a picklist. Using Bulbasaur as the test
            String nameSearch = 'Bulbasaur';    
            PokemonSearchController ps = new PokemonSearchController();
            //Assigning the user input search to bulbasaur 
            ps.pokemonName = nameSearch;
            ps.renderTable = true;
            //invoking the method from controller
            ps.searchForPokemon(); 
            ps.setController = null;
            Pokemon__c pokemonTest = [SELECT Id, Name, Status__c FROM Pokemon__c WHERE Name='01 Test' Limit 1];
        Test.stopTest();	
        system.debug(ps.myId);
        system.debug(pokemonTest.Id);
        //Testing that the pokemon search Id matches the pokemon Test Id
        System.assertEquals(ps.myId,pokemonTest.Id); 
        
	}
    
    @IsTest 
    //Replicating above test, refactoring for code coverage on renderTable False
    public static void testSearch2(){
        Test.startTest();
            PageReference pageRef = Page.PokemonPage;
            Test.setCurrentPage(pageRef);
            String nameSearch = 'Bulbasaur';    
            PokemonSearchController ps = new PokemonSearchController();
            ps.pokemonName = nameSearch;
            ps.renderTable = false;
            ps.searchForPokemon(); 
            ps.setController = null;
            Pokemon__c pokemonTest = [SELECT Id, Name, Status__c FROM Pokemon__c WHERE Name='01 Test' Limit 1];
        Test.stopTest();	
        system.debug(ps.myId);
        system.debug(pokemonTest.Id);
        System.assertEquals(ps.myId,pokemonTest.Id); 
        
	}
    
    @IsTest 
    //Refactoring for when a search that doesn't equal a Pokemon name 
    public static void badSearch(){
        Test.startTest();
            PageReference pageRef = Page.PokemonPage;
            Test.setCurrentPage(pageRef);
            String nameSearch = '29398';    
            PokemonSearchController ps = new PokemonSearchController();
            ps.pokemonName = nameSearch;
            ps.renderTable = false;
            ps.searchForPokemon(); 
            ps.setController = null;
        Test.stopTest();	
        System.assertEquals(Null,ps.setController);     
	}
}