var tabCtrl = {
  init: function () {
    var self = this;
    self.triggerClick();
  },
  triggerClick: function () {
    var i = 0, j = 0, m = 0, n = 0;
    var li_arr_1 = $('#tab1').find('li'),
        li_arr_2 = $('#tab2').find('li'),
        li_arr_3 = $('#tab3').find('li'),
        li_arr_4 = $('#tab4').find('li');
    li_arr_1.on('click', function () {
      var index = $(this).attr('index');
      i = Number(index);
    });
    setInterval(function () {
      li_arr_1.eq(i).trigger('click');
      if(i + 1 == li_arr_1.length){
        i = 0
      }else{
        i++
      }
    },5000);
    li_arr_2.on('click', function () {
      var index = $(this).attr('index');
      j = Number(index);
    });
    setInterval(function () {
      li_arr_2.eq(j).trigger('click');
      if(j + 1 == li_arr_2.length){
        j = 0
      }else{
        j++
      }
    },5000);
    li_arr_3.on('click', function () {
      var index = $(this).attr('index');
      m = Number(index);
    });
    setInterval(function () {
      li_arr_3.eq(m).trigger('click');
      if(m + 1 == li_arr_3.length){
        m = 0
      }else{
        m++
      }
    },5000);
    li_arr_4.on('click', function () {
      var index = $(this).attr('index');
      n = Number(index);
    });
    setInterval(function () {
      li_arr_4.eq(n).trigger('click');
      if(n + 1 == li_arr_4.length){
        n = 0
      }else{
        n++
      }
    },5000);
  }
};
tabCtrl.init();