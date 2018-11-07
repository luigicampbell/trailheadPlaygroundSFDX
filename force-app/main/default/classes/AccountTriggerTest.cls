@IsTest
private class AccountTriggerTest 
{
	static testmethod void testHandler()
    {
        List<Account> accs = new List<Account>();
        for(Integer i = 0; i < 200; i++)
        {
            Account acc = new Account(name = 'test' + i);
            accs.add(acc);
        }
        insert accs;
    }
}