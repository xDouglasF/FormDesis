<?php
include 'conexionDB.php';
header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Methods: GET, POST, PUT, DELETE');
header("Content-type: application/json; charset=utf-8");


$query="select * from candidato";
$consulta=pg_query($conn, $query); //Realiza una consulta para obtener todos los candidatos

$data=[];
$errors=['data' => false];

if(pg_num_rows($consulta)>0){ //Si el numero de filas es mayor a 0 quiere decir que la consulta fue exitosa y si existen datos.
    while($candidato=pg_fetch_object($consulta)){ //Recorro todas las filas y se añaden los candidatos al array data especificando el idcandidato y el candidato
        $data[] = [
            'idcandidato' => $candidato->idcandidato,
            'candidato' => $candidato->candidato
        ];
    }
    echo json_encode($data);//Retorno los datos en formato JSON para que puedan ser utilizados
}
else{
    echo json_encode($errors);//En caso de que el numero de filas es 0 quiere decir que hubo un error en la consulta porque si existen candidatos en la base de datos
}


?>