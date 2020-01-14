<?php
require("conexion.php");

$id = isset($_GET["id"])?$_GET["id"]:"";
$idarea = isset($_GET["idarea"])?$_GET["idarea"]:"";
$idusuario = isset($_GET["idusuario"])?$_GET["idusuario"]:"";
$idequipo = isset($_GET["idequipo"])?$_GET["idequipo"]:"";

 

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
            $consulta = "call InsertarUsuario_Equipo($idarea,$idusuario,$idequipo)";
            $resultado = mysqli_query($conexion, $consulta);
            if($resultado) echo "0";
            else echo "1";
            break;
        case 'update':
            $consulta = "call ModificarUsuario_Equipo($id, $idarea,$idusuario,$idequipo)";
            $resultado = mysqli_query($conexion, $consulta);
            if($resultado) echo "0";
            else echo "1";
        break;

        case 'delete':
            $consulta = "call EliminarUsuario_Equipo($id)";
            $resultado = mysqli_query($conexion, $consulta);
            if($resultado) echo "0";
            else echo "1";
        break;

        case 'show':
            $consulta = "call MostrarUsuario_Equipo()";
            $resultado = mysqli_query($conexion, $consulta);
            
            if(!$resultado){
                die('Error de consulta '. mysqli_error($conexion));            
            }
    
            $json = array();
    
            while($fila = mysqli_fetch_array($resultado)){
                $json[] = array(
                    'id'=> $fila['id'],                    
                    'area'=> $fila['area'],                    
                    'usuario'=> $fila['usuario'],                    
                    'nombre_equipo'=> $fila['nombre_equipo'],
                    'estado'=> $fila['estado']                     
                );
            }
    
            $jsonstring = json_encode($json);
    
            echo $jsonstring;
        break;

        case 'show2':
            $consulta = "call MostrarUsuario_EquipoHome($id)";
            $resultado = mysqli_query($conexion, $consulta);
            
            if(!$resultado){
                die('Error de consulta '. mysqli_error($conexion));            
            }
    
            $json = array();
    
            while($fila = mysqli_fetch_array($resultado)){
                $json = array(
                    'id'=> $fila['id'],                    
                    'area'=> $fila['area'],                    
                    'usuario'=> $fila['usuario'],                    
                    'nombre_equipo'=> $fila['nombre_equipo'],
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



