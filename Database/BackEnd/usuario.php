<?php
require("conexion.php");

$id = isset($_GET["id"])?$_GET["id"]:"";
$idtipo_usuario = isset($_GET["idtipo_usuario"])?$_GET["idtipo_usuario"]:"";
$nombres = isset($_GET["nombres"])?$_GET["nombres"]:"";
$apellidos = isset($_GET["apellidos"])?$_GET["apellidos"]:"";
$celular = isset($_GET["celular"])?$_GET["celular"]:"";
$correo = isset($_GET["correo"])?$_GET["correo"]:"";
$usuario = isset($_GET["usuario"])?$_GET["usuario"]:"";

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
            $consulta = "call InsertarUsuario($idtipo_usuario, '$nombres','$apellidos','$celular','$correo')";
            $resultado = mysqli_query($conexion, $consulta);
            if($resultado) echo "0";
            else echo "1";
            break;
        case 'update':
            $consulta = "call ModificarUsuario($id,$idtipo_usuario, '$nombres','$apellidos','$celular','$correo')";
            $resultado = mysqli_query($conexion, $consulta);
            if($resultado) echo "0";
            else echo "1";
        break;

        case 'delete':
            $consulta = "call EliminarUsuario($id)";
            $resultado = mysqli_query($conexion, $consulta);
            if($resultado) echo "0";
            else echo "1";
        break;

        case 'show':
            $consulta = "call MostrarUsuario()";
            $resultado = mysqli_query($conexion, $consulta);
            
            if(!$resultado){
                die('Error de consulta '. mysqli_error($conexion));            
            }
    
            $json = array();
    
            while($fila = mysqli_fetch_array($resultado)){
                $json[] = array(
                    'idusuario'=> $fila['idusuario'],
                    'tipo_usuario'=> $fila['tipo_usuario'],
                    'nombres'=> $fila['nombres'],
                    'apellidos'=> $fila['apellidos'],
                    'celular'=> $fila['celular'],
                    'correo'=> $fila['correo'],
                    'fecha'=> $fila['fecha'],
                    'estado'=> $fila['estado'],
                    'idtipousuario'=> $fila['idtipousuario'],                
                );
            }
    
            $jsonstring = json_encode($json);
    
            echo $jsonstring;
        break;


        case 'login':
            $consulta = "call Login('$usuario')";
            $resultado = mysqli_query($conexion, $consulta);
            
            if(!$resultado){
                die('Error de consulta '. mysqli_error($conexion));            
            }
    
            $json = array();
    
            while($fila = mysqli_fetch_array($resultado)){
                $json[] = array(
                    'idusuario_equipo'=> $fila['idusuario_equipo'],
                    'tipo_usuario'=> $fila['tipo_usuario'],
                    'area'=> $fila['area'],
                    'nombre_usuario'=> $fila['nombre_usuario'],
                    'usuario_equipo'=> $fila['usuario_equipo'],
                    'celular'=> $fila['celular'],
                    'correo'=> $fila['correo'],
                    'fecha'=> $fila['fecha'],                    
                    'idtipo_usuario'=> $fila['idtipo_usuario'],                
                    'idusuario'=> $fila['idusuario'],
                    'idequipo'=> $fila['idequipo'],
                    'idarea'=> $fila['idarea'],
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



