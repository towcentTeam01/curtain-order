<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<html>
<head>
    <title>订单详情</title>
    <meta name="decorator" content="default"/>

    <link rel="stylesheet" href="${ctxStatic}/layui/css/layui.css" media="all">
    <script src="${ctxStatic}/layui/layui.js" charset="utf-8"></script>

    <style>

        .box-content{
            padding: 2% 2% 1% 2%;
        }

        .carousel-img {
            width: 100%;
            border: 1px solid #fff;
            height: 302px;
            vertical-align: middle;
            text-align: center;
        }

        .carousel-img img {
            height: 300px;
        }

        .notice-list{
            border: 1px solid #ccc;
            margin: 1% 0;
            padding: 10px;
            display: grid;
            border-radius: 10px;
        }

        .notice-list ul li{
            clear: both;
            padding: 5px 0;
        }

        .notice-list ul li span.fl{
            float: left;
            width: 18%;
            overflow: hidden;
            text-overflow:ellipsis;
            white-space: nowrap;
        }

        .notice-list ul li span.min{
            float: left;
            width: 60%;
            overflow: hidden;
            text-overflow:ellipsis;
            white-space: nowrap;
        }

        .notice-list ul li span.fr{
            float: right;
        }

        .label-list ul li{
            width: 50%;
            display: inline-block;
            float: left;
            text-align: center;
            padding: 2% 0;
            font-size: 60px;
            font-weight: bold;
        }

        .label-list ul li a{
            color: #fff;
            width: 90%;
            display: inline-block;
            border: 1px solid #00a0e9;
            padding: 10% 0;
            border-radius: 10px;
            background-color: #00a0e9;
        }

        .label-list ul li a:hover, a:focus {
            text-decoration: none;
        }

    </style>

    <script>

        function goToBack() {
            window.location.href = '${ctx}/mall/order/list?orderType=1';
        }
        
    </script>

</head>
<body>
<div class="box-content">

    <div class="carousel-img">
        <div id="layer-photos-demo" class="layer-photos-demo">
            <div class="layui-carousel" id="test1" lay-filter="test1">
                <div carousel-item="">
                    <c:forEach items="${carouselList}" var="item" varStatus="va">
                        <div>
                            <img layer-pid="${va.index}" layer-src="${item.url}" src="${item.url}" alt="图片${va.index}">
                        </div>
                    </c:forEach>
                </div>
            </div>
        </div>
    </div>

    <div class="notice-list">
        <ul>
            <c:forEach items="${noticeList}" var="item" varStatus="va">
                <li>
                    <span class="fl">${item.title}</span>
                    <span class="min">${item.content}</span>
                    <span class="fr"><fmt:formatDate value="${item.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/></span>
                </li>
            </c:forEach>
        </ul>
    </div>

    <div class="label-list">
        <ul>
            <c:forEach items="${dictDtls}" var="item" varStatus="va">
                <li><a href="${ctx}/mall/goods/list?labelType=${item.code}">${item.name}</a></li>
            </c:forEach>
        </ul>
    </div>

</div>

<script type="text/javascript">
    layui.use(['carousel'], function () {
        var carousel = layui.carousel;

        //常规轮播
        carousel.render({
            elem: '#test1'
            , arrow: 'none'
            , width: '100%'
            , height: '300px'
            , interval: 5000
        });
    });
</script>

</body>
</html>