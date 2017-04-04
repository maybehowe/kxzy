// JavaScript Document
function ShowMenu(obj,d){
        var dt = obj.parentNode;
        var dd = dt.getElementsByTagName("dd")[0];
        clearInterval(dd.timer);
        if(d == 1){
                clearTimeout(dt.timer);
                if(dd.maxh && dd.maxh == dd.offsetHeight){
                        return;
                }else if(!dd.maxh){
                        dd.style.bottom = '-' + dd.offsetHeight + 'px';
                        dd.style.display = "block";
                        dd.maxh = dd.offsetHeight;
                        dd.style.height = '0px';
                }
                dd.timer = setInterval(function(){ddSlide(dd,1)},15);
        }else{
                dt.timer = setTimeout(function(){ddCollapse(dd)},50);
        }        
}
function ddCollapse(c){c.timer = setInterval(function(){ddSlide(c,-1)},15);}
function cancelHide(obj){
        var dt = obj.parentNode;
        var dd = dt.getElementsByTagName("dd")[0];
        clearTimeout(dt.timer);
        clearInterval(dd.timer);
        if(dd.offsetHeight != dd.maxh){dd.timer = setInterval(function(){ddSlide(dd,1)},15);}
}
function ddSlide(c,d){
        var currh = c.offsetHeight;
        var h = (d!=1?(Math.ceil(currh/10)):(Math.ceil((c.maxh - currh)/10)));
        var t = parseInt(c.style.bottom);
        if(h < 0 && d == 1){h = 1;}
        c.style.bottom = t - parseInt(h * d) + 'px';
        c.style.height = currh + (h * d) + 'px';
        if((currh == 0 && d == -1) || (currh == c.maxh && d == 1))clearInterval(c.timer);
}
for(var _dl = document.getElementById("menu").getElementsByTagName("dl"),i=-1,dl;dl=_dl[++i];){
        var dt = dl.getElementsByTagName("dt")[0];
        var dd = dl.getElementsByTagName("dd")[0];
        dt.onmouseover= function(){return ShowMenu(this,1);}
        dt.onmouseout = dd.onmouseout = function(){return ShowMenu(this,-1);}
        dd.onmouseover= function(){return cancelHide(this);}
}
