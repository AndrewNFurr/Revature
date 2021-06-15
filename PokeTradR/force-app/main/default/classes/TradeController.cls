public class TradeController {

   //Variables
    
    public Trade__c currTrade;
    public Offer__c currOffer;   
    public List<Offer__c> offers {get {
        if (this.offers == null) {
            this.offers = [
                SELECT Name, Accepted__c, Pokemon__c, Money_Offered__c, Trainer_Name__c
                FROM Offer__c
                WHERE Trade__r.Id=:currTrade.Id
            ];
        }
        return this.offers;
    }set;} 

    public  List<Trainer__c> recipientTrainer {get {
        if (this.currTrade != null) {
            this.recipientTrainer = [
                SELECT Name, Id, Trainer_Id__c, Bio__c, Rank__c 
                FROM Trainer__c 
                WHERE Id =:currTrade.Recipient__c
            ];
        }
        return this.recipientTrainer;
    }set;}
    
    public Component.Apex.OutputText getRec(){
        if(recipientTrainer != null){
            Component.Apex.OutputText ot = new Component.Apex.OutputText();
            ot.value='' + recipientTrainer[0].Bio__c;
               return ot; 
        }else{
        	return null;
        }
    }
    
    PageReference pageRef = ApexPages.currentPage();
    
    //Methods
    
    public void showMe() {
        system.debug(currTrade);
        
        system.debug(recipientTrainer);
    }
    
    public void saveOfferChanges() {
        List<Offer__C> updatedOffers = new List<Offer__c>();
        for (Offer__c o : offers) {
            if (o.Accepted__c == 'Pending') {
                o.Accepted__c = 'Declined';
            }
            updatedOffers.add(o);
        }
        update updatedOffers;
    }
}