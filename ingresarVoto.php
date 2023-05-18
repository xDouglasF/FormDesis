<?php
include 'conexionDB.php';
header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Methods: GET, POST, PUT, DELETE');
header("Content-type: application/json; charset=utf-8");

//Almaceno en variables todos los parametros para utilizarlos en la query
$nombre = $_POST['nombre'];
$alias = $_POST['alias'];
$rut = $_POST['rut'];
$email = $_POST['email'];
$region = $_POST['region'];
$comuna = $_POST['comuna'];
$candidato = $_POST['candidato'];
$checkboxs = $_POST['checkboxs'];

$prequery=pg_query($conn,"select rut from voto where rut='".$rut."'"); //Realizo una "prequery" para saber si existe un voto con el mismo rut en el sistema
if(pg_num_rows($prequery)==0){ //Si el numero de filas es 0 quiere decir que no existe voto que tenga el mismo rut asociado
    $query="insert into voto(rut, nombre_y_apellido, alias, email, idregion, idcomuna, idcandidato, conocio)
    VALUES('".$rut."','".$nombre."','".$alias."','".$email."',".$region.",".$comuna.",".$candidato.",'".$checkboxs."')";
    $consulta=pg_query($conn, $query); //Se realiza la query y se ingresa el voto correctamente al sistema
    echo json_encode("Datos ingresados correctamente");
}else{ //En caso de que el numero de filas sea distinto de 0 quiere decir que ya existe un voto en el sistema que tenga asociado el mismo rut, por lo tanto no se puede ingresar
    echo json_encode("No se pudo ingresar el voto porque el rut ya existe en el sistema");
}

?>