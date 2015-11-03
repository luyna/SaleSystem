
$(document).ready(function(){
	$("a").focus(function(){this.blur();});
    $(window).scroll(function (){ 
        /*var offsetTop = 500+ $(window).scrollTop() +"px";       
        $("#CompareBasket").animate({top : offsetTop },{ duration:600 , queue:false });*/
    });
}); 

// unicode 编码程序
function BasketEncodeCookie(InputString)
{
	/*var strRtn="";
	for (var i=InputString.length-1;i>=0;i--)
	{
		strRtn+=InputString.charCodeAt(i);
		if (i) strRtn+="a"; // 用 a 作分隔符
	}
	return strRtn;*/
	return InputString;
}

// unicode 解码程序
function BasketDecodeCookie(InputString)
{
	/*
	var strArr;
	var strRtn="";

	strArr=InputString.split("a");

	for (var i=strArr.length-1;i>=0;i--)
		strRtn+=String.fromCharCode(eval(strArr[i]));

	return strRtn;*/
	return InputString;
}

// 读 Cookie
function BasketGetCookie(name)
{
	var strArg=name+"=";
	var nArgLen=strArg.length;
	var nCookieLen=document.cookie.length;
	var nEnd;
	var i=0;
	var j;

	while (i<nCookieLen)
	{
		j=i+nArgLen;
		if (document.cookie.substring(i,j)==strArg)
		{
			nEnd=document.cookie.indexOf (";",j);
			if (nEnd==-1) nEnd=document.cookie.length;
			return BasketDecodeCookie(unescape(document.cookie.substring(j,nEnd)));
		}
		i=document.cookie.indexOf(" ",i)+1;
		if (i==0) break;
	}
	return null;
}

// 写 Cookie
function BasketSetCookie(name,value,expires)
{
	var exp = new Date();
	exp.setTime(exp.getTime()+expires*60*60*1000);
	document.cookie=name+"="+escape(BasketEncodeCookie(value))+";expires="+exp.toGMTString()+";path=/";
}

// 判断 Cookie 是否存在并写产品对比 Cookie
function BasketCheckSetCookieValue(name,value,expires)
{
	//alert("value"+value);
	var nameCookieValue = BasketGetCookie(name);
	if ((nameCookieValue == "") || (nameCookieValue == null))
	{
		var exp = new Date();
		exp.setTime(exp.getTime()+expires*60*60*1000);
		document.cookie=name+"="+escape(BasketEncodeCookie(value))+";expires="+exp.toGMTString()+";path=/";
	}
	else
	{
		if (nameCookieValue.indexOf(value) == -1)
		{
			var arrCookies = nameCookieValue.split("∈");
			var ValueNum = arrCookies.length;
			if (ValueNum > 9)
			{
				nameCookieValue = "";
				for (loop=0; loop < 9; loop++)
				{
					nameCookieValue += arrCookies[loop] + "∈";
				}
				nameCookieValue = nameCookieValue.substring(0,nameCookieValue.length - 1);
			}

			var exp = new Date();
			exp.setTime(exp.getTime()+expires*60*60*1000);
			document.cookie=name+"="+escape(BasketEncodeCookie(value+"∈"+nameCookieValue))+";expires="+exp.toGMTString()+";path=/";
		}
	}

}

function hide()
{
  obj=document.getElementById("CompareBasket");
  obj.style.display='none';
}

function show()
{
  obj=document.getElementById("CompareBasket");
  obj.style.display='block';
}

function Empty()
{
	BasketSetCookie("POP_SubCategory","",2);
	BasketSetCookie("POP_CompareProducts","",2);
	redraw();
	hide();
}

// 判断选择的产品和以前选择的产品是否同类同类产品
function CheckCategoryChange(SubCategory)
{
	var SubCategorySN = BasketGetCookie("POP_SubCategory");	
	if ((SubCategorySN == null) || (SubCategorySN == ""))
	{
		BasketSetCookie("POP_SubCategory",SubCategory,2);
	}
	else
	{
		if (SubCategory != SubCategorySN)
		{
			//alert("您将要添加的装备与之前添加的对比装备不是同一类型，之前添加的对比装备将清空！");
			var YESORNO = confirm("您将要添加的装备与之前添加的对比装备不是同一类型，是否将已经添加的对比装备清空？");
            if (YESORNO){
            	BasketSetCookie("POP_SubCategory",SubCategory,2);
    			BasketSetCookie("POP_CompareProducts","",2);
    			return true;
            }
            return false;
		}
	}
}

