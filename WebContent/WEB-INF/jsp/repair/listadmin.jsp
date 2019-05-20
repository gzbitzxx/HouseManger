<%@ page language="java" import="java.util.*" pageEncoding="Utf-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<base href="<%=basePath%>">
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<link href="resource/css/bootstrap.min.css" rel="stylesheet" />
<link rel="stylesheet"
	href="resource/plugins/grid_manager/GridManager.min.css">
<link rel="stylesheet" href="resource/layui/css/layui.css">
<link href="resource/css/bootstrap.min.css" rel="stylesheet" />
<link rel="stylesheet"
	href="resource/plugins/grid_manager/GridManager.min.css">
<script src="resource/js/jquery.min.js"></script>
<script src="resource/js/jquery.validate.min.js"></script>
<script src="resource/js/bootstrap.min.js"></script>
<script src="resource/js/common.js"></script>
<script type="text/javascript"
	src="resource/plugins/grid_manager/GridManager.min.js"></script>
<script type="text/javascript" src="resource/layui/layui.js"></script>
<style type="text/css">
.GridManager-ready td{
		text-align:center;
	}
span.field-validation-error {
	color: red;
}
</style>
<script type="text/javascript">
	$(function() {
		init("");
		SelectInfo("common/findIDAndNumberUserId", "#userid");
	})

	function init(keyword) {
		var table = document
				.querySelector('table[grid-manager="demo-ajaxPageCode"]');
		table
				.GM({
					ajax_url : 'repair/list',
					ajax_type : 'POST',
					query : {
						pluginId : 1,
						'keyword' : keyword
					},
					supportAjaxPage : true,
					supportCheckbox : false,
					columnData : [
							{
								key : 'content',
								text : '保修事项'
							},
							{
								key : 'starttime',
								text : '报修时间'
							},
							{
								key : 'userName',
								text : '保修用户'
							},
							{
								key : 'status',
								text : '保修状态',
								template : function(action, rowObject) {
									return '<lable style="color: #FFF;background: #337ab7;display: inline-block;padding: 4px 10px;border-radius: 4px;" />'+rowObject.status+'</lable>';
								}
							},
							{
								key : 'endtime',
								text : '维修时间'
							},
							{
								key : 'repairname',
								text : '检修用户'
							},
							{
								key : 'action',
								remind : 'the action',
								width : '300px',
								text : '操作',
								template : function(action, rowObject) {
									return '<a style="color: #FFF;background: #337ab7;display: inline-block;padding: 4px 10px;border-radius: 4px;" onclick="deleteInfo(\''
											+ rowObject.id
											+ '\')">删除</a>'
											+ " | "
											+'<a style="color: #FFF;background: #337ab7;display: inline-block;padding: 4px 10px;border-radius: 4px;" href="javascript:;" onclick="lookInfo(\''
											+ rowObject.id + '\')">查看</a>'
											+ " | "
											+ '<a style="color: #FFF;background: #337ab7;display: inline-block;padding: 4px 10px;border-radius: 4px;" href="javascript:;" onclick="auditInfo(\''
											+ rowObject.id + '\')">审核</a>'
											;
								}
							} ]

				});
	}
