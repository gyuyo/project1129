<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>${pageTitle }</title>
<!-- 테일윈드CSS -->
<script src="https://cdn.tailwindcss.com"></script>
<!-- daisy UI -->
<link
	href="https://cdn.jsdelivr.net/npm/daisyui@4.12.14/dist/full.min.css"
	rel="stylesheet" type="text/css" />
<!-- JQuery -->
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<!-- 폰트어썸 -->
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.6.0/css/all.min.css" />
<!-- common css -->
<link rel="stylesheet" href="/resource/common.css" />

</head>
<body class="header min-h-screen flex flex-col bg-black text-white">
	<div class="h-20 flex container mx-auto text-3xl">
		<div>
			<div class="tooltip tooltip-bottom mt-4 text-3xl  ml-12" data-tip="LOGO">
				<a class="h-full px-3 flex items-center" href="${pageContext.request.contextPath}/">
					<button class="btn bg-black text-white hover:bg-gray-800 border-0 text-3xl"><i class="fa-regular fa-face-smile"></i></button>
				</a>
			</div>
		</div>
		<div class="grow"></div>
		<ul class="flex">
			<li>
				<div class="tooltip tooltip-bottom mt-4" data-tip="HOME">
					<a class="h-full px-3 flex items-center" href="${pageContext.request.contextPath}/">
						<button class="btn bg-black text-white hover:bg-gray-800 border-0">
							<i class="fa-solid fa-house text-2xl p-2"></i>
						</button>
					</a>
				</div>
			</li>
			<li>
				<div class="dropdown">
  					<div tabindex="0" role="button" class="btn mt-4 bg-black text-white hover:bg-gray-800 border-0"><i class="fas fa-bars text-2xl p-2"></i></div>
						<ul	tabindex="0" class="menu dropdown-content bg-black rounded-box z-[1] w-52 p-2 shadow">
							<li>
								<div class="hover:bg-gray-800">
									<a href="${pageContext.request.contextPath}/usr/article/list?boardId=1">
										<button>NOTICE</button>
									</a>
								</div>
							</li>
							<li>
								<div class="hover:bg-gray-800">
									<a href="${pageContext.request.contextPath}/usr/article/list?boardId=2">	
										<button>FREE</button>
									</a>
								</div>
							</li>
						</ul>
					</div>
			<c:if test="${rq.getLoginedMemberId() == -1 }">
				<li>
					<div class="tooltip tooltip-bottom mt-4" data-tip="LOGIN">
						<a class="h-full px-3 flex items-center" href="${pageContext.request.contextPath}/usr/member/login">
							<button	class="btn bg-black text-white hover:bg-gray-800 border-0">LOGIN</button>
						</a>
					</div>
				</li>
				<li>
					<div class="tooltip tooltip-bottom mt-4" data-tip="JOIN">
						<a class="h-full px-3 flex items-center" href="${pageContext.request.contextPath}/usr/member/join">
							<button	class="btn bg-black text-white hover:bg-gray-800 border-0">JOIN</button>
						</a>
					</div>
				</li>
			</c:if>
			<c:if test="${rq.getLoginedMemberId() != -1 }">
				<li>
					<div class="tooltip tooltip-bottom mt-4" data-tip="LOGOUT">
						<a class="h-full px-3 flex items-center" href="${pageContext.request.contextPath}/usr/member/doLogout">
							<button	class="btn bg-black text-white hover:bg-gray-800 border-0">LOGOUT</button>
						</a>
					</div>
				</li>
			</c:if>
		</ul>
	</div>

	<section class="my-4 text-2xl">
		<div class="container w-9/12 mx-auto">
			<div>${pageTitle }</div>
		</div>
	</section>