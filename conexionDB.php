<?php
//Control en la conexión a la base de datos
$_host='localhost';
$_db='formularioDesis';
$_user='postgres';
$_pass='postgres';

$conn=pg_connect("host=$_host dbname=$_db user=$_user password=$_pass");

pg_close();
?>