// JavaScript Document
window.onload = function ()
{
	var oLi = document.getElementById("tab1").getElementsByTagName("li");
	var oUl = document.getElementById("content1").getElementsByTagName("div");
	
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
//2
	var oLi2 = document.getElementById("tab2").getElementsByTagName("li");
	var oUl2 = document.getElementById("content2").getElementsByTagName("div");
	
	for(var i = 0; i < oLi2.length; i++)
	{
		oLi2[i].index = i;
		oLi2[i].onclick = function ()
		{
			for(var n = 0; n < oLi2.length; n++) oLi2[n].className="";
			this.className = "title";
			for(var n = 0; n < oUl2.length; n++) oUl2[n].style.display = "none";
			oUl2[this.index].style.display = "block"
		}	
	}
//3
	var oLi3 = document.getElementById("tab3").getElementsByTagName("li");
	var oUl3 = document.getElementById("content3").getElementsByTagName("div");
	
	for(var i = 0; i < oLi3.length; i++)
	{
		oLi3[i].index = i;
		oLi3[i].onclick = function ()
		{
			for(var n = 0; n < oLi3.length; n++) oLi3[n].className="";
			this.className = "title";
			for(var n = 0; n < oUl3.length; n++) oUl3[n].style.display = "none";
			oUl3[this.index].style.display = "block"
		}	
	}
//4
	var oLi4 = document.getElementById("tab4").getElementsByTagName("li");
	var oUl4 = document.getElementById("content4").getElementsByTagName("div");
	
	for(var i = 0; i < oLi4.length; i++)
	{
		oLi4[i].index = i;
		oLi4[i].onclick = function ()
		{
			for(var n = 0; n < oLi4.length; n++) oLi4[n].className="";
			this.className = "title";
			for(var n = 0; n < oUl4.length; n++) oUl4[n].style.display = "none";
			oUl4[this.index].style.display = "block"
		}	
	}
//5
	var oLi5 = document.getElementById("tab5").getElementsByTagName("li");
	var oUl5 = document.getElementById("content5").getElementsByTagName("div");
	
	for(var i = 0; i < oLi5.length; i++)
	{
		oLi5[i].index = i;
		oLi5[i].onclick = function ()
		{
			for(var n = 0; n < oLi5.length; n++) oLi5[n].className="";
			this.className = "title";
			for(var n = 0; n < oUl5.length; n++) oUl5[n].style.display = "none";
			oUl5[this.index].style.display = "block"
		}	
	}
//6
	var oLi6 = document.getElementById("tab6").getElementsByTagName("li");
	var oUl6 = document.getElementById("content6").getElementsByTagName("div");
	
	for(var i = 0; i < oLi6.length; i++)
	{
		oLi6[i].index = i;
		oLi6[i].onclick = function ()
		{
			for(var n = 0; n < oLi6.length; n++) oLi6[n].className="";
			this.className = "title";
			for(var n = 0; n < oUl6.length; n++) oUl6[n].style.display = "none";
			oUl6[this.index].style.display = "block"
		}	
	}
}
