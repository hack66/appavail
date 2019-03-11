var gplay = require('google-play-scraper');

var args = process.argv.slice(2);

gplay.search({
        term: args[1],
        country: args[2],
	lang: args[3] || 'en',
      }).then(console.log, console.log);
