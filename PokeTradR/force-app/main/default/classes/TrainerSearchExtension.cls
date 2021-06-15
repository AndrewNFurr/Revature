public with sharing class TrainerSearchExtension{
    
    public String userInput {get;set;}
    public list<Complaint__c> searchComplaints {get; set;}
    public String errorMessage {get; set;}
    public String trainerName {get; set;}
    public boolean isSearched {get; set;}
    public list<Complaint__c> allTrainerComplaints = [SELECT Trainer_Being_Reported__c FROM Complaint__c];
    
   	public TrainerSearchExtension(ApexPages.StandardController sc){
       sc.getRecord();
   }
    
    public void returnMatchingComplaints(){
        try{
            isSearched = false;
            List<Complaint__c> complaintquery = new List<Complaint__c>();
            for(Complaint__c tc : allTrainerComplaints){
            if(this.userInput != '' || this.userInput != ' '){
                if(this.userInput == tc.Trainer_Being_Reported__c){
                   trainerName = String.escapeSingleQuotes(this.userInput);
                    isSearched = true;
                    complaintquery = Database.query('SELECT Trainer_Being_Reported__c, Trainer_Reported__c, Status__c, Reason__c, Issue__c FROM Complaint__c WHERE Trainer_Being_Reported__c =\''+
                                               this.trainerName+'\'');
            }
                    }
            }
                if(isSearched == true){
            		this.searchComplaints = complaintquery;
            	}
        }
        catch(exception e){
            this.errorMessage = 'Please enter a trainer\'s name in the search box.';
            this.searchComplaints = new list<Complaint__c>();
            
            }
        }
    }