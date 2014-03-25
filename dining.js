var express = require('express');
var rem = require('rem');
var skim = require('skim');

var daynames = ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'];

function getMenuStream (next) {
  console.log('getMenuStream');
  var dif, d = new Date(); // Today's date 
  dif = (d.getDay() + 6) % 7; // Number of days to subtract 
  d = new Date(d - dif * 24*60*60*1000); // Do the subtraction 
  var dstr = (d.getMonth() + 1) + '/' + ('00' + d.getDate()).substr(-2);
  console.log('dstr: ' + dstr);

  process.env['NODE_TLS_REJECT_UNAUTHORIZED'] = '0';

  rem.stream("http://news.ycombinator.com/").get().pipe(skim({
    "$query": "td.title ~ td ~ td.title > a",
    "$each": {
      "title": "(text)",
      "link": "(attr href)"
    }
  }, function (err, json) {
    console.log(json);
  }));

  // rem.stream('http://olindining.sodexomyway.com/dining-choices/index.html/').get().pipe(skim({
  //   'links': {
  //     $query: '#hideinse',
  //     $value: '(html)'
  //   }
  // }, function (a) {
  //   console.log('skim callback');
  //   console.log("regex matcher: " + new RegExp('href=\"(.*?)\">.*?' + dstr));
  //   console.log(a);
  //   // next(a.links.match(new RegExp('href=\"(.*?)\">.*?' + dstr))[1]);
  //   // var L = null;
  //   // console.log(a.links);
  //   // a.links.forEach(function (l) {
  //   //   // console.log(l.str, dstr)
  //   //   if (l.str.indexOf(dstr) > -1 && l.str.indexOf('Week of') > -1) {
  //   //     L = l;
  //   //   }
  //   // });
  //   // next(L.href);
  // }));
  console.log('end of get menu stream');
}

console.log('hi, lets start here');
var meals = [];
var nutrition = {};

getMenuStream(function (href) {
  console.log('callback of getMenuStream');
  if (!href) {
    console.error('BAD NEWS', href);
    return;
  }

  rem.stream('http://olindining.com/' + href).get().pipe(skim({
    'breakfast': {
      $query: '.brk',
      $each: '(text)'
    },
    'lunch': {
      $query: '.lun',
      $each: '(text)'
    },
    'dinner': {
      $query: '.din',
      $each: '(text)'
    },
    'scripts': {
      $query: 'script',
      $each: '(text)'
    }
  }, function (res) {
    if (!res.scripts[1]) {
      console.error('No data :(');
      return;
    }

    var nut_keys = ['serv_size',
    'calories', 'fat_calories',
    'fat', 'percent_fat_dv',
    'satfat', 'percent_satfat',
    'trans_fat',
    'cholesterol', 'percent_cholesterol',
    'sodium', 'percent_sodium',
    'carbo', 'percent_carbo',
    'dfib', 'percent_dfib',
    'sugars', 'protein',
    'a', 'cp', 'up', 'ip',
    'name', 'description', 'allergen',
    'percent_vit_a_dv',
    'percent_vit_c_dv',
    'percent_calcium_dv',
    'percent_iron_dv',
    '_'];

    var nutrition_bad = eval(res.scripts[3].replace('<!--', '//') + '; aData');
    nutrition = {};
    Object.keys(nutrition_bad).forEach(function (key) {
      var a = nutrition[nutrition_bad[key][22]] = {};
      nutrition_bad[key].forEach(function (val, i) {
        a[nut_keys[i]] = val;
      })
    })

    try {
      function parse (datums) {
        var brk = [];
        var day = {};
        var cur = [];
        datums.forEach(function (b) {
          b = b.substr(1);
          if (b == 'REAKFAST' || b == 'UNCH' || b == 'INNER') {
            day = {};
            brk.push(day);
          } else {
            if (!b.match(/^[\r\n]/)) {
              cur = [];
              day[String(b.match(/^[^\r]+/)[0])] = cur;
              b = b.replace(/^[^\r]+/, '');
            }

            var name = String(b.replace(/^\s+|\s+$/g, ''));
            cur.push({
              name: name,
              nutrition: nutrition[name]
            });
          }
        });
        return brk;
      }

      // console.log(meals);

      var breakfast = parse(res.breakfast);
      var lunch = parse(res.lunch);
      var dinner = parse(res.dinner);

      for (var i = 0; i < breakfast.length; i++) {
        meals.push({
          dayname: daynames[i],
          breakfast: breakfast[i],
          lunch: lunch[i],
          dinner: dinner[i]
        });
      }
    } catch (e) {
      console.log('ERROR:', e);
    }

    console.log('SUCCESSFUL PARSING');
    nutrition = JSON.parse(JSON.stringify(meals));
    meals.forEach(function (day) {
      Object.keys(day).forEach(function (ok) {
        if (typeof day[ok] == 'object') {
          Object.keys(day[ok]).forEach(function (section) {
            day[ok][section].forEach(function (meal) {
              delete meal.nutrition;
            })
          })
        }
      })
    })
  }))
});


var app = express();

app.get('/', function (req, res) {
  res.redirect('/api');
})

app.get('/api', function (req, res) {
  res.json(meals);
})

app.get('/api/nutrition', function (req, res) {
  res.json(nutrition);
})
console.log('starting listening');
app.listen(process.env.PORT || 3000);