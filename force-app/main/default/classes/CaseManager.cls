@RestResource (urlMapping='/Cases/*')
global with sharing class CaseManager 
{
    @HttpGet
    global static Case getCaseById() 
    {
        RestRequest request = RestContext.request;
        String caseId = request.requestURI.substring(
            request.requestURI.lastIndexOf('/') + 1
            );
        Case result = 
        [
            SELECT 
                CaseNumber, 
                Subject,
                Status,
                Origin,
                Priority
            FROM Case
            WHERE Id = :caseId
        ];

        return result;
    }

    @HttpPost
    global static Id createCase(
        String subject, 
        String status,
        String origin, 
        String priority
        )
    {
        Case thisCase = new Case(
            Subject = subject,
            Status = status,
            Origin = origin,
            Priority = priority
        );

        insert thisCase;
        return thisCase.Id;
    }
   
    @HttpDelete
    global static void deleteCase()
    {
        RestRequest request = RestContext.request;
        String caseId = request.requestURI.substring( 
            request.requestURI.lastIndexOf('/') + 1)
        ;
        Case thisCase = 
        [
            SELECT Id
            FROM Case
            WHERE Id = :caseId
        ];
        delete thisCase;
    }

    @HttpPut
    global static Id upsertCase(
        String subject, 
        String status,
        String origin, 
        String priority, 
        String id
        )
    {
        Case thisCase = new Case
        (
            Id = id,
            Subject = subject,
            Status = status,
            Origin = origin,
            Priority = priority
        );
        upsert thisCase;
        return thisCase.Id;
    }

    @HttpPatch 
    global static Id updateCaseFields()
    {
        RestRequest request = RestContext.request;
        String caseId = request.requestURI.substring(
            request.requestURI.lastIndexOf('/') + 1
        );

        Case thisCase = 
        [
            SELECT Id
            FROM Case 
            WHERE Id = : caseId
        ];
        
        Map<String, Object> params = (Map<String, Object>)JSON.deserializeUntyped( 
            request.requestbody.toString() 
        );
        
        for( String fieldName : params.keySet() )
        {
            thisCase.put( fieldName, params.get( fieldName ) );
        }

        update thisCase;
        return thisCase.Id;
    }
}
