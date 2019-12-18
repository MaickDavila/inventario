<?php
require("conexion.php");

$id = isset($_GET["id"])?$_GET["id"]:"";
$idarea = isset($_GET["idarea"])?$_GET["idarea"]:"";
$idusuario = isset($_GET["idusuario"])?$_GET["idusuario"]:"";
$idmarca = isset($_GET["idmarca"])?$_GET["idmarca"]:"";
$idtipo_equipo = isset($_GET["idtipo_equipo"])?$_GET["idtipo_equipo"]:"";
$nombre_equio = isset($_GET["nombre_equio"])?$_GET["nombre_equio"]:"";
$usuario_equipo = isset($_GET["usuario_equipo"])?$_GET["usuario_equipo"]:"";
$procesador = isset($_GET["procesador"])?$_GET["procesador"]:"";
$memoria_ram = isset($_GET["memoria_ram"])?$_GET["memoria_ram"]:"";
$disco_duro = isset($_GET["disco_duro"])?$_GET["disco_duro"]:"";
$ip = isset($_GET["ip"])?$_GET["ip"]:"";
$mascara_sub_red = isset($_GET["mascara_sub_red"])?$_GET["mascara_sub_red"]:"";
$puerta_enlace = isset($_GET["puerta_enlace"])?$_GET["puerta_enlace"]:"";
$dns_preferido = isset($_GET["dns_preferido"])?$_GET["dns_preferido"]:"";
$dns_alternativo = isset($_GET["dns_alternativo"])?$_GET["dns_alternativo"]:"";
$dominio = isset($_GET["dominio"])?$_GET["dominio"]:"";
$antivirus = isset($_GET["antivirus"])?$_GET["antivirus"]:"";
$sistema_operativo = isset($_GET["sistema_operativo"])?$_GET["sistema_operativo"]:"";


$op = isset($_GET["op"])?$_GET["op"]:"0";


//-------------------------------
if($op != "0"){
    switch ($op) {
        case 'insert':
            $consulta = "call InsertarUsuario_Equipo($idarea, $idusuario, $idmarca, $idtipo_equipo, '$nombre_equio','$usuario_equipo','$procesador','$memoria_ram','$disco_duro','$ip','$mascara_sub_red','$puerta_enlace','$dns_preferido','$dns_alternativo',$dominio,$antivirus,'$sistema_operativo')";
            $resultado = mysqli_query($conexion, $consulta);
            if($resultado) echo "0";
            else echo "1";
            break;
        case 'update':
            $consulta = "call ModificarUsuario_Equipo($id, $idarea, $idusuario, $idmarca, $idtipo_equipo, '$nombre_equio','$usuario_equipo','$procesador','$memoria_ram','$disco_duro','$ip','$mascara_sub_red','$puerta_enlace','$dns_preferido','$dns_alternativo',$dominio,$antivirus,'$sistema_operativo')";
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
                    'Id'=> $fila['Id'],
                    'Area'=> $fila['Area'],
                    'Nombre'=> $fila['Nombre'],                    
                    'Marca'=> $fila['Marca'],
                    'Tipo_Equipo'=> $fila['Tipo_Equipo'],
                    'Nombre_Equipo'=> $fila['Nombre_Equipo'],
                    'Usuario_Equipo'=> $fila['Usuario_Equipo'],
                    'Procesador'=> $fila['Procesador'],
                    'Memoria_Ram'=> $fila['Memoria_Ram'],
                    'Disco_Duro'=> $fila['Disco_Duro'],
                    'Ip'=> $fila['Ip'],
                    'Mascara_Sub_Red'=> $fila['Mascara_Sub_Red'],
                    'Puerta_Enlace'=> $fila['Puerta_Enlace'],
                    'Dns_Preferido'=> $fila['Dns_Preferido'],
                    'Dns_Alternativo'=> $fila['Dns_Alternativo'],
                    'Dominio'=> $fila['Dominio'],
                    'Antivirus'=> $fila['Antivirus'],
                    'Sistema_Operativo'=> $fila['Sistema_Operativo'],
                    'Estado'=> $fila['Estado']                     
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



