# 自定义博客园
## 页面定制 CSS 代码 
```
/*博客主题美化教程：  
                                AnotherEon001主题：
                                     https://www.cnblogs.com/shwee/p/9060226.html#shwtop
                                     https://www.cnblogs.com/shwee/p/9084535.html#dingzhi3
                                     https://zhuanlan.zhihu.com/p/56547307
                                     https://www.jianshu.com/p/23b2bfc9a90d
                                     https://segmentfault.com/a/1190000013001367    //markdown代码高亮

                                LessIsMore主题：
                                     https://www.cnblogs.com/JetpropelledSnake/p/9090675.html#top

                                red_autumnal_leaves （红叶）主题：
                                     https://www.cnblogs.com/real-me/p/8336741.html?spm=a2c4e.11153940.blogcont607419.6.7ab068aei11PaC
*/

#header{display:none;} /* 将默认的导航头屏蔽掉，这样才能把自己的导航栏加上去 */

/* 将默认页面保持最大，效果如点击变大MAX */
#main_container{margin-left:-195px;}  
#leftmenu{display:none;}


/*  定制自己导航栏的样式 */
#shwtop ul {
    margin: 0;
    padding: 0;
    list-style-type: none; /*去除li前的标注*/
    background-color: #5f5a4b;
    overflow: hidden; /*隐藏溢出的部分，保持一行*/
}
#shwtop li {
    float: left; /*左浮动*/
}
#shwtop li a, .dropbtn {
    display: inline-block; /*设置成块*/
    color: white;
    text-align: center;
    text-decoration: none;
    padding: 14px 16px;
}
/*鼠标移上去，改变背景颜色*/
#shwtop li a:hover, .dropdown:hover .dropbtn { 
    /* 当然颜色你可以自己改成自己喜欢的 */
    background-color: #5F9EA0;
}
#shwtop .dropdown {
    /*
    display:inline-block将对象呈递为内联对象，
    但是对象的内容作为块对象呈递。
    旁边的内联对象会被呈递在同一行内，允许空格。
    */
    display: inline-block;
}
#shwtop .dropdown-content {
    display: none;
    position: absolute;
    background-color: #FFF5EE; /*导航栏下拉中整体的颜色*/
    min-width: 160px;
    box-shadow: 0px 8px 16px 0px rgba(255,102,0,0.2); /*下拉块中阴影颜色*/
}
#shwtop .dropdown-content a {
    display: block;
    color: yellowgreen;
    padding: 8px 10px;
    text-decoration: underline;
}
#shwtop .dropdown-content a:hover {
    background-color: #68821a; /*每一个下拉块中鼠标移动的颜色*/
    text-decoration: none;
}
#shwtop .dropdown:hover .dropdown-content{
    display: block;
}

/* 定制生成博客目录的CSS样式 */
#uprightsideBar{
    font-size:16px;
    font-family:Arial, Helvetica, sans-serif;
    text-align:left;
    position:fixed;
    /*
    将div的位置固定到距离top:150px，right:0px的位置，
    这样div就会处在最右边的位置，距离顶部150px，
    当然这两个值你可以自己改。
    */
    top:150px;
    right:0px;
    width: auto;
    height: auto; 
}
#sideBarTab{
    float:left;
    width:25px; 
    box-shadow: 0 0 8px #877788;
    border:1px solid #00DDC00;
    border-right:none;
    text-align:center;
    background:rgb(0, 220, 0);
}
#sideBarContents{
    float:left;
    overflow:auto; 
    overflow-x:hidden;!important;
    width:200px;
    min-height:101px;
    max-height:460px;
    border:1px solid #3fb33c;
    border-right:none; 
    background:#edd41b;
}
#sideBarContents dl{
    margin:0;
    padding:0;
}
#sideBarContents dt{
    margin-top:5px;
    margin-left:5px;
}
#sideBarContents dd, dt {
    cursor: pointer;
}
#sideBarContents dd:hover, dt:hover {
    color:#A7995A;
}
#sideBarContents dd{
    margin-left:20px;
}

/* 定制推荐和反对按键 */
/*
#div_digg{
  position:fixed;
  bottom:-10px;
  width:120px;
  right:20px;
  box-shadow: 0 0 6px #0000FF;
  border:2px solid #FF0000;
  padding:4px;
  background-color:#fff;
  border-radius:4px 4px 4px 4px !important;
}
*/

.icon_favorite {
    background: transparent url('http://images.cnblogs.com/cnblogs_com/shwee/1218109/o_kj.gif') no-repeat 0 0;
    padding-left: 15px;
}

#blog_post_info_block a {
    text-decoration: none;
    color: #5B9DCA;
    padding: 3px;
}

/* 定制返回顶部按键；url中为图标地址 */
#toTop {
    /* background: url(https://img.alicdn.com/tfs/TB1KVXzXaigSKJjSsppXXabnpXa-88-88.png) no-repeat 0px top; */
    /* 图片像素大小应为48x48，以便适应大小 */
    background: url(https://images.cnblogs.com/cnblogs_com/yusq77/1461186/o_191224072939top48.png) no-repeat center;
    width: 48px;  /* width, height 应该比48x48 更小，才能包括整个图片 */
    height: 48px;
    border-radius:48px;   /* 圆形显示 */
    overflow: hidden;
    position: fixed;
    right: 75px;  /* 距离最右边 65px */
    bottom: 20px; /* 距离最底部20， 移动right, bottom 可使返回图标移动到指定位置 */
    cursor: pointer;
    border: #ccc 1px solid;
    /* background-color: #68228B */
}

.icon-top {
    background: url(https://images.cnblogs.com/cnblogs_com/yusq77/1461186/o_191224072939top48.png) no-repeat center #fff;
    background-size: 48px;
    width: 48px;
    height: 48px;
    position: fixed;
    right: 70px;
    /* bottom: 10%; */
   bottom: 20px; /* 距离最底部20， 移动right, bottom 可使返回图标移动到指定位置 */
    opacity: 1;
    transition: all 0.3s;
    z-index: 9999999;
    border: #ccc 1px solid;
    border-radius: 100%;
}

.icon-top.cd-is-visible { 
    visibility: visible; 
    opacity: 1; 
}


/* 定制页面扩大按键 */
#divExpandViewArea{
    position: fixed;
    color: white;
    padding: 10px 10px;
    left: 0px;
    top: 400px;
    cursor: pointer;
    opacity: 0.9;
    background-color: #68228B;
}
/* 定制页面缩小按键 */
#divCollapseViewArea{
    position: fixed;
    color: white;
    padding: 10px 10px;
    left: 0px;
    top: 445px;
    cursor: pointer;
    opacity: 0.9;
    background-color: #68228B;
}

/* 定制公告栏文字信息 */
.gonggao{
    text-align: center;
    font-size:17px;
    color:blue;
}
.wenzi{
    text-align: center;
    font-size:15px;
}

/* 定制公告栏时钟位置 */
#clockdiv {
    /* left, center, right */
    text-align: center;
}

/* 定制左侧随笔分类上下项之间的间距，左侧随笔分类显示有多少项，你就在后面增加多少项 */
/* begin
#CatList_LinkList_0_Link_0{
}
#CatList_LinkList_0_Link_1{
    margin-top:10px;
}
#CatList_LinkList_0_Link_2{
    margin-top:10px;
}
#CatList_LinkList_0_Link_3{
    margin-top:10px;
}
#CatList_LinkList_0_Link_4{
    margin-top:10px;
}
#CatList_LinkList_0_Link_5{
    margin-top:10px;
}
#CatList_LinkList_0_Link_6{
    margin-top:10px;
}
#CatList_LinkList_0_Link_7{
    margin-top:10px;
}
#CatList_LinkList_0_Link_8{
    margin-top:10px;
}
#CatList_LinkList_0_Link_9{
    margin-top:10px;
}
#CatList_LinkList_0_Link_10{
    margin-top:10px;
}
#CatList_LinkList_0_Link_11{
    margin-top:10px;
}
#CatList_LinkList_0_Link_12{
    margin-top:10px;
}
#CatList_LinkList_0_Link_13{
    margin-top:10px;
}
#CatList_LinkList_0_Link_14{
    margin-top:10px;
}
end */

/* 设置签名格式 定制css样式 */
#MySignature {
    display: none;
    background-color: #B2E866;
    border-radius: 10px;
    box-shadow: 1px 1px 1px #6B6B6B;
    padding: 10px;
    line-height: 1.5;
    text-shadow: 1px 1px 1px #FFF;
    font-size: 16px;
    font-family: 'Microsoft Yahei';
}

/* 不显示底部广告*/
#ad_t2,#cnblogs_c1,#under_post_news,#cnblogs_c2,#under_post_kb {
    display:none; !important
}

#blogTitle h1 a {
    color: rgb(255, 102, 0);  
    font: 0.875em/1.5em "微软雅黑" , "PTSans" , "Arial" ,sans-serif;
    font-size: 50px;
}
/*文章内容详情页面的标h2、h3的样式*/
#cnblogs_post_body
{
    color: black;      
    font: 0.875em/1.5em "微软雅黑" , "PTSans" , "Arial" ,sans-serif;
    font-size: 15px;
}
/* 各个等级标题的颜色样式*/
#cnblogs_post_body h1    {
    background: #2B6695;
    border-radius: 6px 6px 6px 6px;
    box-shadow: 0 0 0 1px #5F5A4B, 1px 1px 6px 1px rgba(10, 10, 0, 0.5);
    color: #FFFFFF;
    font-family: "微软雅黑" , "宋体" , "黑体" ,Arial;
    font-size: 23px;
    font-weight: bold;
    height: 25px;
    line-height: 25px;
    margin: 18px 0 !important;
    padding: 8px 0 5px 5px;
    text-shadow: 2px 2px 3px #222222;
}

/* 鼠标移动到h2、h3、h4文字时变橙色 */
#cnblogs_post_body h2:hover {
    color: rgb(255, 102, 0);
}
#cnblogs_post_body h3:hover {
    color: rgb(255, 102, 0);
}
#cnblogs_post_body h4:hover {
    color: rgb(255, 102, 0);
}

#cnblogs_post_body h2 {
    display: block;
    font-weight: 300;
    background-image: linear-gradient(to right,#fff, #8BC34A, #4CAF50,#4CAF50,#4CAF50, #8BC34A, #FFF);
    background-color: #4CAF50;
    color: #FFF;
    font-size: 1.4em;
    line-height: 2em;
    margin: 14px 10px;
    padding: 10px 0;
    letter-spacing: 2px;
    text-shadow: 1px 1px 1px #666;
    text-align: center;

/*
    background: #008EB7;
    border-radius: 6px 6px 6px 6px;
    box-shadow: 0 0 0 1px #5F5A4B, 1px 1px 6px 1px rgba(10, 10, 0, 0.5);
    color: #FFFFFF;
    font-family: "微软雅黑" , "宋体" , "黑体" ,Arial;
    font-size: 17px;
    font-weight: bold;
    height: 25px;
    line-height: 25px;
    margin: 18px 0 !important;
    padding: 8px 0 5px 5px;
    text-shadow: 2px 2px 3px #222222;
*/

}
#cnblogs_post_body h3 {
    display: block;
    font-weight: 200;
    background-image: linear-gradient(to right,#4CAF50, #8BC34A, #8BC34A, #FFF);
    background-color: #4CAF50;
    color: #FFF;
    font-size: 1.2em;
    line-height: 2em;
    margin: 10px 12px 10px 0;
    padding: 8px 10px 8px 15px;
    letter-spacing: 2px;
    border-left: solid #333 6px;
    text-shadow: 1px 1px 1px #666;

/*
    background: #2B6600;
    border-radius: 6px 6px 6px 6px;
    box-shadow: 0 0 0 1px #5F5A4B, 1px 1px 6px 1px rgba(10, 10, 0, 0.5);
    color: #FFFFFF;
    font-family: "微软雅黑" , "宋体" , "黑体" ,Arial;
    font-size: 13px;
    font-weight: bold;
    height: 24px;
    line-height: 23px;
    margin: 12px 0 !important;
    padding: 5px 0 5px 10px;
    text-shadow: 2px 2px 3px #222222;
*/
}
#cnblogs_post_body h4 {
    background: #40E0D0;
    border-radius: 6px 6px 6px 6px;
    box-shadow: 0 0 0 1px #5F5A4B, 1px 1px 6px 1px rgba(10, 10, 0, 0.5);
    color: #FFFFFF;
    font-family: "微软雅黑" , "宋体" , "黑体" ,Arial;
    font-size: 11px;
    font-weight: bold;
    height: 22px;
    line-height: 21px;
    margin: 12px 0 !important;
    padding: 5px 0 5px 10px;
    text-shadow: 2px 2px 3px #222222;
}

/* 公告栏日历样式设置 */
.Cal {
    border: 1px solid #F5F5F5;
    width: 190px;   /*日历宽度*/
    font-family: Arial;
    font-size: 13px;
    margin-top: 10px;
    margin-bottom: 10px;
    height: 180px;
    background-color: #F5F5F5;   /*日历背景颜色*/
    margin-left: 0;
}
/*日历的第一行标题  年份/月份这一栏配置*/
.CalTitle {
    background-color: #F5F5F5;
    border-color: #adf;
    font-family: Arial;
    font-size: 14px;
    color: #000;
    margin-left: 0;
    padding: 0;
    height: 100%;
    font-weight: bold;
}
/*日历的第二行  星期信息这一行配置*/
.CalDayHeader {
    background-color: #F5F5F5;
}

/* 定制博客背景（壁纸）图片，url里面是你的图片位置信息 */
body { 
     background-color: #efefef;
     background-image:url(https://images.cnblogs.com/cnblogs_com/yusq77/1458740/o_post-bg-2019-04-18.jpg);
     /* background-image:url(https://www.cnblogs.com/images/cnblogs_com/yusq77/1458740/o_post-bg-2019-04-24.jpg);  */
     background-repeat: no-repeat; 
     background-attachment: fixed; 
     background-position: center 0; 
     background-size: cover; 
    padding-top:0px;
  }

/* 定制公告栏音乐插件的样式 */
.aplayer {
    font-family: Arial,Helvetica,sans-serif;  /*音乐插件字体*/
    margin: 0px;  /*音乐插件与公告栏左边的边距，0px就是直接抵到公告栏左边的边上*/
    box-shadow: 0 2px 2px 0 rgba(0,0,0,.14), 0 3px 1px -2px rgba(0,0,0,.2), 0 1px 5px 0 rgba(0,0,0,.12);
    border-radius: 2px;
    overflow: hidden;
    -webkit-user-select: none;
    -moz-user-select: none;
    -ms-user-select: none;
    user-select: none;
    line-height: normal;
}

/* 修改博客首页标题内容显示 */
a {
    color: #5F9EA0;
    text-decoration: none;
}
/* 修改博客首页内容显示 */
.c_b_p_desc {
    word-wrap: break-word;
    word-break: break-all;
    overflow: hidden;
    font-style: italic;
    line-height: 1.5;
}

/* 边栏显示 */
#leftmenu h3 {
    font-size: 20px;
    margin: 0;
    padding: 10px 0 10px 24px;
    background-color: #f7f7f7;
    border-left: 10px solid #FF9933;
    font-weight: bold;
    line-height: 1.2;
    border-bottom: 1px solid #bbb;
}

/*
使用了Monokai Sublime的黑色主题皮肤，但是还存在样式冲突，需要自己修改
这个样式只适合使用makedown编写的博客
Monokai Sublime style. Derived from Monokai by noformnocontent http://nn.mit-license.org/
*/

pre {
    /*控制代码不换行*/
    white-space: pre;
    word-wrap: normal;
}

.cnblogs-markdown .hljs {
    display: block;
    overflow: auto;
    padding: 1.3em 2em !important;
    font-size: 16px !important;
    background: #272822 !important;
    color: #FFF;
    max-height: 700px;
}

.hljs,
.hljs-tag,
.hljs-subst {
    color: #f8f8f2;
}

.hljs-strong,
.hljs-emphasis {
    color: #a8a8a2;
}

.hljs-bullet,
.hljs-quote,
.hljs-number,
.hljs-regexp,
.hljs-literal,
.hljs-link {
    color: #ae81ff;
}

.hljs-code,
.hljs-title,
.hljs-section,
.hljs-selector-class {
    color: #a6e22e;
}

.hljs-strong {
    font-weight: bold;
}

.hljs-emphasis {
    font-style: italic;
}

.hljs-keyword,
.hljs-selector-tag,
.hljs-name,
.hljs-attr {
    color: #f92672;
}

.hljs-symbol,
.hljs-attribute {
    color: #66d9ef;
}

.hljs-params,
.hljs-class .hljs-title {
    color: #f8f8f2;
}

.hljs-string,
.hljs-type,
.hljs-built_in,
.hljs-builtin-name,
.hljs-selector-id,
.hljs-selector-attr,
.hljs-selector-pseudo,
.hljs-addition,
.hljs-variable,
.hljs-template-variable {
    color: #e6db74;
}

.hljs-comment,
.hljs-deletion,
.hljs-meta {
    color: #75715e;
}

/* 黑色主题makedown代码结束 */
/*makedown行间代码样式 */
.cnblogs-markdown code {
    color: #c7254e;
    border: none !important;
    font-size: 1em !important;
    background-color: #f9f2f4 !important;
    font-family: sans-serif !important;
}

/* 每日一句 */
#right_site_articles {
    margin-bottom: 8px;
    padding-top: 10px;
    padding-bottom: 2px;
    background-color:#f3f1c4;
    box-shadow: 0 4px 10px rgba(0,0,0,.1);
    font-size: 12px;
}
.article-part-title {
    margin-right: 6px;
    margin-left: 6px;
    padding-bottom: 5px;
    padding-left: 5px;
    border-bottom: 1px solid #e3e3e3;
    color: #000;
    font-weight: 700;
    font-size: 18px;
}
.article-part-title span {
    display: inline-block;
    text-decoration: none;
}
#right_site_articles ul {
    margin-right: 6px;
    margin-left: 10px;
}

/* linux.cn */
#cnblogs_post_body blockquote 
{
    margin: 20px;
    background-color: rgba(235,235,235,0.5);
    padding: 3px 10px;
    border-radius: 17px 0;
    border-left: 7px solid #0a0;
    border-right: 7px solid #0a0;
}

/* https://www.cnblogs.com/winton-nfs/p/12956811.html 鼠标移动动画 */
canvas#live2dcanvas {
border: 0 !important;
right: 0;
}
```

