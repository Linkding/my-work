<title>青丘测试2服时间调整</title>
  <h2><b>测试服时间调整</b></h2> <br>

<?php 
echo "当前系统时间</br>"; 
echo $showtime=date("Y-m-d H:i:s");
?>
<br>
<br>
修改时间或同步时间后需刷新网页,当前系统时间才显示正常;
</br>
</br>

  <?php

if($_POST['Submit1']){
   $result1 = shell_exec("/usr/bin/sudo /root/sh_dir/qqh_web.sh stop");
   echo $result1;
   echo " 游戏服关闭成功";
     }
if($_POST['Submit2']){
   $result1 = shell_exec("/usr/bin/sudo /root/sh_dir/qqh_web.sh start");
   echo $result1;
   echo " 游戏服启动成功";
     }
if($_POST['Submit3']){
   $result1 = shell_exec("/usr/bin/sudo /root/sh_dir/qqh_web.sh restart");
   echo $result1;
   echo " 游戏服重启成功";
     }
	 
if($_POST['Submit4']){
  $result2=shell_exec("/usr/bin/sudo /root/sh_dir/qqh_test2_main.sh ");
  echo "测试2服更新成功";
     }
if($_POST['Submit8']){
  $result2=shell_exec("/usr/bin/sudo /root/sh_dir/qqh_auto_main_test1.sh ");
  echo "测试1服更新成功";
     }
if($_POST['Submit5']){
  $result2=shell_exec("/usr/bin/sudo /root/sh_dir/delete_db.sh");
  echo "数据库删除成功";
     }
if($_POST['Submit6']){
  $result2=shell_exec("/usr/bin/sudo /root/sh_dir/time.sh");
  echo "时间同步成功";
     }
if($_POST['Submit7']){
  $result2=shell_exec("/usr/bin/sudo /root/sh_dir/time2.sh,$arr");
  echo "显示当前时间";
  print_r($arr);
     }
if($_POST['Submit9']){
  $result2=shell_exec("/usr/bin/sudo /root/sh_dir/,$arr");
  echo "跨服中心服更新成功！！";
  print_r($arr);
    }

?>
</br>
</br> 
</br>
</br>

<form name="form3" method="post" action="" >
有更新包： </br> 
  <input name="Submit1" type="submit" id="Submit1" value="关闭游戏服">
  <input name="Submit4" type="submit" id="Submit1" value="更新测试2服">
  <input name="Submit8" type="submit" id="Submit1" value="更新测试1服">
  <input name="Submit2" type="submit" id="Submit1" value="启动游戏服">
  <input name="Submit3" type="submit" id="Submit1" value="重启游戏服"></br>
  <input name="Submit9" type="submit" id="Submit1" value="更新跨服中心服（测试环境）"></br>
</br>
</br>
往前调整时间（需删挡）：</br>
  <input name="Submit1" type="submit" id="Submit1" value="关闭游戏服">
  <input name="Submit5" type="submit" id="Submit2" value="删除数据库">
  <input name="Submit2" type="submit" id="Submit1" value="启动游戏服"></br>
</br>
</br>
往后调整时间：</br>
  <input name="Submit1" type="submit" id="Submit1" value="关闭游戏服">
  <input name="Submit2" type="submit" id="Submit1" value="启动游戏服">
  <input name="Submit3" type="submit" id="Submit1" value="重启游戏服">
</br>
</br>
</br>
</br>
同步北京时间，同步后需刷新网页,最上面系统时间才显示正常：</br>
  <input name="Submit1" type="submit" id="Submit1" value="关闭游戏服">
  <input name="Submit6" type="submit" id="Submit1" value="同步当前北京时间 ">
</br>
</br>
</form>


 







<h1>调整系统时间</h1>
<form name="input"action="/cgi-bin/change_date.py"method="get">
<!--hour: <input type="text"name="hour"><br><br>-->
mon: <input type="text" name="mon"><br><br>
day: <input type="text" name="day"><br><br>
hour: <input type="text" name="hour"><br><br>
minute: <input type="text" name="minute"><br><br>
<input type="submit"value="Submit">
</form>







<html>
<body>

<form action="upload_file.php" method="post" enctype="multipart/form-data"> 
上传：<input type="file" name="myfile" /> 
<input type="submit" name="submit" value="上传" /> 
</form> 


</body>
</html>
