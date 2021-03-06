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
<script src="resource/js/jquery.min.js"></script>
<script src="resource/js/jquery.validate.min.js"></script>
<script src="resource/js/jquery.validate.unobtrusive.min.js"></script>
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
	})

	function init(keyword) {
		var table = document
				.querySelector('table[grid-manager="demo-ajaxPageCode"]');
		table
				.GM({
					ajax_url : 'complaint/list',
					ajax_type : 'POST',
					query : {
						pluginId : 1,
						'keyword' : keyword
					},
					supportAjaxPage : true,
					supportCheckbox : false,
					columnData : [
							
							{
								key : 'userName',
								text : '投诉用户'
							},
							{
								key : 'time',
								text : '投诉时间'
							},
							{
								key : 'content',
								text : '投诉内容'
							},
							{
								key : 'isReplay',
								text : '是否回复',
								remind : 'the action',
								template : function(action, rowObject) {
									if(rowObject.isReplay==0){
										return "待回复";
									}else{
										return "已回复";
									}
								}
							},
							{
								key : 'reply',
								text : '回复内容'
							},
							{
								key : 'action',
								remind : 'the action',
								width : '100px',
								text : '操作',
								template : function(action, rowObject) {
									return '<a style="color:#337ab7;" href="javascript:;" onclick="updateInfo(\''
											+ rowObject.id + '\')">回复</a>';
								}
							} ]

				});
	}
</script>
</head>
<body style="margin: 20px">
	<div class="row">
		<div class="col-md-10">
			<h3>投诉列表</h3>
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
					<h4 class="modal-title">添加投诉</h4>
				</div>
				<form id="data">
					<div class="modal-body">
						<input type="hidden" id="id">
						<div class="row">
							<div class="col-lg-12">
								<div class="form-group">
									<label for="content">回复内容：</label>
									<textarea class="form-control" rows="6" cols="" name="reply"
										id="reply" data-val="true"
										data-val-required="请填写 &#39;回复内容&#39;。"></textarea>
									<span class="field-validation-error" data-valmsg-for="reply"
										data-valmsg-replace="true"></span>
								</div>
							</div>
							<div class="modal-footer">
								<button type="button" class="btn btn-default"
									data-dismiss="modal">关闭</button>
								<button type="button" class="btn btn-primary" id="add">保存</button>
							</div>
				</form>
			</div>
			<!-- /.modal-content -->
		</div>
	</div>
	<script type="text/javascript">
		function RefreshGridManagerList(keyword) {
			$(".table-div").remove();
			$(".page-toolbar").remove();
			$(".cls")
					.append('<table grid-manager="demo-ajaxPageCode"></table>');
			init(keyword);
		}
		$("#serach").click(
				function() {
					var keyword = $("#key").val();
					if (keyword != undefined && keyword != null
							&& keyword.trim() != "") {
						RefreshGridManagerList(keyword);
					}
				});
		$("#add")
				.click(
						function() {
							if (!$('#data').valid()) {
								return;
							}
							layui
									.use(
											'layer',
											function() {
												layer = layui.layer;
												var id = $("#id").val();
												var url;
												var msg;
												var data;
												if (id == "") {
													url = "complaint/add";
													msg = "添加成功";
													data = $("#data")
															.serialize();
												} else {
													url = "complaint/repaly";
													msg = "修改成功";
													data = $("#data")
															.serialize()
															+ "&id=" + id;
												}

												$.ajax({
															url : url,
															type : "POST",
															data : data,
															success : function(
																	data) {
																if (data === "error") {
																	layer
																			.msg("请先登录");
																	window.parent.location.href = "/HouseManager/user/toLogin";
																} else {
																	$(
																			"#myModal")
																			.modal(
																					'hide');
																	layer
																			.msg(msg);
																	$("#id")
																			.val(
																					"");
																	document
																			.getElementById(
																					"data")
																			.reset();
																	RefreshGridManagerList("");
																}
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
						url : "complaint/detele",
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
				url : 'complaint/findById',
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
	</script>
</body>
</html>