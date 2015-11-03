var carrylistoperation={
	path:null,
	versioncode:null,
	kind:null
}


$("#equipmentsearchlist").on("click","button",function(){//将装备添加到该平台的搭载关系中
	var informationtr=$(this).parent().parent();
	var appendtr="";
	var equipmenttd=informationtr.children("td").first();
	var equipmenthref=informationtr.find("a").first().attr("href");
	var parsestr=equipmenthref.split("?");
	parsestr=parsestr[1].split("&");
	var equipmentid=parsestr[0].split("=")[1];
	var kind=parsestr[1].split("=")[1];

	//表明该装备已经搭载，并提示用户不要重复添加已经的搭载的装备。如果该ID值不存在，则正常添加
	var weaponrelationstr=$("#weaponrelation").val();
	var reg=new RegExp(equipmentid+"_\\d+;");
	if(weaponrelationstr.search(reg)!==-1){
		alert("请不要重复添加已经搭载的装备");
		return ;
	}
	/*$("#equipmentcarrylist table tr").each(function(){	
		if($(this).children("td").first().attr("id")==equipmentid){
			alert("请不要重复添加已经搭载的装备");
			repeatequipmen=true;
			return ;
		}
	});*/
	var	equipmentnum=informationtr.find("input").val();
	if(equipmentnum.match(/^(0|[1-9][0-9]*)$/g)==null){
		alert("请输入一个数字");
		return ;
	}
	var equipmentname=equipmenttd.text();
	equipmenttd=equipmenttd.next();
	var equipmentcountry=equipmenttd.text();
	equipmenttd=equipmenttd.next();
	var carrylisttable=$("#equipmentcarrylist table");
	appendtr+=appendtrproduct(equipmentid,kind,equipmentname,equipmentcountry,equipmentnum);
	carrylisttable.append(appendtr);
	$("#weaponrelation").val(weaponrelationstr+equipmentid+"_"+equipmentnum+";");
});
$("#equipmentcarrylist").on("click","button",function(){//将装备从到该平台的搭载关系中移除
	var informationtr=$(this).parent().parent()
	var equipmenthref=informationtr.find("a").first().attr("href");
	var parsestr=equipmenthref.split("?");
	parsestr=parsestr[1].split("&");
	var equipmentid=parsestr[0].split("=")[1];
	var weaponrelationstr=$("#weaponrelation").val();
	var reg=new RegExp(equipmentid+"_\\d+;");//利用正则表达式匹配weaponrelation输入框中的内容，并删除该装备的数据
	//将该装备的信息从表单输入的内容中删除
	weaponrelationstr=weaponrelationstr.replace(reg,"");
	$("#weaponrelation").val(weaponrelationstr);
	informationtr.remove();//删除掉表格中此行武器的信息
});
$("#equipmentcarrylist").on("change","input",function(){//当装备的搭载数量变更时，修改weaponrelation输入框中的内容
	var num=$(this).val();
	if(num.match(/^(0|[1-9][0-9]*)$/g)==null){
		alert("请输入一个数字");
		return ;
	}
	var informationtr=$(this).parent().parent();
	var equipmenthref=informationtr.find("a").first().attr("href");
	var parsestr=equipmenthref.split("?");
	parsestr=parsestr[1].split("&");
	var equipmentid=parsestr[0].split("=")[1];
	var weaponrelationstr=$("#weaponrelation").val();
	var reg=new RegExp(equipmentid+"_\\d+;")//利用正则表达式匹配weaponrelation输入框中的内容，并删除该装备的数据
	//将该装备的信息从表单输入的内容中替换
	weaponrelationstr=weaponrelationstr.replace(reg,equipmentid+"_"+num+";");
	//console.log(weaponrelationstr);
	$("#weaponrelation").val(weaponrelationstr);
	//console.log($("#weaponrelation").val());
});
$("#equipmentkind").change(function(){//当装备类型的选项更改时，更改具体细类中的选项
	var selecttype=$(this).val();
	var detailoptionstr="";
	detailoptionstr+="<option value=\""+"all"+"\">"+"所有"+"</option>";
	if(optionShow.kindResult!=null){
		var type=optionShow.kindResult[selecttype]
		if(typeof type!="undefined"){
			for(var k=0;k<type.length;k++){
				detailoptionstr+="<option value=\""+type[k][0]+"\">"+type[k][1]+"</option>";
			}
		}
		$("#detailkind").html(detailoptionstr);
	}
	else {
		//此情况说明（1）ajax未能从后台读取到数据,在AJAX可以返回数据后程序可以正常运行
		//（2）或者后台无法正确数据返回，需要刷新页面或检查后台的是否正常运行
		alert("请稍等片刻或刷新页面");
	}
});

