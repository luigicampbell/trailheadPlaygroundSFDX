public class AccountProcessor {
    @future
    public static void countContacts(List<Id> ids) {
        System.debug(ids);
        List<Account> results = Database.query('SELECT Id FROM Account WHERE Id IN :ids');
        Set<Id> parents = ( new Map<Id, Account>(results) ).keyset();
        System.debug('parents' + parents);
        
        Map<Id, Account> toUpdate = new Map<Id, Account>();
        for(Id i : parents) {
            System.debug(i);
            toUpdate.put(i, new Account( Number_of_Contacts__c = 0) );
        }
        System.debug('toupdate:');
        System.debug(toUpdate);
        if(toUpdate.size() > 0) {   
            for(AggregateResult ar : [
                SELECT COUNT(Id) cons, AccountId parent
                FROM Contact
                WHERE AccountId IN :parents
                GROUP BY AccountId
            ]) {
                Decimal d = (Decimal)ar.get('cons'); 
                String parentId = String.valueOf( ar.get('parent') );
                System.debug('parentId: ' + parentId);
                Account a = toUpdate.get(parentId);
                System.debug('account a: ' + a);
                a.Id = (Id)parentId;
                System.debug('account as Id: ' + a.Id );
                a.Number_of_Contacts__c = d;
                toUpdate.put(a.Id, a);
            }
        }
        System.debug('toUpdate after loop: ');
        System.debug(toUpdate);
        update toUpdate.values();
    }
}