## 页首 HTML 代码 
```
<!-- <div id="blog_nav_admin" style="display:none"> </div> -->

<!--
<p class="gonggao"><a style="color: blue;font-weight: bold;" href="http://www.cnblogs.com/shwee/p/9056959.html">我的博客目录结构</a></p>
 <p class="wenzi">一个不像技术博客的博客</p>
<p>-------------------------</p>  
-->
<div id="right_site_articles" >
    <div class="article-part-title">
        <span>每日一句</span>
    </div>
    <ul class="side_article_list">
    	活在现在，享受当下。
    </ul>
</div>




</br>  <!--  换行显示更美观 -->
<!-- 添加公告栏时钟 -->
<div id="clockdiv">
    <canvas id="dom" width="120" height="120">时钟canvas</canvas>
</div>
<script type="text/javascript" src="https://files.cnblogs.com/files/shwee/clock.js"></script>
</br>  <!--  换行显示更美观 -->


<!-- 为页面添加爱心特效，换成blogs爱心代码，加载速度加快 -->
<!-- https://www.cnblogs.com/chendada/p/12454639.html -->
<script type="text/javascript">

(function(window,document,undefined){
    var hearts = [];
    
    window.requestAnimationFrame = (function(){
        return window.requestAnimationFrame || 
        window.webkitRequestAnimationFrame ||
        window.mozRequestAnimationFrame ||
         window.oRequestAnimationFrame ||
         window.msRequestAnimationFrame ||
         function (callback){
             setTimeout(callback,1000/60);
         }
    })();
    
    init();

    function init(){
        css(".heart{width: 10px;height: 10px;position: fixed;background: #f00;transform: rotate(45deg);-webkit-transform: rotate(45deg);-moz-transform: rotate(45deg);}.heart:after,.heart:before{content: '';width: inherit;height: inherit;background: inherit;border-radius: 50%;-webkit-border-radius: 50%;-moz-border-radius: 50%;position: absolute;}.heart:after{top: -5px;}.heart:before{left: -5px;}");
        attachEvent();
        gameloop();
    }

    function gameloop(){
        for(var i=0;i<hearts.length;i++){
            if(hearts[i].alpha <=0){
                document.body.removeChild(hearts[i].el);
                hearts.splice(i,1);
                continue;
             }

             hearts[i].y--;
             hearts[i].scale += 0.004;
             hearts[i].alpha -= 0.013;
             hearts[i].el.style.cssText = "left:"+hearts[i].x+"px;top:"+hearts[i].y+"px;opacity:"+hearts[i].alpha+";transform:scale("+hearts[i].scale+","+hearts[i].scale+") rotate(45deg);background:"+hearts[i].color;
        }

        requestAnimationFrame(gameloop);
    }

    function attachEvent(){
        var old = typeof window.onclick==="function" && window.onclick;
        window.onclick = function(event){
            old && old();
            createHeart(event);
        }
    }

    function createHeart(event){
        var d = document.createElement("div");
        d.className = "heart";
        hearts.push({
            el : d,
            x : event.clientX - 5,
            y : event.clientY - 5,
            scale : 1,
            alpha : 1,
            color : randomColor()
        });

        document.body.appendChild(d);
    }

    function css(css){
        var style = document.createElement("style");
        style.type="text/css";
        try{
            style.appendChild(document.createTextNode(css));
        }
        catch(ex){
            style.styleSheet.cssText = css;
        }

        document.getElementsByTagName('head')[0].appendChild(style);
    }

    function randomColor(){
        return "rgb("+(~~(Math.random()*255))+","+(~~(Math.random()*255))+","+(~~(Math.random()*255))+")";
    }
    
})(window,document);
</script>

<!-- 在公共栏添加"站点统计"功能 -->
<!--
<div>
<a href="https://info.flagcounter.com/Mywu"><img src="https://s11.flagcounter.com/count2/Mywu/bg_FFFFFF/txt_000000/border_CCCCCC/columns_2/maxflags_10/viewers_0/labels_0/pageviews_0/flags_0/percent_0/" alt="Flag Counter" border="0"></a>
<div>
-->

<!-- 为博客底部添加音乐组件，内网限制，所以去掉 -->
<!--
<div id="player"  class="aplayer"></div>
<link href="https://files.cnblogs.com/files/yusq77/APlayer.min_v1.10.1.css" rel="stylesheet">
<script src="https://files.cnblogs.com/files/yusq77/APlayer.min_v1.10.1.js"></script> 
-->

<!--
<script type="text/javascript">
var ap = new APlayer({
    element: document.getElementById('player'),
    narrow: false,
    autoplay: false,          <!-- 是否自动播放 -->
    showlrc: false,
    loop: 'one',
    listFolded: true,
    theme: '#FFA500',      <!-- 插件背景（如音量柱）颜色，建议和你的公告栏背景色一样，这样融为一体的感觉 -->
    music: [{
            title: '夜色钢琴曲',
            author: '赵海洋',
            url: 'https://files.cnblogs.com/files/shwee/%E8%B5%B5%E6%B5%B7%E6%B4%8B-%E3%80%8A%E7%9E%AC%E9%97%B4%E7%9A%84%E6%B0%B8%E6%81%92%E3%80%8B%E5%A4%9C%E8%89%B2%E9%92%A2%E7%90%B4%E6%9B%B2.pdf',
            pic: 'http://images.cnblogs.com/cnblogs_com/shwee/1218109/o_music_pic2.png'
        },
        {
            title: 'A Little Story',
            author: 'Valentin',
            url: 'https://files.cnblogs.com/files/shwee/Valentin-A_Little_Story.pdf',
            pic: 'http://images.cnblogs.com/cnblogs_com/shwee/1218109/o_music_pic4.png'
        },
        {
            title: '琵琶语',
            author: '林海',
            url: 'https://files.cnblogs.com/files/shwee/%E6%9E%97%E6%B5%B7-%E7%90%B5%E7%90%B6%E8%AF%AD.pdf',
            pic: 'http://images.cnblogs.com/cnblogs_com/shwee/1218109/o_music_pic1.png'
        }
    ]
});
ap.init();
</script>
</br> 
-->
```

