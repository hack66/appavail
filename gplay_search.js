var gplay = require('google-play-scraper');

var args = process.argv;

gplay.search({
  term: args[2],
  country: args[3],
  lang: args[4] || 'en'
})
.then(console.log)
.catch(function(err){
  console.log(err.response.statusCode);
});
