public class TrainerTradeUpdate {
    
    //Passing two different lists of the trainer object as 2 parameters
    public static void addOneTrade(List<Trainer__c> newList, List<Trainer__c> oldList){
        //system.debug(newList);
        //system.debug(oldList);
        //Declaring an empty list called updateList
        List<Trainer__c> updateList = new List<Trainer__c>();
        //Creating a nested for loop to check both new list and old list
        for(Trainer__c tn: newList){
            for(Trainer__c to: oldList){
                //If new Current Trades s greater than old Current Trades, increment Trades Made
                if(tn.Current_Trades__c > to.Current_Trades__c){
                    tn.Trades_Made__c++;
                    updateList.add(tn);
               }
            } 
        }
                
    }

}