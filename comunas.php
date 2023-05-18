<?php
include 'conexionDB.php';
header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Methods: GET, POST, PUT, DELETE');
header("Content-type: application/json; charset=utf-8");

$idregion = $_POST['idregion']; //Obtengo el idregion que se me fue pasado por parametro para poder usarlo en la query

$query="select * from comuna where idregion =".$idregion;
$consulta=pg_query($conn, $query); //Realiza una consulta para obtener todas las comunas dependiendo del idregion especificado

$data=[];
$errors=['data' => false];

if(pg_num_rows($consulta)>0){ //Si el numero de filas es mayor a 0 quiere decir que la consulta fue exitosa y si existen comunas que pertenescan a la región especificada.
    while($comuna=pg_fetch_object($consulta)){ //Recorro todas las filas y se añaden las comunas al array data especificando el idcomuna y la comuna
        $data[] = [
            'idcomuna' => $comuna->idcomuna,
            'comuna' => $comuna->comuna
        ];
    }
    echo json_encode($data);//Retorno los datos en formato JSON para que puedan ser utilizados
}
else{
    echo json_encode($errors);//En caso de que el numero de filas es 0 quiere decir que hubo un error en la consulta porque si existen comunas en todas las regiones
}


?>