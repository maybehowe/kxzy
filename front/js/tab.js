// JavaScript Document
window.onload = function ()
{
	var oLi = document.getElementById("tab").getElementsByTagName("li");
	//var oUl = document.getElementById("content").getElementsByTagName("ul");
	var oUl = $("#content").find("#tab_register");
	
	for(var i = 0; i < oLi.length; i++)
	{
		oLi[i].index = i;
		oLi[i].onclick = function ()
		{
			for(var n = 0; n < oLi.length; n++) oLi[n].className="";
			this.className = "title";
			for(var n = 0; n < oUl.length; n++) oUl[n].style.display = "none";
			oUl[this.index].style.display = "block"
		}	
	}
}
