var tabCtrl = {
  init: function () {
    var self = this;
    self.triggerClick();
  },
  triggerClick: function () {
    // var tabs = ['#tab1','#tab2', '#tab3', '#tab4'];
    // for(var i = 0; i < tabs.length; i++){
    //   var li_arr = $(tabs[i]).find('li');
    //   var j = 0;
    //   setInterval(function () {
    //     if(j + 1 == li_arr.length){
    //       j = 0
    //     }else{
    //       j++
    //     }
    //     $(tabs[i]).find('li').eq(j).trigger('click');
    //   }, 5000)
    // }
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