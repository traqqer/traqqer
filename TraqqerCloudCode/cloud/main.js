// Use Parse.Cloud.define to define as many cloud functions as you want.
// For example:
Parse.Cloud.define("hello", function(request, response) {
  response.success("Hello world!");
});


// Summarize entries by stat
Parse.Cloud.define("summarizeStats", function(request, response) {
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
      response.success(summariesByStat);
    },
    error: function() {
      response.error("Stat Summary Failed");
    }
  });
});