//根据后能返回的数据在前台展示其具体内容
function resultlistshow(result){
	$("#equipmentsearchlist table tr").remove("[class!=equipmentlistlisthead]");
	var appendtr="";

	var countryarray=new Array;
	var i=0;

	for(i=0;i<result.length;i++){
		appendtr+=appendtrproduct(result[i]["versioncode"],result[i]["type"],result[i]["versionname"],result[i]["country"],1,true);
	}

	$("#equipmentsearchlist table").append(appendtr);
}
//根据具体参数（装备编码，装备名称，装备国家，装备数量，添加（布尔值））生成搭载关系模块中展示装备的每一行内容
function appendtrproduct(equipmentid,kinden,equipmentname,equipmentcountry,equipmentnum,add){
	if(add===true)	buttonvalue="添加";
	else buttonvalue="删除";
	/*"<tr>	<td > 
	 * <a href="carrylistoperation.path+/disEquipDetailInfoAction?versioncode=02000001&equipname=Submarine">"+equipmentname+"</a>
	 *  </td>" +	//生成装备名称列
	"<td>"+equipmentcountry+"<td>" +		//生成国家列
	"<input type=\"text\" maxlength=\"4\" value=\""+equipmentnum+"\"/></td>"+//生成装备数量输入列
	"<td><button  onclick=\"\"  type=\"button\"  >删除</button></td>"+"</tr>";//生成操作按钮*/
	var appendtr="<tr class=\"weapontr\">	<td>"
		+" <a  target=\"_blank\" href=\""+carrylistoperation.path+"/disEquipDetailInfoAction?versioncode="+equipmentid+"&tablename="+kinden+"\">"+equipmentname+"</a> </td>" +	//生成装备名称列及链接
				"<td>"+equipmentcountry+"</td>" +		//生成国家列
				"<td><input type=\"text\" maxlength=\"4\" value=\""+equipmentnum+"\"/></td>"+//生成装备数量输入列
				"<td><button  onclick=\"\"  type=\"button\"  >"+buttonvalue+"</button></td>   </tr>";//生成操作按钮
	//console.log(appendtr);
	return appendtr;
}
//console.log(carrylistoperation.path);
/*用来向后台发送数据查询对应的装备*/
var firstsearch;
$("#equipmentsearch").click(function(){
	$("#Paginationcarrylist").html("");
	firstsearch=true;
	searchequip(0);
});
function searchequip(pagenow){
	var kind=$("#equipmentkind").val();
	var detailKind=$("#detailkind").val();
	var country=$("#searchcountry").val();
	//var equipmentname=encodeURI(encodeURI($("#searchequipmentname").val()));
	var equipmentname=$("#searchequipmentname").val();
	$.ajax({
		type : 'POST',
		data :{
			equipcode:kind,
			kindcode:detailKind,
			countryid:country,
			versionname:equipmentname,
			pagesize:15,
			pagenow:pagenow,
		},
		dataType: 'json',  
	    async:false,
		url:carrylistoperation.path+'/relationSearchEquipmentAction',
		success : function(msg) {
			if(typeof msg.equipone !=="undefined"){
				resultlistshow(msg.equipone);
				var total=msg.resultCount;
			    // 创建分页 
				//console.log(total);
				if($("#Paginationcarrylist").html()==""){
				    if(total<=15){
				    	$("#Paginationcarrylist").html("<div></div>");
				    }else{ 
				    	$("#Paginationcarrylist").pagination(total, {
					    	num_edge_entries: 1, //边缘页数
					    	num_display_entries: 3, //主体页数				    		
					    	callback: pageselectCallback,
					    	items_per_page: 15, //每页显示15项
					    	prev_text: "<前一页",
					    	next_text: "后一页>"
					    });  
				    }
				}
			}
			else	alert("数据库中无该类型数据");
		},
		error : function(a,b,c) {
			alert("数据库中无该类型数据");
		}
	});
	function pageselectCallback(page_index){ 
    	if(firstsearch===true){
    		//alert("已经一次！");
    		firstsearch=false;
    		return false;
    	}
		searchequip(page_index);  
        return false;
    }
}
$("#alterweaponrelation").click(function(){//点击确定后，向后台发送新的搭载关系关刷新页面
	var weaponrelationstr=$("#weaponrelation").val();
	$.ajax({
		type : 'POST',
		data : {weaponrelationstr:$("#weaponrelation").val()},
		url:carrylistoperation.path+'/alterWeaponRelationAction?versioncode='+carrylistoperation.versioncode,
		success : function(msg) {
			location.reload(true);//刷新当前页面，以在页面上更新搭载关系数据
		},
		error : function(a,b,c) {
			alert("修改装备搭载关系失败");
		}
	});
});
