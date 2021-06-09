public class RegisterExtension {
    private Trainer__c mytrainer;
	public RegisterExtension(ApexPages.StandardController sc){
        this.mytrainer = (Trainer__c)sc.getRecord();
	}
    public void fillInAdditionalInfo(){
        mytrainer.Age__c = (System.Today().Year() - mytrainer.Birthday__c.Year());
    }
}