<?php
require("conexion.php");

$id = isset($_GET["id"])?$_GET["id"]:"";
$descripcion = isset($_GET["descripcion"])?$_GET["descripcion"]:"";
$op = isset($_GET["op"])?$_GET["op"]:"0";
 
//-------------------------------
if($op != "0"){
    switch ($op) {
        case 'insert':
            $consulta = "call InsertarTipo_Equipo('$descripcion')";
            $resultado = mysqli_query($conexion, $consulta);
            if($resultado) echo "0";
            else echo "1";
            break;
        case 'update':
            $consulta = "call ModificarTipo_Equipo($id, '$descripcion')";
            $resultado = mysqli_query($conexion, $consulta);
            if($resultado) echo "0";
            else echo "1";
        break;

        case 'delete':
            $consulta = "call EliminarTipo_Equipo($id)";
            $resultado = mysqli_query($conexion, $consulta);
            if($resultado) echo "0";
            else echo "1";
        break;

        case 'show':
            $consulta = "call MostrarTipo_Equipo()";
            $resultado = mysqli_query($conexion, $consulta);
            
            if(!$resultado){
                die('Error de consulta '. mysqli_error($conexion));            
            }
    
            $json = array();
    
            while($fila = mysqli_fetch_array($resultado)){
                $json[] = array(
                    'idTipo_Equipo'=> $fila['idTipo_Equipo'],
                    'descripcion'=> $fila['descripcion'],
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



