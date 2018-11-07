@IsTest
public class AddPrimaryContactTest {
	
    @TestSetup
    public static void setupData() {
       List<Account> accs = new List<Account>();
        for (Integer i = 0; i < 100; i++) {
            Account acc = new Account();
            if(i < 50) {
                acc.Name = 'Test' + i;
                acc.BillingState = 'CA';
            }
            else if(i >= 50) {
				acc.Name = 'Test' + i;
				acc.BillingState = 'NY';
            }
            accs.add(acc);
        }
        System.debug('accs');
        System.debug(accs);
        insert accs;
    }
    
    @IsTest
    public static void testAddPrimaryContact() {
        Contact con = new Contact(
        	LastName = 'Test'
        );
        String state = 'CA';
        AddPrimaryContact updateAccs = new AddPrimaryContact(con, state);
        Test.startTest();
        System.enqueueJob(updateAccs);
        Test.stopTest();
    }
}