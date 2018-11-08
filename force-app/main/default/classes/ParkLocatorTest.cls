@isTest
private class ParkLocatorTest {
    static testMethod void testCallout() 
    {
        Test.setMock( WebServiceMock.class, new ParkServiceMock() );
        String countryName = 'Germany';
        List<String> result = ParkLocator.country(countryName);
        List<String> expected = new List<String>();
        for(Integer i = 1; i < 5; i++)
        {
            expected.add('Park' + i);
        }
        System.assert(expected, result);
    }
}
