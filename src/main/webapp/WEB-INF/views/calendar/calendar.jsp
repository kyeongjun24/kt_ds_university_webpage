<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="utf-8"%>
<!DOCTYPE html>
<html lang='en'>
  <head>
    <meta charset='utf-8' />
<link href='${pageContext.request.contextPath}/resources/calendar/lib/main.css' rel='stylesheet' />
<script src='${pageContext.request.contextPath}/resources/calendar/lib/main.js'></script>
<script type='text/javascript'>

document.addEventListener('DOMContentLoaded', function() {
  var calendarEl = document.getElementById('calendar');

  var calendar = new FullCalendar.Calendar(calendarEl, {
    googleCalendarApiKey: 'AIzaSyCmsKb4xe8UjKWcIiPxgqZNAsiV3WrG1Cs',
    eventSources: [
    {
          googleCalendarId: '6ufvlqavfr32l5feq63mncgea4@group.calendar.google.com',
          className: 'kt ds university',
          color: '#be5683', //rgb,#ffffff 등의 형식으로 할 수 있어요.
          //textColor: 'black' 
        },
      {
          googleCalendarId: 'dltjdgus012@gmail.com',
          className: '이성현',
            color: '#204051',
            //textColor: 'black' 
        },
      {
          googleCalendarId: 'ko.south_korea#holiday@group.v.calendar.google.com',
          className: '대한민국의 휴일',
            color: '#3b6978',
            //textColor: 'black' 
        }
    ]
  });
  calendar.render();
});
</script>
<style>
#calendar{
   width:60%;
   margin:20px auto;
}
</style>
  </head>
  <body>
    <div id='calendar'></div>
  </body>
</html>