function AddCompareProduct(ProductSN,ProductName,ProductImg,SubCategory,BrandSN)
{
	if(CheckCategoryChange(SubCategory)==false) {
		ShowLayer();
		return;
	}
	var CompareProducts = BasketGetCookie("POP_CompareProducts");
	if ((CompareProducts != "") && (CompareProducts != null))
	{
		var arrCookies = CompareProducts.split("∈");
		if (arrCookies.length < 4)
		{
			if (CompareProducts.indexOf(ProductSN) != -1)
			{
				alert("装备（" + ProductName + "）已经被选择了！");
			}
			else
			{
				BasketCheckSetCookieValue("POP_CompareProducts",ProductSN + "Σ" + ProductName + "Σ" + ProductImg+ "Σ" +SubCategory+ "Σ" +BrandSN,2);
			}
		}
		else
		{
			var YESORNO = confirm("对不起，您只能选择四个装备进行对比，是否清除已选装备？");
            if (YESORNO) {
                Empty();
            }
		}
	}
	else
	{
		BasketCheckSetCookieValue("POP_CompareProducts",ProductSN + "Σ" + ProductName + "Σ" + ProductImg+ "Σ" +SubCategory+ "Σ" +BrandSN,2);
	}
	redraw();
	ShowLayer();
}

function DelProduct(ProductSN)
{
	var nameCookieValue = BasketGetCookie("POP_CompareProducts");
	if ((nameCookieValue != null) && (nameCookieValue != ""))
	{
		if (nameCookieValue.indexOf(ProductSN) > -1)
		{
			var arrCookies = nameCookieValue.split("∈");
			var ValueNum = arrCookies.length;
			nameCookieValue = "";
			for (i=0; i < ValueNum; i++)
			{
				if (arrCookies[i].indexOf(ProductSN) == -1)
				{
					nameCookieValue += arrCookies[i] + "∈";
				}
			}
			nameCookieValue = nameCookieValue.substring(0,nameCookieValue.length - 1);
			BasketSetCookie("POP_CompareProducts",nameCookieValue,2);
		}
		redraw();
	}
}

