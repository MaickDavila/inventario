<?php
require("conexion.php");

$id = isset($_GET["id"])?$_GET["id"]:"";
$idtipo_usuario = isset($_GET["idtipo_usuario"])?$_GET["idtipo_usuario"]:"";
$nombres = isset($_GET["nombres"])?$_GET["nombres"]:"";
$apellidos = isset($_GET["apellidos"])?$_GET["apellidos"]:"";
$celular = isset($_GET["celular"])?$_GET["celular"]:"";
$correo = isset($_GET["correo"])?$_GET["correo"]:"";

$op = isset($_GET["op"])?$_GET["op"]:"0";

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
                    'idUsuario'=> $fila['idUsuario'],
                    'idtipo_usuario'=> $fila['idtipo_usuario'],
                    'nombres'=> $fila['nombres'],
                    'apellidos'=> $fila['apellidos'],
                    'celular'=> $fila['celular'],
                    'correo'=> $fila['correo'],
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



