public class LoginClass {
    public String myusername{get;set;}
    public String mypassword{get;set;}
    public Id myId{get;set;}
   
    public PageReference login(){
    	List<Trainer__c> tusername = [SELECT Id, Name, Password__c FROM Trainer__c WHERE Name=:myusername LIMIT 1];
        if(tusername == null || tusername.size() == 0){
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,'Username does not exist'));
            return null;           
        }
        else{
            if(mypassword == tusername[0].Password__c){
                myId = tusername[0].Id;
                PageReference page = Page.TrainerProfile;
                page.setRedirect(True);
                page.getParameters().put('id', myId);
                return page;
            }
            else{
                System.debug('Password not matched');
                return null;
            }           
        }       
    }
    
    public PageReference register(){     
        return Page.Register;
    }
}