$(document).ready(function(){ 

  var bloodhound_dep = new Bloodhound({
    datumTokenizer: function (d) {
      return Bloodhound.tokenizers.whitespace(d.value);
    },  
    queryTokenizer: Bloodhound.tokenizers.whitespace,
   
    remote: '/typeahead_department/%QUERY'

  });

  var bloodhound_course_id = new Bloodhound({
    datumTokenizer: function (d) {
      return Bloodhound.tokenizers.whitespace(d.value);
    },  
    queryTokenizer: Bloodhound.tokenizers.whitespace,
   
    remote: '/typeahead_course_id/%QUERY'

  });

  // initialize the bloodhound suggestion engine
  bloodhound_dep.initialize();
  bloodhound_course_id.initialize();

  // instantiate the typeahead UI

  $('#dpm_name').typeahead(null, {
    name: 'department',
    displayKey: 'department',
    source: bloodhound_dep.ttAdapter()
  });

  $('#course_name').typeahead(null, {
    name: 'course_name',
    displayKey: 'course_id',
    source: bloodhound_course_id.ttAdapter()
  });

})
