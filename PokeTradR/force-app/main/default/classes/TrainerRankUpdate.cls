public class TrainerRankUpdate {
    
    //Passing Trainer object as a list for the parameter
    public static void checkRank(List<Trainer__c> tList){
        
        //Empty trainer list to add to
        List<Trainer__c> updateList = new List<Trainer__c>();
        //As long as Trainer object equals the tList
        for(Trainer__c t: tList){
            //If the sum of Offers Made and Trades Made hit a certain threshold they rank up
            Double sum = t.Offers_Made__c + t.Trades_Made__c;
            if(sum < 25){
                t.Rank__c = 'Rookie';
            }
            else if(sum >= 25 && sum < 50){
                t.Rank__c = 'Intermediate';
            }
            else if(sum >= 50 && sum < 75){
                t.Rank__c = 'Expert';
            }
            else if(sum > 75){
                t.Rank__c = 'Master';
            }
                
        }
    }

}