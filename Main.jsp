<%@page import="java.util.ArrayList"%>
<%@ page contentType="text/html;charset=gb2312"%>    
<%@ page import="java.sql.*"%> 
<%@ page import="sqlOperation.*"%> 
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0">

    <title>IoT based on WebGIS</title>
    <link rel="stylesheet" href="olapi/theme/default/style.css" type="text/css">
    <link rel="stylesheet" href="style.css" type="text/css">
	<script type="text/javascript" src="http://www.openlayers.cn/olapi/OpenLayers.js">	
	</script>
	
	<style type="text/css">
	td
	{
	border:1px;
    text-align:center;
    bordercolor:black;
    height:30px;
    
	}
		body, html{
			width: 100%;
			height: 100%;
			margin:0;
			font-family:"微软雅黑";
			font-size:14px;
		}
		#map {
			width:80%; 
			height:90%;
			overflow: hidden;
			float:left;
		}
		#op{
			border: 2px solid black;
			margin-left:5px;
			width:19%;
			height:90%;
			float:left;
		}
		#result{
			width:100%;
		}
	</style>
	<%
		ServerPorperties serverPorperties=new ServerPorperties();
		 String GISServerIP=serverPorperties.GetGISServerIP();
	 %>
    <script>

        // API key for http://openlayers.org. Please get your own at
        // http://bingmapsportal.com/ and use that instead.
        var apiKey = "AqTGBsziZHIJYYxgivLBf0hVdrAk9mWO5cQcb8Yux8sW5M8c8opEC2lZqKR1ZZXf";
        var map;

        function init() {
            var options = 
			{
            projection: "EPSG:900913",
            displayProjection: "EPSG:4326",
            units: 'm'
			};
		 map = new OpenLayers.Map("map",options);
           // map.addControl(new OpenLayers.Control.LayerSwitcher());
		
            var road = new OpenLayers.Layer.Bing({
                name: "Road",
                key: apiKey,
                type: "Road"
            });
			 var hybrid = new OpenLayers.Layer.Bing({
                name: "Hybrid",
                key: apiKey,
                type: "AerialWithLabels"
            });
            var aerial = new OpenLayers.Layer.Bing({
                name: "Aerial",
                key: apiKey,
                type: "Aerial"
            });

            map.addLayers([road, hybrid, aerial]);
			var wms=new OpenLayers.Layer.WMS("wms",
			"http://<%=GISServerIP%>/geoserver/cite/wms?"	
			,{layers:"cite:bou2_4l",transparent:true},
			  {
                       yx : {'EPSG:4326' : true}
                    } );
			
            map.addLayer(wms);
		

			//添加轨迹
			var vectors,lineFeature;//存放线路 
			//线路样式 
			var style_red = { 
			strokeColor: "red", 
			strokeWidth: 3, 
			strokeDashstyle: "string", 
			pointRadius: 6, 
			pointerEvents: "visiblePainted" 
			}; 
			
			//画线图层设置 
			var layer_style = OpenLayers.Util.extend({}, OpenLayers.Feature.Vector.style['default']); 
			layer_style.fillOpacity = 0.2; 
			layer_style.graphicOpacity = 1; 
			
			//画线图层 
			vectors = new OpenLayers.Layer.Vector("Track", {style: layer_style}); 
			map.addLayer(vectors); 
			
			//一下采用数组型式填充轨迹 
			var pointList = []; 
			for(var i=0;i<line.length;i++){ 
			    newPoint = new OpenLayers.Geometry.Point(line[i][0],line[i][1]).transform("EPSG:4326", "EPSG:900913"); 
			    pointList.push(newPoint); 
			} 
			lineFeature = new OpenLayers.Feature.Vector(new OpenLayers.Geometry.LineString(pointList),null,style_red); 
			vectors.addFeatures([lineFeature]); 

//添加标记点
			var markers = new OpenLayers.Layer.Markers( "Markers" );
            map.addLayer(markers);//将markers层添加到地图上
            var size = new OpenLayers.Size(25,30);
            var offset = new OpenLayers.Pixel(-(size.w/2), -size.h);
            var icon = new OpenLayers.Icon('http://d.lanrentuku.com/down/png/1205/map-marker/map-marker-marker-outside-pink.png',size,offset);
        //    markers.addMarker(new OpenLayers.Marker(new OpenLayers.LonLat(104,34),icon));
        //    markers.addMarker(new OpenLayers.Marker(new OpenLayers.LonLat(105,34),icon));
			var marker=new Array() ;
			
			for(var i=0;i<list.length;i++){
			marker[i]= new OpenLayers.Marker(new OpenLayers.LonLat(PointsData[i][0],PointsData[i][1]).transform("EPSG:4326", "EPSG:900913"),icon.clone());
            marker[i].events.register('mousedown',i, 
            function(evt) { 
			
             var popup = new OpenLayers.Popup("chicken",
                   new OpenLayers.LonLat(PointsData[this][0],PointsData[this][1]).transform("EPSG:4326", "EPSG:900913"),
                   new OpenLayers.Size(250,200),
                   '<p style="float:left;line-height:20px;">物品名称：'+PointsData[this][2]+'</p>'+'<br/>'
					+"<img style='float:right;' src="+PointsData[this][3]+" width='142' height='158' />"+'<br/>'
					+"<p style='margin:0;line-height:1.5;font-size:13px;'>物品信息："+PointsData[this][4]+"</p>",
                   true);
				
				map.addPopup(popup);
            });
            markers.addMarker(marker[i]);            
			}


		//	map.addLayer(pointLayer);
		//	map.setBaseLayer(road);
			map.setCenter(new OpenLayers.LonLat(100,35).transform("EPSG:4326", "EPSG:900913"),4);
			 map.addControl(new OpenLayers.Control.LayerSwitcher());  
            map.addControl(new OpenLayers.Control.MousePosition());  
            map.addControl(new OpenLayers.Control.ScaleLine());  
            map.addControl(new OpenLayers.Control.Scale);   
		//	map.zoomToMaxExtent();   
        }

    </script>
  </head>
