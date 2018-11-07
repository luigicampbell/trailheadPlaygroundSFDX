public class AnimalLocator 
{
    public static String getAnimalNameById(Integer id) 
    {
        Http http = new Http();
        HttpRequest req = new HttpRequest();
        
        req.setEndpoint('https://th-apex-http-callout.herokuapp.com/animals/' + id);
        req.setMethod('GET');

        HttpResponse res = http.send(req);
        String animal = '';

        if( res.getStatusCode() == 200 )
        {
            Map<String,Object> results = ( Map<String,Object> ) JSON.deserializeUntyped( res.getBody() );
            Map<String,Object> animals = ( Map<String,Object> ) results.get('animal');
            animal = String.valueOf( animals.get('name') );
        }

        return animal;
    }
}