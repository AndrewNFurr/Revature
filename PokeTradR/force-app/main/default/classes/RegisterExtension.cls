public class RegisterExtension {
    private Trainer__c mytrainer;
	public RegisterExtension(ApexPages.StandardController sc){
        this.mytrainer = (Trainer__c)sc.getRecord();
	}
    //fill in extra info the the record and insert it to the database
    public Pagereference fillInAdditionalInfo(){
        //fill in and insert
        mytrainer.Age__c = (System.Today().Year() - mytrainer.Birthday__c.Year());
        mytrainer.Dated_Joined__c = System.Today();
        mytrainer.Status__c = 'Active';
        insert mytrainer;
        return Page.RegisterConfirmation;
    }
}