public class PokemonSearchController {
    
    //Setting up our variables for our method
    public String pokemonName{get;set;}
    public Boolean renderTable{get;set;}
    public ApexPages.StandardSetController setController {get;set;}
    public String testName = 'Test';
    //public static List<Pokemon__c> poke; 
    
    //Where our queried result will be stored
    public List<Pokemon__c> pokemon {get{
        return this.setController.getSelected();
    }}
    
    //Initially setting up the table as false when nothing is searched
    Public PokemonSearchController(){    
        this.renderTable=false;
    }
    
    //User will input a pokemon name and it will return the pokedex entry on that particular one
    public void searchForPokemon(){
        
        //Using string.escapeSingleQuotes to protect data in the org from malicious attempts
        this.pokemonName = String.escapeSingleQuotes(this.pokemonName);
        List<Pokemon__c> poke = Database.query('SELECT Id, Pokemon__c, Height_m__c, Weight_g__c, Type1__c, Type2__c, HP__c, Attack__c, Defense__c, Special_Attack__c, Special_Defense__c, Speed__c, Entry__c FROM Pokemon__c WHERE Pokemon__c=\''+
                                               this.pokemonName+'\'');
        system.debug(poke);
        if(this.setController==null){
            this.setController = new ApexPages.StandardSetController(poke);
            system.debug(this.setController.getSelected());
        }else{
            this.setController.setSelected(poke);
            system.debug(this.setController.getSelected());
        }
        if(this.renderTable != true){
            this.renderTable = true;
        }     
    }
    
    //public static void debug(){
        //system.debug(poke);
    //}
}