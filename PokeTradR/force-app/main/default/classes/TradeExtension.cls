public class TradeExtension {
    
    public TradeExtension(ApexPages.StandardController sc) {
        this.currTrade = (Trade__c)sc.getRecord();
    }
	
    public TradeExtension(ApexPages.StandardSetController ssc) {
      
    }
   //Variables
    public static ID currentId {get; set;}
    public Trade__c currTrade {get; set ;}
    public Offer__c currOffer {get {
          List<Offer__c> temp = [
        	SELECT Name, Accepted__c, Pokemon__c, Money_Offered__c, Trainer_Name__c, Owner__c
            FROM Offer__c
            WHERE Accepted__c='Accepted' AND Owner__c = :currTrade.Trainer_Name__c 
    ];   
        if (temp.size()>0) {
            this.currOffer = temp[0];
        } else {
            this.currOffer = null;
        }
        return this.currOffer;
    } set;}
    
    public List<Offer__c> offers {get {
        if (this.offers == null && currTrade != null) {
            this.offers = [
                SELECT Name, Accepted__c, Pokemon__c, Money_Offered__c, Trainer_Name__c, Owner__c
                FROM Offer__c
                WHERE Trade__r.Id=:currTrade.Id
            ];
        }
        return this.offers;
    }set;} 

    public  List<Trainer__c> recipientTrainer {get {
        if (this.currTrade != null) {
            if (currOffer != null) {
                this.recipientTrainer = [
                    SELECT Name, Id, Trainer_Id__c, Bio__c, Rank__c 
                    FROM Trainer__c 
                    WHERE Id =:currOffer.Trainer_Name__c
                    LIMIT 1
                ];
            } 
        } else {
        this.recipientTrainer = [
                SELECT Name, Id, Trainer_Id__c, Bio__c, Rank__c 
                FROM Trainer__c 
                WHERE Id =:currTrade.Recipient__c
                LIMIT 1
            ];
        
        }
        return this.recipientTrainer;
    }set;}

    //Methods
    public PageReference goToTrade() {
        PageReference pr = Page.TradePage; 
        pr.setRedirect(true);
        pr.getParameters().put('id', currentId);

        return pr;
    }
    
    public Component.Apex.OutputText getRecBio(){
        if(recipientTrainer != null){
            Component.Apex.OutputText ot = new Component.Apex.OutputText();
            ot.value = recipientTrainer[0].Bio__c;
               return ot; 
        }else{
        	return null;
        }
    }
    public Component.Apex.OutputText getRecName(){
        if(recipientTrainer != null){
            Component.Apex.OutputText ot = new Component.Apex.OutputText();
            ot.value = recipientTrainer[0].Name;
               return ot; 
        }else{
        	return null;
        }
    }
    public Component.Apex.OutputText getRecRank(){
        if(recipientTrainer != null){
            Component.Apex.OutputText ot = new Component.Apex.OutputText();
            ot.value = recipientTrainer[0].Rank__c;
               return ot; 
        }else{
        	return null;
        }
    }
    
    public void showMe() {
        system.debug(currTrade);
        //system.debug(recipientTrainer);
        system.debug(currOffer);
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