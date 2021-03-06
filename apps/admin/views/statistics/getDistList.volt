<!doctype html>
<html>
<head>
        <link rel="stylesheet" href="/css/admin/base.css">
<link rel="stylesheet" href="/css/stats/AdminLTE.min.css" >
<link rel="stylesheet" type="text/css" href="/bootstrap/3.3.0/css/bootstrap.min.css">
<link rel="stylesheet" href="/css/admin/font-awesome.min.css" >
<link rel="stylesheet" href="/bootstrap/datetimepicker/bootstrap-datetimepicker.min.css">

<style>
.operate {
    margin-right: 10px;
}
.operate:hover {
    cursor:pointer;
    color:green;
}

table tr th{
	text-align:center;
}
body {
     font-family: "Arial","微软雅黑",sans-serif;
}

span.normals{
	cursor:pointer;
	margin-right:0;
	margin-left:6px;
}

select.select-sm{
	float:left;
	border-radius: 3px;
    font-size: 12px;
    height: 30px;
    line-height: 1.5;
	margin-right: 7px;
}
select.select-pos{
	float:left;
	background-color: #fff;
    background-position: right center;
    background-repeat: no-repeat;
    border: 1px solid #ccc;
    border-radius: 3px;
    box-shadow: 0 1px 2px rgba(0, 0, 0, 0.075) inset;
    box-sizing: border-box;
    color: #333;
    font-size: 13px;
    min-height: 32px;
    outline: medium none;
    transition: all 0.15s ease-in 0s;
    vertical-align: middle;
}
div .input-pos{
	float:left;
 	width: 130px;
	background-color: #fff;
    background-position: right center;
    background-repeat: no-repeat;
    border: 1px solid #ccc;
    border-radius: 3px;
    box-shadow: 0 1px 2px rgba(0, 0, 0, 0.075) inset;
    box-sizing: border-box;
    color: #333;
    font-size: 13px;
    margin: 0;
    min-height: 32px;
    outline: medium none;
    padding: 7px 8px;
    transition: all 0.15s ease-in 0s;
    vertical-align: middle;
}

input.btn-small {
	float:left;
    -moz-border-bottom-colors: none;
    -moz-border-left-colors: none;
    -moz-border-right-colors: none;
    -moz-border-top-colors: none;
    -moz-user-select: none;
    background-color: #eaeaea;
    background-image: linear-gradient(#fafafa, #eaeaea);
    background-repeat: repeat-x;
    border-color: #ddd #ddd #c5c5c5;
    border-image: none;
    border-radius: 3px;
    border-style: solid;
    border-width: 1px;
    box-shadow: 0 1px 3px rgba(0, 0, 0, 0.05);
    box-sizing: border-box;
    color: #333;
    cursor: pointer;
    display: inline-block;
    font-size: 13px;
    font-weight: bold;
    margin: 0;
     padding: 5px 15px;
    position: relative;
    text-shadow: 0 1px 0 rgba(255, 255, 255, 0.9);
    vertical-align: middle;
    white-space: nowrap;
}
</style>
</head>
<body class="wrap">
<div class="tab-content" style="padding:20px 0px;">
   <!-- 广告列表  -->
   <div role="tabpannel" class="tab-pane active" id="adsList">
	   <div class="col-xs-12 text-center loading" style="display:none">
	           <i class="fa fa-pulse fa-spinner fa-3x"></i>
	   </div>
	      
       <table class="table table-hover table-bordered">
          <thead>
         	  <tr>
         		<th colspan="3" id="mapTitle" style="text-align:center">省市会员分布一览表</th>
         		<th style="text-align:center"><a href="/admin/statistics/statMember"><i class="fa fa-backward"></i> 返回</a></th>
         	  </tr>
              <tr>
                  <th>序号</th>
                  <th>所在省</th>
                  <th>会员总数</th>
                  <th style="width:330px;">
                  	<div class="input-group" style="display:none; float:left">
		                <input class="input-sm input-pos" readonly type="text" onclick="this.value=''" />
		                <select class="select-sm select-pos" onchange="changeFormatType(this)">
		                  <option value="0">天</option>
		                  <option value="1">年份</option>
		                  <option value="2">月份</option>
		                  <option value="3">小时</option>
		                  <option value="4">时间段</option>
		                </select>
		                <input class="btn-small" type="button" onclick="getDetails(this)" value="确认">
		           	</div>
                  	<span class="normals" onclick="showDatePicker( this )"><i class="fa fa-calendar"></i></span>
                  </th>
              </tr>
          </thead>
                    
         {% if plist is defined and plist is not empty %}
        <tbody id="provinceList">
        	{% for i,item in plist %}
            <tr {% if item['num'] > 30000 %} class="danger" {% endif %} {% if item['son'] > 0 %} style="cursor:pointer" onclick="getCityList( this , {{ item['pid']}} ); {% endif %}">
                <td style="text-align:center">{{ i+1 }}</td>
                <td class="pname" style="text-align:center">{{ item['pname'] }}</td>
                <td style="text-align:center">{{ item['num'] }}</td>
                <td style="text-align:center"></td>
            </tr>
           {% endfor %}
        </tbody>
      {% endif %}
    </table>
                
      <div style="color: #000;left: 40%;margin-left: -15px;margin-top: -15px;position: absolute;top: 40%; display:none">
          	<div class="alert alert-info alert-dismissable">
              <h4><i class="icon fa fa-info"></i> 提示信息!</h4>
              <p id="dis_message"></p>
            </div>
      </div>
	 
    </div>
    
    <!-- 详细列表  -->
	<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
	  <div class="modal-dialog" role="document">
	    <div class="modal-content">
	      <div class="modal-header">
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
	        <h4 class="modal-title" id="myModalLabel"></h4>
	      </div>
	      <div class="modal-body">
	      	<table class="table table-hover table-bordered">
		          <thead>
		              <tr>
		                  <th>序号</th>
		                  <th>所在市</th>
		                  <th>会员数</th>
		                  <th>时间</th>
		              </tr>
		          </thead>
		        <tbody id="cityList"></tbody>
		    </table>
	      </div>
	      <div class="modal-footer">
	        <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
	      </div>
	    </div>
	  </div>
	</div>
    <!-- 详细列表  -->
</div>
        
<script src="/js/jquery/jquery-1.11.1.min.js"></script>
<script src="/bootstrap/3.3.0/js/bootstrap.min.js"></script>
<script src="/bootstrap/datetimepicker/bootstrap-datetimepicker.min.js"></script>
<script src="/bootstrap/datetimepicker/bootstrap-datetimepicker.zh-CN.js" charset="UTF-8"></script>
<script src="/js/admin/statistics/stat_user_map.js"></script>
</body>
</html>