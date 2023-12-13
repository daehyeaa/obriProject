<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<style>
    .sidebar {
        height: 100%;
        position: fixed;
        bottom: 0;
        background-color: #A490D5; /* Purple background color */
    }

    .end {
        margin-top: 260px;
    }

    /* Add additional styles as needed */
    .nav-link {
        color: #A490D5;
    }

    .nav-link:hover {
        background-color: #816bc7; /* Darker purple on hover */
        color: #fff;
    }

    .sidebar hr {
        border-color: #816bc7; /* Border color for horizontal rule */
    }

    .nav-item.active {
        background-color: #816bc7; /* Darker purple for active item */
    }

    .nav-item.mt-auto a {
        color: #D3D3D3; /* Light gray text color for logout link */
    }

    .nav-item.mt-auto a:hover {
        color: #fff; /* White text color on hover for logout link */
    }
</style>

<div class="sidebar border border-right col-md-3 col-lg-2 p-0 bg-body-tertiary">
	<div class="offcanvas-md offcanvas-end bg-body-tertiary" tabindex="-1"
		id="sidebarMenu" aria-labelledby="sidebarMenuLabel">
		<div
			class="offcanvas-body d-md-flex flex-column p-0 pt-lg-3 overflow-y-auto">
			<span class="fs-4 sidebar-heading">관리자 페이지</span>
			<hr>
			<ul class="nav flex-column">
				<li class="nav-item"><a
					class="nav-link d-flex align-items-center gap-2"
					href="admin_notice.do"> 공지사항 </a></li>
				<li class="nav-item"><a
					class="nav-link d-flex align-items-center gap-2"
					href="admin_qna.do"> 문의 </a></li>
				<li class="nav-item"><a
					class="nav-link d-flex align-items-center gap-2"
					href="admin_memberlist.do"> 회원관리 </a></li>
			</ul>

			<h6
				class="sidebar-heading d-flex justify-content-between align-items-center px-3 mt-4 mb-1 text-body-secondary text-uppercase">
				<span><b>게시판관리</b></span>
			</h6>
			<ul class="nav flex-column mb-auto">
				<li class="nav-item"><a
					class="nav-link d-flex align-items-center gap-2"
					href="admin_job.do">구인 </a></li>
				<li class="nav-item"><a
					class="nav-link d-flex align-items-center gap-2" href="admin_pr.do">홍보
				</a></li>
				<li class="nav-item"><a
					class="nav-link d-flex align-items-center gap-2"
					href="admin_comm.do">커뮤니티 </a></li>
			</ul>
			<div class="end">
				<hr class="my-3" id="bottom">

				<ul class="nav flex-column">
					<li class="nav-item mt-auto"><a
						class="nav-link d-flex align-items-center gap-2"
						href="admin_logout.do"> 로그아웃 </a></li>
				</ul>
			</div>
		</div>
	</div>
</div>
