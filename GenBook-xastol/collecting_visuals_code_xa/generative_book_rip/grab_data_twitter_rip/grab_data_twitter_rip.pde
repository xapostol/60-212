import com.temboo.core.*;
import com.temboo.Library.Twitter.Search.*;

// Create a session using your Temboo account application details
TembooSession session = new TembooSession("xastol", "myFirstApp", "WHATEVER YOURS IS");

void setup() {
  // Run the Tweets Choreo function
  runTweetsChoreo();
}

void runTweetsChoreo() {
  // Create the Choreo object using your Temboo session
  Tweets tweetsChoreo = new Tweets(session);

  // Set inputs
  String myQuery  = "rip";
  tweetsChoreo.setQuery(myQuery);
  tweetsChoreo.setAccessToken("YOUR STUFF");
  tweetsChoreo.setConsumerKey("THEIR STUFF");
  tweetsChoreo.setConsumerSecret("SECRET THEIR STUFF");
  tweetsChoreo.setAccessTokenSecret("SECRET YOUR STUFF");

  // Run the Choreo and store the results
  TweetsResultSet tweetsResults = tweetsChoreo.run();
  
  // Print results
  println(tweetsResults.getLimit());
  println(tweetsResults.getRemaining());
  println(tweetsResults.getReset());
  //println(tweetsResults.getResponse());

  String[] result = {tweetsResults.getResponse()};
  println(result);
  saveStrings(myQuery+".json",result);
}