## 页脚 HTML 代码 

### 增加目录
```
<script type="text/javascript">
/* 生成博客目录的JS代码，两级目录
    这段代码按H2、H3格式生成两级菜单
    写博客按H2、H3格式写，不然生成不了
    Markdown写作按##、###两级目录写
    当然你也可以改写代码成三级菜单
*/

var BlogDirectory = {
    /* 获取元素位置，距浏览器左边界的距离（left）和距浏览器上边界的距离（top）*/
    getElementPosition:function (ele) {
        var topPosition = 0;
        var leftPosition = 0;
        while (ele){
            topPosition += ele.offsetTop;
            leftPosition += ele.offsetLeft;
            ele = ele.offsetParent;
        }
        return {top:topPosition, left:leftPosition};
    },
    /*获取滚动条当前位置 */
    getScrollBarPosition:function () {
        var scrollBarPosition = document.body.scrollTop || document.documentElement.scrollTop;
        return  scrollBarPosition;
    },
    /* 移动滚动条，finalPos 为目的位置，internal 为移动速度 */
    moveScrollBar:function(finalpos, interval) {
        //若不支持此方法，则退出
        if(!window.scrollTo) {
            return false;
        }
        
        //窗体滚动时，禁用鼠标滚轮
        window.onmousewheel = function(){
            return false;
        };
        
        //清除计时
        if (document.body.movement) {
            clearTimeout(document.body.movement);
        }
        
        //获取滚动条当前位置
        var currentpos =BlogDirectory.getScrollBarPosition();

        var dist = 0;
        //到达预定位置，则解禁鼠标滚轮，并退出
        if (currentpos == finalpos) {
            window.onmousewheel = function(){
                return true;
            }
            return true;
        }
        //未到达，则计算下一步所要移动的距离
        if (currentpos < finalpos) {
            dist = Math.ceil((finalpos - currentpos)/10);
            currentpos += dist;
        }
        if (currentpos > finalpos) {
            dist = Math.ceil((currentpos - finalpos)/10);
            currentpos -= dist;
        }

        var scrTop = BlogDirectory.getScrollBarPosition();//获取滚动条当前位置
        window.scrollTo(0, currentpos);//移动窗口
        if(BlogDirectory.getScrollBarPosition() == scrTop)//若已到底部，则解禁鼠标滚轮，并退出
        {
            window.onmousewheel = function(){
                return true;
            }
            return true;
        }

        //进行下一步移动
        var repeat = "BlogDirectory.moveScrollBar(" + finalpos + "," + interval + ")";
        document.body.movement = setTimeout(repeat, interval);
    },

    htmlDecode:function (text){
        var temp = document.createElement("div");
        temp.innerHTML = text;
        var output = temp.innerText || temp.textContent;
        temp = null;
        return output;
    },
    
    /*
    创建博客目录，id表示包含博文正文的 div 容器的 id，
    mt 和 st 分别表示主标题和次级标题的标签名称（如 H2、H3，大写或小写都可以！），
    interval 表示移动的速度
    */
    createBlogDirectory:function (id, mt, st, interval){
        //获取博文正文div容器
        var elem = document.getElementById(id);
        if(!elem) return false;
        //获取div中所有元素结点
        var nodes = elem.getElementsByTagName("*");
        //创建博客目录的div容器
        var divSideBar = document.createElement('DIV');
        divSideBar.className = 'uprightsideBar';
        divSideBar.setAttribute('id', 'uprightsideBar');
        var divSideBarTab = document.createElement('DIV');
        divSideBarTab.setAttribute('id', 'sideBarTab');
        divSideBar.appendChild(divSideBarTab);
        var h2 = document.createElement('H2');
        divSideBarTab.appendChild(h2);
        var txt = document.createTextNode('目录导航');
        h2.appendChild(txt);
        var divSideBarContents = document.createElement('DIV');
        divSideBarContents.style.display = 'none';
        divSideBarContents.setAttribute('id', 'sideBarContents');
        divSideBar.appendChild(divSideBarContents);
        //创建自定义列表
        var dlist = document.createElement("dl");
        divSideBarContents.appendChild(dlist);
        var num = 0;//统计找到的mt和st
        mt = mt.toUpperCase();//转化成大写
        st = st.toUpperCase();//转化成大写
        //遍历所有元素结点
        for(var i=0; i<nodes.length; i++)
        {
            if(nodes[i].nodeName == mt|| nodes[i].nodeName == st)
            {
                //获取标题文本
                var nodetext = nodes[i].innerHTML.replace(/<\/?[^>]+>/g,"");//innerHTML里面的内容可能有HTML标签，所以用正则表达式去除HTML的标签
                nodetext = nodetext.replace(/ /ig, "");//替换掉所有的
                nodetext = BlogDirectory.htmlDecode(nodetext);
                //插入锚
                nodes[i].setAttribute("id", "blogTitle" + num);
                var item;
                switch(nodes[i].nodeName)
                {
                    case mt:    //若为主标题
                        item = document.createElement("dt");
                        break;
                    case st:    //若为子标题
                        item = document.createElement("dd");
                        break;
                }

                //创建锚链接
                var itemtext = document.createTextNode(nodetext);
                item.appendChild(itemtext);
                item.setAttribute("name", num);
                //添加鼠标点击触发函数
                item.onclick = function(){        
                var pos = BlogDirectory.getElementPosition(document.getElementById("blogTitle" + this.getAttribute("name")));
                    if(!BlogDirectory.moveScrollBar(pos.top, interval)) return false;
                };
                //将自定义表项加入自定义列表中
                dlist.appendChild(item);
                num++;
            }
        }

        if(num == 0) return false;
        /* 鼠标进入时的事件处理 */
        divSideBarTab.onmouseenter = function(){
            divSideBarContents.style.display = 'block';
        }
        /* 鼠标离开时的事件处理 */
        divSideBar.onmouseleave = function() {
            divSideBarContents.style.display = 'none';
        }

        document.body.appendChild(divSideBar);
    }

};

<!--  页面加载完成之后生成博客目录, 为右下角推荐推荐区域添加关注按钮  -->
window.onload=function(){
    BlogDirectory.createBlogDirectory("cnblogs_post_body","h2","h3",20);
    
/*
    $('#div_digg').prepend('<div style="padding-bottom: 5px"><span class="icon_favorite" style="padding-top: 2px"></span><a onclick="cnblogs.UserManager.FollowBlogger(\'9a35f2c7-18ab-e111-aa3f-842b2b196315\');" href="javascript:void(0);" style="font-weight: bold; padding-left:5px;">关注一下楼主吧</a> </div>');
*/
}
</script>
```

### 增加页脚动画
```
<!--  增加页脚动画  -->
<script src="https://cdn.jsdelivr.net/npm/live2d-widget@3.0.4/lib/L2Dwidget.min.js"></script>
<script type="text/javascript">
L2Dwidget.init();
</script>
```

### 修改标签页的icon图标
```
<!-- 自定义修改标签页的icon图标，网站生成icon： https://realfavicongenerator.net/#.XDBOgc_7RKM -->
<script type="text/javascript" language="javascript">
　　//Setting ico for cnblogs
　　var linkObject = document.createElement('link');
　　linkObject.rel = "shortcut icon";
　　linkObject.href = "https://blog-static.cnblogs.com/files/yusq77/favicon.ico";
　　document.getElementsByTagName("head")[0].appendChild(linkObject);
</script>
```

