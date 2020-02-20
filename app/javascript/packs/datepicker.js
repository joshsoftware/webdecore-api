document.addEventListener('turbolinks:load', () => {

  var startDate = $("#startDate").datepicker({format: 'yyyy-mm-dd'})
                                 .datepicker('setStartDate', 'new Date()');
  var endDate = $("#endDate").datepicker({format: 'yyyy-mm-dd'});
            
  startDate.on('show', function (e) {
    if ($("#endDate").datepicker("getDate") != null) {
        $("#startDate").data('datepicker').setEndDate($("#endDate").datepicker("getDate"));
    }
  });

  endDate.on('show', function (e) {
    if ($("#startDate").datepicker("getDate") != null) {
        $("#endDate").data('datepicker').setStartDate($("#startDate").datepicker("getDate"));
    }
  });

  calcAmount = function()
  {
    price =  document.getElementById('user_animation_price').value
    start_date = document.getElementById('startDate').value
    end_date = document.getElementById('endDate').value
    days = (Math.round((Date.parse(end_date) - Date.parse(start_date))/(1000*60*60*24)))+1
    amount = (parseInt(price)) * days
    if(isNaN(amount))
      amount = 0
    document.getElementById('user_animation_amount').value = amount
  }
})