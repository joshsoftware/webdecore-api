document.addEventListener('turbolinks:load', () => {

  $('.datepicker').datepicker({
    format: 'dd/mm/yyyy',
    autoclose: true,
    clearBtn: true
  });

})