$(function(){

	$(".jidi_img ul li img").hover(function(){
		$(".jidi_img ul li img").removeClass("sel");
		$(this).addClass("sel");
		$(".jidi_img .img img").attr("src",$(this).attr("src"));
	})

})