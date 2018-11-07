global class LeadProcessor implements Database.Batchable<sObject> {
    global Integer recordsProcessed = 0;
    global Database.QueryLocator start(Database.BatchableContext bc) {
        return Database.getQueryLocator(
        	'SELECT Id, LeadSource FROM Lead'
		);
    }
    
    global void execute(Database.BatchableContext bc, List<Lead> scope) {
        List<Lead> leads = new List<Lead>();
        for (Lead lead : scope) {
            lead.LeadSource = 'Dreamforce';
            leads.add(lead);
            recordsProcessed = recordsProcessed + 1;
        }
    }
    
    global void finish(Database.BatchableContext bc) {
        System.debug(recordsProcessed + 'records processed...');
        AsyncApexJob job = [
            SELECT Id, 
            	Status, 
            	NumberOfErrors, 
            	JobItemsProcessed,
            	TotalJobItems
            FROM AsyncApexJob
            WHERE Id = :bc.getJobId()
        ];
    }
	
}