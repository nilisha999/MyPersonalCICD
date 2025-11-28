public class Pipedream_Integrate_with_SFDC {
    public static List<String> spotifyMethod(List<String> pipeNames) {
        
        // This list will store the JSON response for each track search.
        List<String> pipedreamResponses = new List<String>();
        
        // A check for null or empty input is a good practice.
        if (pipeNames == null || pipeNames.isEmpty()) {
            pipedreamResponses.add('Error: Input list cannot be empty or null.');
            return pipedreamResponses;
        }
        
        // Create the instance of the HTTP class.
        Http http = new Http();
        
        // Loop through each track name provided in the input list.
        for (String trackName : pipeNames) {
            
            // Create a new instance of HttpRequest for each callout.
            HttpRequest request = new HttpRequest();
            
            // Populate the attributes of the Request.
            request.setMethod('GET');
            
            // Use EncodingUtil to properly format the track name for the URL.
            String encodedName = EncodingUtil.urlEncode(trackName, 'UTF-8');
            
            // Set the endpoint using the named credential 'Spotify' and the encoded track name.
            request.setEndpoint('https://api.pipedream.com/v1/connect/'+pipeNames+'/accounts ');
            
            try {
                // Send the request and get the response.
                HttpResponse response = http.send(request);
                
                // Check if the response was successful (status code 200).
                if (response.getStatusCode() == 200) {
                    // Add the successful response body to our list.
                    pipedreamResponses.add(response.getBody());
                } else {
                    // If the callout failed, add an error message with the status code.
                    pipedreamResponses.add('Error: ' + response.getStatus() + ' - ' + response.getStatusCode());
                }
            } catch(Exception e) {
                // Catch any unexpected exceptions and add the error message to the list.
                System.debug('pipedream callout exception: ' + trackName + '. Message: ' + e.getMessage());
                pipedreamResponses.add('Exception: ' + e.getMessage());
            }
        }
        
        // Return the list of responses.
        return pipedreamResponses;
    }
}