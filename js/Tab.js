// JavaScript Document
window.onload = function ()
{
	var oLi = document.getElementById("tab").getElementsByTagName("li");
	var oUl = document.getElementById("content").getElementsByTagName("div");
	
	for(var i = 0; i < oLi.length; i++)
	{
		oLi[i].index = i;
		var id = oLi[i].id;
		oLi[i].onclick = function ()
		{
			$("#editA").attr("href","");
			for(var n = 0; n < oLi.length; n++) oLi[n].className="";
			this.className = "current";
			for(var n = 0; n < oUl.length; n++) oUl[n].style.display = "none";
			oUl[this.index].style.display = "block"
			var viewId=$("#viewId").val();
			var leftId=$("#leftId").val();
			var path = $("#editA").attr("href");
			$("#editA").attr("href",path+"/segment/edit.rt?id="+id+"&viewId="+viewId+"&leftId="+leftId);
		}	
	}
	
}
