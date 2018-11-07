@isTest
public class LeadProcessorTest {
	@testSetup
    static void setup() {
        List<Lead> leads = new List<Lead>();
        for(Integer i = 1; i < 201; i++) {
            leads.add(
            	new Lead(
            		lastName = 'test' + i,
                    Company = 'test' +i
            	)
            );
        }
        insert leads;
    }
    
    static testmethod void test() {
        Test.startTest();
        LeadProcessor lp = new LeadProcessor();
       	Id batchId = Database.executeBatch(lp);
        Test.stopTest();
    }
}