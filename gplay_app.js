var gplay = require('google-play-scraper');

var args = process.argv;

gplay.app({
  appId: args[2],
  country: args[3],
  lang: args[4] || 'en'
})
.then(console.log)
.catch(function(err){
  console.log(err.response.statusCode);
});
