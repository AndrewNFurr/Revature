trigger TrainerTrigger on Trainer__c (before insert, before update, before delete, after insert, after update, after delete, after undelete) {
    
    if(Trigger.isBefore){
        if(Trigger.isInsert){
            
        }else if(Trigger.isUpdate){
            TrainerTradeUpdate.addOneTrade(Trigger.new,Trigger.old);
            TrainerOfferUpdate.addOneOffer(Trigger.new,Trigger.old);
            TrainerRankUpdate.checkRank(Trigger.new);
            
        }else if(Trigger.isDelete){
            for(Trainer__c t: Trigger.old){
              if(t.Current_Trades__c != 0 || t.Current_Offers__c != 0){
                  t.addError('Trainer needs to have no Active Trades or Offers to delete.');
              }
          }
        }else{
            //continue
        }       
        
    }
    
    if(Trigger.isAfter){
        if(Trigger.isInsert){
            
        
        }else if(Trigger.isUpdate){
           
        }else{}
    }

}