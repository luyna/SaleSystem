
function addCookie(objName, objValue, objHours) {  
	//判断是否已存在相同名称的cookie 存在则删除  
	//console.log("Set:"+objValue);
	var str = objName + "=" + escape(objValue);  
    //为0时不设定过期时间,浏览器关闭时Cookie自动消失  
    if (objHours > 0) {  
        var date = new Date();  
        var ms = objHours * 3600 * 1000;  
        date.setTime(date.getTime() + ms);  
        str += "; expires=" + date.toGMTString();  
    }  
    //添加cookie   
    //console.log("Set:"+str);
    document.cookie = str;   

}  
function getCookie(name) {  
    //获得cookie  
    var bikky = document.cookie;  
    name += "=";  
    var i = 0;  
    //console.log(bikky);
    //如果cookie 不为空则 循环截取出 相应 名称 的cookie值  
    while (i < bikky.length) {  
        var offset = i + name.length;  
        if (bikky.substring(i, offset) == name) {  
            var endstr = bikky.indexOf(";", offset);  
            if (endstr == -1) endstr = bikky.length;  
            return unescape(bikky.substring(offset, endstr));  
        }  
        i = bikky.indexOf(" ", i) + 1;  
        if (i == 0) break;  
    }  
    return null;  
}
$("li a.dropdown-toggle").click(function(){
	var id=$(this).attr("id");
	var showoperationid=id.split("_");
	//console.log(showoperationid[1]);
	if(typeof showoperationid[1]!==undefined &&showoperationid[1]!==''){//当现在操作的是第二层导航栏时
		if($("#"+showoperationid[1]+"ul").css("display")=="block"){//当点击是为了收缩第二层导航栏时，只保存第一层导航栏的ID值，这样重新进入该网页时该层导航栏将处于收缩状态
			addCookie("showid",showoperationid[0]+'_',0);
		}
		else addCookie("showid",id,0);//当点击是为了展开第二层导航栏时，保存第一、二层导航栏的ID值
	}
	else{//当现在操作的是第一导导航栏时
		if($("#"+showoperationid[0]+"ul").css("display")=="block"){
			addCookie("showid",'',0);//当点击是为了收缩第一层导航栏时，不保存ID值，这样重新进入该网页时该层导航栏将处于收缩状态
		}
		else addCookie("showid",showoperationid[0]+'_',0);//当点击是为了展开第一层导航栏时，保存第一层导航栏的ID值
	}
	//console.log("cookie:"+document.cookie);
});
$().ready(function(){//读取存取的cookie值，展开相应的导航栏
	var showid=getCookie("showid");
	//alert(showid);
	if(showid!==null){
		var showoperationid=showid.split("_");
		//console.log(showidarray);
		for(var i=0;i<showoperationid.length;i++){
			if(showoperationid[i]!==""){
				$("#"+showoperationid[i]+"li").addClass("open");
				$("#"+showoperationid[i]+"ul").css("display","block");
			}
		}
	}
	//var herf="";
	var courrentaction=window.location.pathname.split("/")[2]+window.location.search;
	$("#main-container a").each(function(){
	    var href=$(this).attr("href");
	    if(typeof href !=="undefined"){
		    if(href.indexOf(courrentaction)>=0){
		    	$(this).css("background-color","#fdc536");
		    }
		    else{
		    	$(this).css("background-color","");
		    }
		}
	  });
	//console.log(courrentaction);
});