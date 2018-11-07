@isTest

private class AnimalLocatorTest 
{
    static TestMethod void AnimalLocatorTest() 
    {
        Test.setMock( HttpCalloutMock.class, new AnimalLocatorMock() );
        String actual = AnimalLocator.getAnimalNameById(1);
        String expected = 'aminal';
        System.assertEquals(actual, expected);
    }
}