@isTest
private class DailyLeadProcessorTest {
	public static String CRON_EXP = '0 0 0 * * ?';
    static testmethod void testDailyLeadProcessor() {
        List<Lead> leads = new List<Lead>();
        for(Integer i = 0; i < 200; i++) {
            Lead lead = new Lead(
            	LastName = 'Test' + i,
                Company = 'Test' + i
            );
            leads.add(lead);
        }
        System.debug(leads);
        insert leads;
        
        Map<Id, Lead> leadMap = new Map<Id, Lead>(leads);
        List<Id> leadIds = new List<Id>(leadMap.keySet());
        
        Test.startTest();
       	String jobId = System.schedule('ScheduledApexTest', CRON_EXP, new DailyLeadProcessor());
        List<Lead> ld = [SELECT Id FROM Lead WHERE Id IN :leadIds];
        Test.stopTest();
    }
}