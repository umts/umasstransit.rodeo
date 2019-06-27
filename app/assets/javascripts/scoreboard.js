$(document).ready(function(){
  $('.scoreboard').on('click', 'button.fullscreen', function(){
    var scoreboard = $('.scoreboard-content').get(0);
    if (scoreboard.requestFullscreen) {
      scoreboard.requestFullscreen();
    }
  });

  $('table.scoreboard').tablesorter({
    'headerTemplate': '<div class="header-label align-middle">{content}</div>{icon}',
    'cssAsc': 'bg-info',
    'cssDesc': 'bg-info',
    'cssIcon': 'fas header-icon align-middle',
    'cssIconAsc': 'fa-sort-up',
    'cssIconDesc': 'fa-sort-down',
    'cssIconNone': 'fa-sort',
    'sortInitialOrder': 'desc',
    'widgets': ['math'],
    'widgetOptions': {
      'math_textAttr': 'data-score',
      'math_ignore': [0],
      'math_mask': '#0.0'
    }
  });
});

//Sum of all but the last three elements in an array
$.tablesorter.equations['maneuversum'] = function(arry, config) {
  const maneuver_count = arry.length - 3; //cc, quiz, grand-total
  const maneuvers = arry.slice(0, maneuver_count);
  const sum = (accumulator, currentValue) => accumulator + currentValue;

  return maneuvers.reduce(sum);
};

//Sum of the last three elements in an array
$.tablesorter.equations['subtotalsum'] = function(arry, config) {
  const maneuver_count = arry.length - 3; //cc, quiz, grand-total
  const non_maneuvers = arry.slice(maneuver_count);
  const sum = (accumulator, currentValue) => accumulator + currentValue;

  return non_maneuvers.reduce(sum);
};
