public class AccountTriggerHandler {
	public static void CreateAccounts(List<Account> accs) 
    {
        for(Account a : accs)
        {
            a.ShippingState = a.BillingState;
        }
    }
}