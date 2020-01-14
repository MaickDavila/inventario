<?php
require("conexion.php");


$id = isset($_GET["id"])?$_GET["id"]:"";
$nombre = isset($_GET["nombre"])?$_GET["nombre"]:"";
$op = isset($_POST["op"])?$_POST["op"]:"0";
echo $nombre;

 
//-------------------------------
if($op != "0"){
    switch ($op) {
        case 'insert':
            $consulta = "call InsertarArea('$nombre')";
            $resultado = mysqli_query($conexion, $consulta);
            if($resultado) echo "0";
            else echo "1";
            break;
        case 'update':
            $consulta = "call ModificarArea($id, '$nombre')";
            $resultado = mysqli_query($conexion, $consulta);
            if($resultado) echo "0";
            else echo "1";
        break;

        case 'delete':
            $consulta = "call EliminarArea($id)";
            $resultado = mysqli_query($conexion, $consulta);
            if($resultado) echo "0";
            else echo "1";
        break;

        case 'show':
            $consulta = "call MostrarArea()";
            $resultado = mysqli_query($conexion, $consulta);
            
            if(!$resultado){
                die('Error de consulta '. mysqli_error($conexion));            
            }
    
            $json = array();
    
            while($fila = mysqli_fetch_array($resultado)){
                $json[] = array(
                    'idarea'=> $fila['idarea'],
                    'nombre'=> $fila['nombre'],
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