var links="";
function redraw()
{
	//FixPosition();
	var CompareProducts = BasketGetCookie("POP_CompareProducts");
	if (CompareProducts == null)
	{
		CompareProducts = "";
	}
	var arrCookies = CompareProducts.split("∈");
	var Mylength=0;
	if(arrCookies.length>0  && (arrCookies[0] != null)&& (arrCookies[0] != "")){Mylength=arrCookies.length;}
	else hide();
	var CompareTable = "";//"<div class='aprmona'><div class='aprmona1'>- 产品对比 - </div><div class='aprmona2'>";
	CompareTable="<div class=db><div class=db1><div class=db11>["+Mylength+"/4]对比栏</div><div class=db12><img height=13 onClick='HideLayer()' src='images/db2.gif' style='cursor:pointer' width=14 /></div></div>";
	var versioncodes="";
	var SubCategorySN="";
	var BrandSN="";
	for(var i=0;i<4;i++){
			
			if(i<= Mylength-1){
				if ((arrCookies[i] != "") && (arrCookies[i] != null))
				{
					if (arrCookies[i].indexOf("Σ") >= 0)
					{
						var ProductInfo = arrCookies[i].split("Σ");
						if (ProductInfo.length = 5)
						{
							var ProductSN = ProductInfo[0];
							//alert("ProductSN:"+ProductSN);
							var ProductName = ProductInfo[1];
							var ProductLink = "/"+ProductSN+"/Index.html";
							var ProductImg = ProductInfo[2];
							SubCategorySN=ProductInfo[3];
							BrandSN=ProductInfo[4];
							/*if( ProductInfo[2].toString().indexOf(".jpg") > -1 )
							{
								ProductImg = "http://img.autohome.com.cn/"+ProductInfo[2].replace("~","");
							}
							else
							{
								ProductImg = "http://www.163css.net/myweb/net163/template/net163/cssjs/201107/qqpro/images/"+ProductInfo[2]+".jpg";
							}
							//alert(ProductImg);
							if(ProductInfo[2]=="")
							{
								ProductImg="http://www.163css.net/myweb/net163/template/net163/cssjs/201107/qqpro/images/default80x60.jpg";
							}*/
							if (ProductSN == null){ProductSN = "";}
							if (ProductName == null){ProductName = "";}
							if (ProductLink == null){ProductLink = "";}
							if (ProductImg == null){ProductImg = "";}
							if (SubCategorySN==null){SubCategorySN="";}
							if (BrandSN==null){BrandSN="";}
							if ((ProductName != "") && (ProductSN != "") && (ProductLink != "") && (ProductImg != "") && (SubCategorySN !=""))
							{
								CompareTable+="<div class=db2><div class=db3>";
								CompareTable+="<div class=db31><img height=30 border=0 width=40 onError='this.src=\"./image/nopic1.jpg\"' src='" + ProductImg + "' /></div>";
								CompareTable+="<div class=db32><a target=_blank href='/MilitaryMS_v2/disEquipDetailInfoAction?versioncode="+ProductSN+"&tablename="+SubCategorySN+"' title='"+ProductName+"'>" + CutStr(ProductName, 16) + "</a></div><div class=db33 ><img alt='移除' height=11 width=11 src='./images/db3.gif' style='cursor:pointer' onClick=\"DelProduct('" + ProductSN + "')\"/></div></div></div>";
								versioncodes += ProductSN+",";
							}
						}
					}
				}
			}else{
				CompareTable+="<div class=db2><div class=db3>";
				CompareTable+="<div class=db31></div>";
				CompareTable+="<div class=db32></div><div class=db33 ></div></div></div>";
			}
		}
		
	links="/MilitaryMS_v2/compareEquipAction?versioncodes="+versioncodes+"&tableid="+BrandSN+"&tablename="+SubCategorySN;
	//alert(links);
	CompareTable+="<div class=db4><a style='color:blue;cursor:pointer' onClick='CompareCheck()' target='_blank'>进行对比</a></div><div class=db5><a style='color:blue;cursor:pointer' onClick='Empty()'>清空对比栏</a></div></div>";
	//CompareTable+="<div class=db4><input type=button value=进行对比 onClick=window.open('http://www.163css.com') /></div><div class=db5><a   style='color:blue;cursor:pointer' onClick='Empty()'>清空对比栏</a></div></div>";
	
	jQuery('#CompareBasket').html(CompareTable);	
	/*$(".db .db2").mouseover(function(){this.className='db2r';$(this).children().children('.db33').show();});
	$(".db .db2").mouseout(function(){this.className='db2';$(this).children().children('.db33').hide();});*/
}

function IsNumber(inputVal)
{
	var inputStr = inputVal.toString();
	var i = 0;
	for (i =0; i<inputStr.length; i++)
	{
		var oneChar = inputStr.charAt(i)
		if (oneChar < "0" || oneChar> "9")
		{
			return false;
		}
	}
	return true;
}

function CompareCheck()
{
	//var URL = "/";
	var CompareProductsValue = BasketGetCookie("POP_CompareProducts");
	var b="00283";
	if ((CompareProductsValue != "") && (CompareProductsValue != null))
	{
		var arrValues = CompareProductsValue.split("∈");
		var ValuesNum = arrValues.length;
		if (ValuesNum < 2)
		{
			alert ('请至少选择两种同类别装备进行对比！');
			return;
		}
		else
		{
			var isTwo = false;
			window.open(links);			
		}
	}
	//Empty();
}

redraw();

function HideLayer()
{
	BasketSetCookie("POP_HiddenCompare","Hide",24);
	hide();
}

function ShowLayer()
{
	BasketSetCookie("POP_HiddenCompare","Show",24);
	show();
}

if ((BasketGetCookie("POP_HiddenCompare") == "Hide") || (BasketGetCookie("POP_CompareProducts") == "") || (BasketGetCookie("POP_CompareProducts") == null))
{
	HideLayer();
}
else
{
	ShowLayer();
}

function CutStr(str, length)
{   
   var a = str.replace(/([\u0391-\uffe5])/ig, '$1a');
   var b = a.substring(0, length);
   var c = b.replace(/([\u0391-\uffe5])a/ig, '$1');
   return c;
}
