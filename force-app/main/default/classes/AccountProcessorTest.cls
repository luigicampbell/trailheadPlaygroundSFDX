@IsTest
public class AccountProcessorTest {

    @TestSetup
    public static void setupData(){
    	List<Contact> cons = new List<Contact>();
        Account acc = new Account(
			Name = 'TestAcc'
        );
        
        insert acc;
        
        for(Integer i = 0; i < 200; i++){
          cons.add( new Contact( LastName = 'TestCon' + i, AccountId = acc.Id ) );  
        }
        
        insert cons;
    }
    @IsTest
    private static void testAccounts(){
        Test.startTest();
        	Account accnt = [SELECT Id FROM Account][0];
        	List<Contact> cons = [SELECT AccountId FROM Contact];
        	System.debug(accnt);
        	System.debug('con lookup to accnt: ' + cons);
        	List<Id> ids = new List<Id>();
        	ids.add(accnt.Id);
	        System.debug('ids: ' + ids);
			AccountProcessor.countContacts(ids);
        Test.stopTest();
    }
}