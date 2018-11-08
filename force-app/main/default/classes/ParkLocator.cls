public class ParkLocator 
{
    public List<String> country(String countryName)
    {
        ParkService.ParksImplPort ps = new ParkService.ParksImplPort();
        List<String> parkNames = ps.byCountry(countryName);

        return parkNames;
    }
}
