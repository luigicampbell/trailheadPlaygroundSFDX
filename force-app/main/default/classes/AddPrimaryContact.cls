public class AddPrimaryContact implements Queueable {
    private Contact record;
    private String state;
    
    public AddPrimaryContact(Contact record, String state) {
        this.record = record;
        this.state = state;
    }
    
    public void execute(QueueableContext context) {
		List<Account> accs = [
            SELECT Id
            FROM Account
            WHERE BillingState = :state
            LIMIT 200
        ];
        List<Contact> cons = new List<Contact>();
        for(Account acc : accs) {
            Contact con = record.clone(false, false, false, false);
            con.AccountId = acc.Id;
            cons.add(con);
        }
        
        if(cons.size() > 0) {
            insert cons;
        }
    }
}