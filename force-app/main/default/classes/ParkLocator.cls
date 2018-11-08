public class ParkLocator {
    public static String[] country(String countryName){
        ParkService.ParksImplPort ps = new ParkService.ParksImplPort();
        String[] parkNames = ps.byCountry(countryName);

        return parkNames;
    }
}