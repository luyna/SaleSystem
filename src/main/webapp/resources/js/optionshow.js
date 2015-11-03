var optionShow={
	countryResult:null,//保存国家数据
	kindResult:null,//保存类别数据
	infoLevelResult:null,//保存信息级别数据
	rankReault:null,//保存舰船级别数据
	optionCreat:function(selectid,optionArray){//根据从后台读取的码表字符串数组数据创建option选项；
		//detailoptionstr+="<option value=\""+"全部"+"\">"+"全部"+"</option>";
		//console.log(optionArray);
		var optionstr="";
		for(k=0;k<optionArray.length;k++){
			optionstr+="<option value=\""+optionArray[k][0]+"\">"+optionArray[k][1]+"</option>";
			//console.log(k);
		}
		//console.log(detailoptionstr);
		$("#"+selectid).html(optionstr);
	},
	optionSelect:function(selectid,optionvalue){//根据从后台读取的码表字符串数组数据创建option选项；
		$("#"+selectid).val(optionvalue);
	},
	initializtionKind:function(kindArray){//对后台读取的类型码表字符串数组按其大类编码重新保存
		this.kindResult=new Array();
		for(i=0;i<kindArray.length;i++){
			var type=kindArray[i][0].substring(0,2);
			if(typeof this.kindResult[type]=="undefined"){
				this.kindResult[type]=new Array;
				this.kindResult[type].push(kindArray[i]);
			}
			else{
				this.kindResult[type].push(kindArray[i]);
			}
		}
	},
	initializtionRank:function(rankArray){//对后台读取的级别码表字符串数组按其细类编码重新保存
		this.rankResult=new Array();
		for(i=0;i<rankArray.length;i++){
			var type=rankArray[i][0].substring(0,5);
			if(typeof this.rankResult[type]=="undefined"){
				//console.log(type);
				this.rankResult[type]=new Array;
				this.rankResult[type].push(rankArray[i]);
			}
			else{
				this.rankResult[type].push(rankArray[i]);
			}
		}
	},
	initializtion:function(countrystr,inforstr,kindstr,rankstr){
		//对后台所传的字符串按格式初始化countryresult，rankresult，inforresult，kindresult数组
		var result;
		var i=0;
		var resultsplit;
		var type;
		if(typeof countrystr!=="undefined"&&countrystr!==""){
			this.countryResult=new Array;
			result=countrystr.split(";");
			for(i=0;i<result.length;i++){
				if(result[i]!==""){
					this.countryResult[i]=result[i].split("_");
					//console.log(this.countryResult[i]);
				}
			}
		}
		//console.log(this.countryResult);
		if(typeof inforstr!=="undefined"&&inforstr!==""){
			this.inforResult=new Array;
			result=inforstr.split(";");
			for(i=0;i<result.length;i++){
				if(result[i]!==""){
					this.inforResult[i]=result[i].split("_");
				}
			}
		}
		if(typeof kindstr!=="undefined"&&kindstr!==""){
			this.kindResult=new Array;
			result=kindstr.split(";");
			for(i=0;i<result.length;i++){
				if(result[i]!==""){
					resultsplit=result[i].split("_");
					type=resultsplit[0].substring(0,2);
					if(typeof this.kindResult[type]=="undefined"){
						//console.log(type);
						this.kindResult[type]=new Array;
						this.kindResult[type].push(resultsplit);
					}
					else{
						this.kindResult[type].push(resultsplit);
					}
				}
			}
		}
		if(typeof rankstr!=="undefined"&&rankstr!==""){
			this.rankResult=new Array;
			result=rankstr.split(";");
			for(i=0;i<result.length;i++){
				if(result[i]!==""){
					resultsplit=result[i].split("_");
					type=resultsplit[0].substring(0,5);
					if(typeof this.rankResult[type]=="undefined"){
						//console.log(type);
						this.rankResult[type]=new Array;
						this.rankResult[type].push(resultsplit);
					}
					else{
						this.rankResult[type].push(resultsplit);
					}
				}
			}
		}
	}
}