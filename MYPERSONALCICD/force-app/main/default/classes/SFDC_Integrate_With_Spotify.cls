public class SFDC_Integrate_With_Spotify {
    
    // The @InvocableMethod annotation is correct.
    // The label and description are useful for Flow and Process Builder.
    @InvocableMethod(label='Get Spotify Track Info' description='Searches for a Spotify track and returns the JSON response.')
    public static List<String> spotifyMethod(List<String> trackNames) {
        
        // This list will store the JSON response for each track search.
        List<String> spotifyResponses = new List<String>();
        
        // A check for null or empty input is a good practice.
        if (trackNames == null || trackNames.isEmpty()) {
            spotifyResponses.add('Error: Input list cannot be empty or null.');
            return spotifyResponses;
        }

        // Create the instance of the HTTP class.
        Http http = new Http();
        
        // Loop through each track name provided in the input list.
        for (String trackName : trackNames) {
            
            // Create a new instance of HttpRequest for each callout.
            HttpRequest request = new HttpRequest();
            
            // Populate the attributes of the Request.
            request.setMethod('GET');
            
            // Use EncodingUtil to properly format the track name for the URL.
            String encodedName = EncodingUtil.urlEncode(trackName, 'UTF-8');
            
            // Set the endpoint using the named credential 'Spotify' and the encoded track name.
            request.setEndpoint('callout:Spotify/v1/search?q=' + encodedName + '&type=track&limit=1');
            
            try {
                // Send the request and get the response.
                HttpResponse response = http.send(request);
                
                // Check if the response was successful (status code 200).
                if (response.getStatusCode() == 200) {
                    // Add the successful response body to our list.
                    spotifyResponses.add(response.getBody());
                } else {
                    // If the callout failed, add an error message with the status code.
                    spotifyResponses.add('Error: ' + response.getStatus() + ' - ' + response.getStatusCode());
                }
            } catch(Exception e) {
                // Catch any unexpected exceptions and add the error message to the list.
                System.debug('Spotify callout exception for track: ' + trackName + '. Message: ' + e.getMessage());
                spotifyResponses.add('Exception: ' + e.getMessage());
            }
        }
        
        // Return the list of responses.
        return spotifyResponses;
    }
}