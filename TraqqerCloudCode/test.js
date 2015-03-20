Parse.initialize("fkila2DSXO9hpNsz5E5VcOenyU9kMEVDhOVewGfW", "K1RGnh6EzGrTVnzUWScNPP8GZksOSYwARiZct6tQ");

var query = new Parse.Query("Entry");
var summariesByStat = {}
query.find({
  success: function(results) {
    for (var i = 0; i < results.length; ++i) {
    	var statRef = results[i].get("statRef").id
    	var duration = results[i].get("duration")
    	if (!(statRef in summariesByStat)) {
    		summariesByStat[statRef] = {
    			"count": 0,
    			"totalDuration": 0.0
    		}
    	} else {
    		var statDict = summariesByStat[statRef]
    		statDict["count"] += 1
    		statDict["totalDuration"] += duration
    	}
    }
    console.log(summariesByStat);
  },
  error: function() {
  }
});