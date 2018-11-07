public class AccountUtils {

    public static List<Account> accountsByState(String State)
    {
        List<Account> accs = [
            SELECT Id
            FROM Account
            WHERE BillingState = :State
        ];
        
        return accs;
    }
}