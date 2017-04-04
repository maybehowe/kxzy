// 百度地图API功能
// ak PEmsTFv4c7PPlIcMPDcfcc91
var map = new BMap.Map("mapContainer");
map.setMapStyle({
	styleJson : [ {
		"featureType" : "poi",
		"elementType" : "all",
		"stylers" : {
			"color" : "#ffffff",
			"visibility" : "off"
		}
	}, {
		"featureType" : "road",
		"elementType" : "all",
		"stylers" : {
			"color" : "#ffffff",
			"visibility" : "off"
		}
	}, {
		"featureType" : "background",
		"elementType" : "all",
		"stylers" : {
			"color" : "#ffffff"
		}
	}, {
		"featureType" : "administrative",
		"elementType" : "all",
		"stylers" : {
			"color" : "#ffffff",
			"visibility" : "off"
		}
	} ]
});

map.disableScrollWheelZoom();
map.disableDragging();
function getBoundary() {
	var cities = [ {
		"name" : "湖州市",
		"color" : "rgb(128,224,238)",
	}, {
		"name" : "嘉兴市",
		"color" : "rgb(93, 208, 227)"
	}, {
		"name" : "杭州市",
		"color" : "rgb(15, 164, 206)"
	}, {
		"name" : "绍兴市",
		"color" : "rgb(61, 189, 214)"
	}, {
		"name" : "宁波市",
		"color" : "rgb(93, 208, 227)"
	}, {
		"name" : "舟山市",
		"color" : "rgb(205,245,253)"
	}, {
		"name" : "衢州市",
		"color" : "rgb(164, 234, 244)"
	}, {
		"name" : "金华市",
		"color" : "rgb(128,224,238)"
	}, {
		"name" : "台州市",
		"color" : "rgb(164, 234, 244)"
	}, {
		"name" : "丽水市",
		"color" : "rgb(205,245,253)"
	}, {
		"name" : "温州市",
		"color" : "rgb(93, 208, 227)"
	} ];

	var bdary = new BMap.Boundary();
	for (var i = 0; i < cities.length; i++) {
		(function (city) {
			bdary.get(city.name, function(rs) { // 获取行政区域
				// map.clearOverlays(); //清除地图覆盖物
				var count = rs.boundaries.length; // 行政区域的点有多少个
				for (var i = 0; i < count; i++) {
					var ply = new BMap.Polygon(rs.boundaries[i], {
						strokeWeight : 2,
						strokeColor : "rgb(157,187,185)",
						fillColor : city.color
					}); // 建立多边形覆盖物
					map.addOverlay(ply); // 添加覆盖物
					ply.addEventListener("click", function() {
						goList(city.name)
					});
					//map.setViewport(ply.getPath()); // 调整视野
				}
			});
			
			var myGeo = new BMap.Geocoder();
			// 将地址解析结果显示在地图上,并调整地图视野
			myGeo.getPoint(city.name, function(point){
				if (point) {
					//map.centerAndZoom(point, 16);
					map.addOverlay(new BMap.Label(city.name, {
						position:point
					}));
				}else{
					alert("您选择地址没有解析到结果!");
				}
			}, "北京市");
			
		})(cities[i]);
		
	}
}

function goList(city) {
	location.href="./list.rt?museum.cityName="+encodeURIComponent(city)
}

setTimeout(function() {
	getBoundary();
	map.centerAndZoom("金华市东阳市",8);
}, 0);