<body onload="init()">
<h1 id="title">基于WebGIS的物联网跟踪系统</h1>

    <div id="map" ></div>
	<div id="op">
	<h2 id="username"></h2>
	<jsp:include flush="true" page="Userinfo.jsp"></jsp:include>
    </div>
    <div id="results"><p>This system is designed and implemented by Wang,Ye
<% 
	  String username =(String)request.getParameter("username"); 
		UserBeanCL uCl=new UserBeanCL();
		ArrayList sessionKey=new ArrayList<String>();
		ArrayList sessionKey2=new ArrayList<String>();
		int i,j;
		
		sessionKey=uCl.getmarkers(username);
		sessionKey2=uCl.gettrack(username);

		i=uCl.getI();	 
%>

</p></div>

<script language="javascript">  
var username="<%=username%>";
var s=document.getElementById('username');
s.innerHTML="尊敬的用户："+username+",您好！";

	var list=new Array();
	getpoints(list);
	var PointsData=opData(list);
	
	
	var line=getline();
	function opData(list){
		var i=0;
		var result=new Array();
		var t;
	//	alert(list.length);
		for(var i=0;i<list.length;i++){
	
			result[i]=new Array();
		//	alert(list[i]);
			for(var j=0;j<5;j++){
			t=list[i].substring(0,list[i].indexOf('$'));
			list[i]=list[i].replace(t+"$","");
			result[i][j]=t;
			if(j==0){
				var a=t.indexOf('(');
				var b=t.indexOf(' ');
				var c=t.indexOf(')');
				result[i][j]=parseFloat(t.substring(a+1,b));
			//	alert(result[i][j]);
				result[i][j+1]=parseFloat(t.substring(b,c));
			//	alert(result[i][j+1]);
				j++;
			}	
			}
		//	alert(result[i]);
		}
		return result;
	}
	
	function getpoints(list){
	var p="<%=sessionKey%>";
	var n="<%=i%>";
	var i=n;
	p=p.replace("]",",");
	var a=p.indexOf(",");
	while(i>0){
		a=p.indexOf(",");
		list.push(p.substring(1,a));
		p=p.substring(a+1);
		i--;
		}
	}
	
	function getline(){
		var s="<%=sessionKey2%>";
		s=s.replace(")]",",)");
		s=s.replace("[MULTIPOINT(","");
		var x,y;
		var points=new Array();
		for(var i=0;s[0]!=')';i++){
			points[i]=new Array();
			x=s.indexOf(" ");
			y=s.indexOf(",");
			points[i][0]=s.substring(0,x);
			points[i][1]=s.substring(x+1,y);
			s=s.substring(y+1,s.length);
		}
		return points;
	}

</script>



</body>
</html>