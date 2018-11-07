global class DailyLeadProcessor implements Schedulable {
    global void execute(SchedulableContext ctx) {
        List<Lead> leads = [
            SELECT Id
            FROM Lead
            WHERE LeadSource = NULL
            LIMIT 200
        ];
        System.debug(leads);
        for(Lead lead : leads) {
            lead.LeadSource = 'Dreamforce';
        }
        
        update leads;
    }
}