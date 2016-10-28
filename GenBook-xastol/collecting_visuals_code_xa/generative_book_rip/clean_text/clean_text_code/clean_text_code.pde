import com.temboo.core.*;
import com.temboo.Library.Twitter.Search.*;

JSONArray tweets;

void setup() {
  String aJsonFilename = "collectTemboTweets&Names2.json";
  JSONObject json = loadJSONObject(aJsonFilename);
  
  tweets = new JSONArray();
  
  if (json == null) {
    println("JSONObject could not be loaded!");
  } else {
    JSONArray statuses = json.getJSONArray("statuses");
    
    for (int i=0; i<statuses.size(); i++) {
           
        JSONObject aTweet = statuses.getJSONObject(i);
        String aText = aTweet.getString("text");
        //Array aUser = aTweet.getArray("souce");
        //String aName = aUser.getString("name");
        String aTime = aTweet.getString("created_at");
        JSONObject aUser = aTweet.getJSONObject("user");
        String aScreenName = aUser.getString("screen_name");
        String aName = aUser.getString("name");
        
        println(i + "\t" + aText);
        
        JSONObject tweet = new JSONObject();
        
        //tweet.setInt("id",i);
        tweet.setString("text", aText);
        tweet.setString("name", aName);
        tweet.setString("screenName",aScreenName);
        tweet.setString("date", aTime);
        tweets.setJSONObject(i, tweet);
         
      }
      saveJSONArray(tweets, "clean_tweets_08.json");
    } 
  }