</script>
</head>
<body style="margin: 20px">
	<div class="row">
		<div class="col-md-10">
			<h3>保修记录</h3>
		</div>
		<div class="col-md-1">
			<div class="form-group">
				<button type="button" data-toggle="modal" data-target="#myModal"
					class="btn">
					<span class="glyphicon glyphicon-plus" aria-hidden="true"></span>添加报修
				</button>
			</div>
		</div>
	</div>
	<div class="row col-md-11">
		<div class="input-group">
			<input type="text" id="key" class="form-control"> <span
				class="input-group-btn">
				<button type="button" id="serach" class="btn btn-primary">
					<span class="glyphicon glyphicon-search" aria-hidden="true"></span>搜索
				</button>
			</span>
		</div>
	</div>
	<div style="clear: both;"></div>
	<div class="cls"></div>
	<table grid-manager="demo-ajaxPageCode"></table>
	
	<!-- 添加、修改框 -->
	<div class="modal fade" tabindex="-1" role="dialog" id="myModal">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="modal-title">添加报修</h4>
				</div>
				<form id="data">
					<div class="modal-body">
						<input type="hidden" id="id">
						<input id="userType" type="hidden" value="${user.type }">
						<input id="userId"  type="hidden" value="${user.id }">
						<div class="row">
							<div class="col-lg-12" id="user">
								<div class="form-group" lang="userid">
									<label for="driverid">用户：</label> </label> <select name="userid"
										id="userid" class="selectpicker form-control"
										data-live-search="true">
										<option value="">请选择</option>
									</select>
								</div>
							</div>

							<div class="col-lg-12">
								<div class="form-group" lang="content">
									<label for="phone">维修名称：</label> <input type="text"
										class="form-control" name="name" id="name" placeholder="内容"
										data-val="true" data-val-required="请填写 &#39;维修名称&#39;。">
									<span class="field-validation-error" data-valmsg-for="name"
										data-valmsg-replace="true"></span>
								</div>
							</div>
							<div class="col-lg-12">
								<div class="form-group" lang="content">
									<label for="phone">内容：</label> <input type="textarea"
										class="form-control" name="content" id="content"
										placeholder="内容" data-val="true"
										data-val-required="请填写 &#39;内容&#39;。"> <span
										class="field-validation-error" data-valmsg-for="content"
										data-valmsg-replace="true"></span>
								</div>
							</div>
							<div class="col-lg-12">
								<div class="form-group" lang="phone">
									<label for="phone">联系电话：</label> <input type="text"
										class="form-control" name="phone" id="phone" placeholder="内容"
										data-val="true" data-val-required="请填写 &#39;联系电话&#39;。">
									<span class="field-validation-error" data-valmsg-for="phone"
										data-valmsg-replace="true"></span>
								</div>
							</div>
							<div class="col-lg-12">
								<div class="form-group" lang="content">
									<label for="phone">费用：</label> <input type="textarea"
										class="form-control" name="money" id="money" placeholder="费用"
										data-val="true" data-val-required="请填写 &#39;费用&#39;。">
									<span class="field-validation-error" data-valmsg-for="money"
										data-valmsg-replace="true"></span>
								</div>
							</div>
							<div class="col-lg-12">
								<div class="form-group" lang="remarks">
									<label for="phone">备注：</label> <input type="textarea"
										class="form-control" name="remarks" id="remarks"
										placeholder="备注" data-val="true"
										data-val-required="请填写 &#39;备注&#39;。"> <span
										class="field-validation-error" data-valmsg-for="remarks"
										data-valmsg-replace="true"></span>
								</div>
							</div>
							<div class="col-lg-12">
								<div class="form-group" lang="content">
									<label for="phone">图片上传：</label> <input type="textarea"
										class="form-control" name="pictures" id="pictures"
										placeholder="图片上传" data-val="true"
										data-val-required="请填写 &#39;图片上传&#39;。"> <span
										class="field-validation-error" data-valmsg-for="pictures"
										data-valmsg-replace="true"></span>
								</div>
							</div>
						</div>
						<div class="modal-footer">
							<button type="button" class="btn btn-default"
								data-dismiss="modal">关闭</button>
							<button type="button" class="btn btn-primary" id="add">保存</button>
						</div>
					</div>
			</div>
			</form>
		</div>
		<!-- /.modal-content -->
	</div>
	
	
	<!-- 审核-->
	<div class="modal fade" tabindex="-1" role="dialog" id="myModal2">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="modal-title">查看维修记录</h4>
				</div>
				<form id="data1">
					<div class="modal-body">

							<div class="col-lg-12">
								<div class="form-group" lang="content">
									<label for="phone">维修名称：</label> <input type="text"
										class="form-control" name="name" id="name1" placeholder="内容"
										data-val="true" data-val-required="请填写 &#39;维修名称&#39;。">
									<span class="field-validation-error" data-valmsg-for="name"
										data-valmsg-replace="true"></span>
								</div>
							</div>
							<div class="col-lg-12">
								<div class="form-group" lang="content">
									<label for="phone">内容：</label> <input type="textarea"
										class="form-control" name="content" id="content1"
										placeholder="内容" data-val="true"
										data-val-required="请填写 &#39;内容&#39;。"> <span
										class="field-validation-error" data-valmsg-for="content"
										data-valmsg-replace="true"></span>
								</div>
							</div>
							<div class="col-lg-12">
								<div class="form-group" lang="phone">
									<label for="phone">联系电话：</label> <input type="text"
										class="form-control" name="phone" id="phone1" placeholder="内容"
										data-val="true" data-val-required="请填写 &#39;联系电话&#39;。">
									<span class="field-validation-error" data-valmsg-for="phone"
										data-valmsg-replace="true"></span>
								</div>
							</div>
							<div class="col-lg-12">
								<div class="form-group" lang="content">
									<label for="phone">费用：</label> <input type="textarea"
										class="form-control" name="money" id="money1" placeholder="费用"
										data-val="true" data-val-required="请填写 &#39;费用&#39;。">
									<span class="field-validation-error" data-valmsg-for="money"
										data-valmsg-replace="true"></span>
								</div>
							</div>
							<div class="col-lg-12">
								<div class="form-group" lang="remarks">
									<label for="phone">备注：</label> <input type="textarea"
										class="form-control" name="remarks" id="remarks1"
										placeholder="备注" data-val="true"
										data-val-required="请填写 &#39;备注&#39;。"> <span
										class="field-validation-error" data-valmsg-for="remarks"
										data-valmsg-replace="true"></span>
								</div>
							</div>
							<div class="col-lg-12">
								<div class="form-group" lang="content">
									<label for="phone">图片上传：</label> <input type="textarea"
										class="form-control" name="pictures" id="pictures1"
										placeholder="图片上传" data-val="true"
										data-val-required="请填写 &#39;图片上传&#39;。"> <span
										class="field-validation-error" data-valmsg-for="pictures"
										data-valmsg-replace="true"></span>
								</div>
							</div>
						</div>
						<div class="modal-footer">
							<button type="button" class="btn btn-default"
								data-dismiss="modal">关闭</button>
						</div>
					</div>
			</div>
			</form>
		</div>
		<!-- /.modal-content -->
	</div>
	
	
	
	<!-- 审核 -->
	<div class="modal fade" tabindex="-1" role="dialog" id="myModal3">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="modal-title">审核</h4>
				</div>
				<form id="data3">
					<div class="modal-body">
						<input type="hidden" id="id2" name="id">
						<input id="userType2" type="hidden" value="${user.type }" name="userType">
						<input id="userId2"  type="hidden" value="${user.id }" name="userid">
						<div class="row">
							

							<div class="col-lg-12">
								<div class="form-group" lang="repairname">
									<label for="phone">维修名称：</label> <input type="text"
										class="form-control" name="repairname" id="repairname" placeholder="维修师傅名称"
										data-val="true" data-val-required="请填写 &#39;维修师傅名称&#39;。">
									<span class="field-validation-error" data-valmsg-for="repairname"
										data-valmsg-replace="true"></span>
								</div>
							</div>
						</div>
						<div class="modal-footer">
							<button type="button" class="btn btn-default"
								data-dismiss="modal">关闭</button>
							<button type="button" class="btn btn-primary" id="audit">保存</button>
						</div>
					</div>
			</div>
			</form>
		</div>
		<!-- /.modal-content -->
	</div>
	
	
	
	
	
	
	</div>
	<script type="text/javascript">
	
		var auditdata=[];
		function RefreshGridManagerList(keyword) {
			$(".table-div").remove();
			$(".page-toolbar").remove();
			$(".cls")
					.append('<table grid-manager="demo-ajaxPageCode"></table>');
			init(keyword);
		}
		var userType=$("#userType").val();
		if(userType==0){
			$("#user").hide();
			$("#userId").attr('name','userid');
		}
		$("#serach").click(
				function() {
					var keyword = $("#key").val();
					if (keyword != undefined && keyword != null
							&& keyword.trim() != "") {
						RefreshGridManagerList(keyword);
					}
				});
		$("#add").click(function() {
			if (!$('#data').valid()) {
				return;
			}
			layui.use('layer', function() {
				layer = layui.layer;
				var id = $("#id").val();
				var url;
				var msg;
				var data;
				if (id == "") {
					url = "repair/add";
					msg = "添加成功";
					data = $("#data").serialize();
				} else {
					url = "repair/update2";
					msg = "修改成功";
					data = $("#data").serialize() + "&id=" + id;
				}

				$.ajax({
					url : url,
					type : "POST",
					data : data,
					success : function(data) {
						$("#myModal").modal('hide');
						layer.msg(msg);
						$("#id").val("");
						document.getElementById("data").reset();
						RefreshGridManagerList("");
					}
				});
			});
		});

		//删除
		function deleteInfo(ob) {
			layui.use('layer', function() {
				layer = layui.layer;
				layer.confirm("确认要删除吗，删除后不能恢复", {
					title : "删除确认"
				}, function(index) {

					$.ajax({
						url : "repair/detele",
						type : "POST",
						data : {
							'id' : ob
						},
						success : function(data) {
							if (data == 'ok') {
								layer.msg('删除成功');
								RefreshGridManagerList("");
							}
						}
					});

					layer.close(index);

				});
				/* */
			})

		}

		//更新信息
		function updateInfo(id) {
			$.ajax({
				url : 'repair/findById',
				data : {
					'id' : id
				},
				typr : "post",
				success : function(data) {
					data = JSON.parse(data);
					for (k in data) {
						$("#" + k).val(data[k]);
					}
					$("#myModal").modal('show');
					$(".hiden").hide()
					$("span.field-validation-error").hide();
				}
			});
		}
		
		//查看
		function lookInfo(id) {
			$.ajax({
				url : 'repair/findById',
				data : {
					'id' : id
				},
				typr : "post",
				success : function(data) {
					data = JSON.parse(data);

					console.log(data)
					for (k in data) {
						$("#" + k+"1").val(data[k]);
					}
					$("#myModal2").modal('show');
					$(".hiden").hide()
					$("span.field-validation-error").hide();
				}
			});
		}
		
		
		//审核
		function auditInfo(id) {
			$.ajax({
				url : 'repair/findById',
				data : {
					'id' : id
				},
				typr : "post",
				success : function(data) {
					data = JSON.parse(data);
					auditdata=data;
					for (k in data) {
						$("#" + k+"2").val(data[k]);
					}
					$("#myModal3").modal('show');
					$(".hiden").hide()
					$("span.field-validation-error").hide();
				}
			});
		}
		
		
		$("#audit").click(function() {
			if (!$('#data3').valid()) {
				return;
			}
			layui.use('layer', function() {
				layer = layui.layer;
					url = "repair/update2";
					msg = "审核成功";
					auditdata.repairname=$("#repairname").val();
					delete auditdata.starttime;
					delete auditdata.endtime;
					
				$.ajax({
					url : url,
					type : "POST",
					data : auditdata,
					dataType : "json",
					success : function(data) {
						$("#myModal3").modal('hide');
						layer.msg(msg);
						$("#repairname").val("");
						document.getElementById("data3").reset();
						RefreshGridManagerList("");
					}
				});
			});
		});
		
		
		
	</script>
</body>
</html>