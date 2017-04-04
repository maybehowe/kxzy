// JavaScript Document
function selectAll(o){
	if(o.checked){
		$("input[type='checkbox']").attr("checked",true);
	}else{
		$("input[type='checkbox']").attr("checked",false);
	}
}