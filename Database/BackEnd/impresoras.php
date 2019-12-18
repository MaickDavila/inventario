<?php
require("conexion.php");

$id = isset($_GET["id"])?$_GET["id"]:"";
$idarea = isset($_GET["idarea"])?$_GET["idarea"]:"";
$descripcion = isset($_GET["descripcion"])?$_GET["descripcion"]:"";
$op = isset($_GET["op"])?$_GET["op"]:"0";


header('Access-Control-Allow-Origin: *');
header("Access-Control-Allow-Headers: X-API-KEY, Origin, X-Requested-With, Content-Type, Accept, Access-Control-Request-Method");
header("Access-Control-Allow-Methods: GET, POST, OPTIONS, PUT, DELETE");
header("Allow: GET, POST, OPTIONS, PUT, DELETE");
$method = $_SERVER['REQUEST_METHOD'];
if($method == "OPTIONS") {
    die();
}


//-------------------------------
if($op != "0"){
    switch ($op) {
        case 'insert':
            $consulta = "call InsertarImpresora($idarea,'$descripcion')";
            $resultado = mysqli_query($conexion, $consulta);
            if($resultado) echo "0";
            else echo "1";
            break;
        case 'update':
            $consulta = "call ModificarImpresora($id, $idarea,'$descripcion')";
            $resultado = mysqli_query($conexion, $consulta);
            if($resultado) echo "0";
            else echo "1";
        break;

        case 'delete':
            $consulta = "call EliminarImpresora($id)";
            $resultado = mysqli_query($conexion, $consulta);
            if($resultado) echo "0";
            else echo "1";
        break;

        case 'show':
            $consulta = "call MostrarImpresora()";
            $resultado = mysqli_query($conexion, $consulta);
            
            if(!$resultado){
                die('Error de consulta '. mysqli_error($conexion));            
            }
    
            $json = array();
    
            while($fila = mysqli_fetch_array($resultado)){
                $json[] = array(
                    'idimpresoras'=> $fila['idimpresoras'],
                    'area'=> $fila['area'],
                    'descripcion'=> $fila['descripcion'],
                    'idarea'=> $fila['idarea'],
                    'estado'=> $fila['estado']                    
                );
            }
    
            $jsonstring = json_encode($json);
    
            echo $jsonstring;
        break;
        
        default:
            # code...
            echo "1";
            break;
    }
}



