<?php
require("conexion.php");

$id = isset($_GET["id"]) ? $_GET["id"] : "";
$idarea = isset($_GET["idarea"]) ? $_GET["idarea"] : "";
$idusuario = isset($_GET["idusuario"]) ? $_GET["idusuario"] : "";





$idmarca = isset($_GET["idmarca"]) ? $_GET["idmarca"] : "";
$idtipo_equipo = isset($_GET["idtipo_equipo"]) ? $_GET["idtipo_equipo"] : "";
$nombre_equio = isset($_GET["nombre_equio"]) ? $_GET["nombre_equio"] : "";
$usuario_equipo = isset($_GET["usuario_equipo"]) ? $_GET["usuario_equipo"] : "";
$procesador = isset($_GET["procesador"]) ? $_GET["procesador"] : "";
$memoria_ram = isset($_GET["memoria_ram"]) ? $_GET["memoria_ram"] : "";
$disco_duro = isset($_GET["disco_duro"]) ? $_GET["disco_duro"] : "";
$ip = isset($_GET["ip"]) ? $_GET["ip"] : "";
$mascara_sub_red = isset($_GET["mascara_sub_red"]) ? $_GET["mascara_sub_red"] : "";
$puerta_enlace = isset($_GET["puerta_enlace"]) ? $_GET["puerta_enlace"] : "";
$dns_preferido = isset($_GET["dns_preferido"]) ? $_GET["dns_preferido"] : "";
$dns_alternativo = isset($_GET["dns_alternativo"]) ? $_GET["dns_alternativo"] : "";
$dominio = isset($_GET["dominio"]) ? $_GET["dominio"] : "";
$antivirus = isset($_GET["antivirus"]) ? $_GET["antivirus"] : "";
$sistema_operativo = isset($_GET["sistema_operativo"]) ? $_GET["sistema_operativo"] : "";


$op = isset($_GET["op"]) ? $_GET["op"] : "0";


header('Access-Control-Allow-Origin: *');
header("Access-Control-Allow-Headers: X-API-KEY, Origin, X-Requested-With, Content-Type, Accept, Access-Control-Request-Method");
header("Access-Control-Allow-Methods: GET, POST, OPTIONS, PUT, DELETE");
header("Allow: GET, POST, OPTIONS, PUT, DELETE");
$method = $_SERVER['REQUEST_METHOD'];
if ($method == "OPTIONS") {
    die();
}


//-------------------------------
if ($op != "0") {
    switch ($op) {
        case 'insert':
            $consulta = "call InsertarEquipo($idmarca, $idtipo_equipo, '$nombre_equio','$usuario_equipo','$procesador','$memoria_ram','$disco_duro','$ip','$mascara_sub_red','$puerta_enlace','$dns_preferido','$dns_alternativo',$dominio,$antivirus,'$sistema_operativo')";
            $resultado = mysqli_query($conexion, $consulta);
            if ($resultado) echo "0";
            else echo "1";
            break;
        case 'update':
            $consulta = "call ModificarEquipo($id, $idmarca, $idtipo_equipo, '$nombre_equio','$usuario_equipo','$procesador','$memoria_ram','$disco_duro','$ip','$mascara_sub_red','$puerta_enlace','$dns_preferido','$dns_alternativo',$dominio,$antivirus,'$sistema_operativo')";
            $resultado = mysqli_query($conexion, $consulta);
            if ($resultado) echo "0";
            else echo "1";
            break;

        case 'delete':
            $consulta = "call EliminarEquipo($id)";
            $resultado = mysqli_query($conexion, $consulta);
            if ($resultado) echo "0";
            else echo "1";
            break;

        case 'show':
            $consulta = "call MostrarEquipo()";
            $resultado = mysqli_query($conexion, $consulta);

            if (!$resultado) {
                die('Error de consulta ' . mysqli_error($conexion));
            }

            $json = array();

            while ($fila = mysqli_fetch_array($resultado)) {
                $json[] = array(
                    'id' => $fila['id'],
                    'marca' => $fila['marca'],
                    'tipo_equipo' => $fila['tipo_equipo'],
                    'nombre_equipo' => $fila['nombre_equipo'],
                    'usuario_equipo' => $fila['usuario_equipo'],
                    'procesador' => $fila['procesador'],
                    'memoria_ram' => $fila['memoria_ram'],
                    'disco_duro' => $fila['disco_duro'],
                    'ip' => $fila['ip'],
                    'mascara_sub_red' => $fila['mascara_sub_red'],
                    'puerta_enlace' => $fila['puerta_enlace'],
                    'dns_preferido' => $fila['dns_preferido'],
                    'dns_alternativo' => $fila['dns_alternativo'],
                    'dominio' => $fila['dominio'],
                    'antivirus' => $fila['antivirus'],
                    'sistema_operativo' => $fila['sistema_operativo'],
                    'fecha' => $fila['fecha'],
                    'estado' => $fila['estado'],
                    'idmarca' => $fila['idmarca'],
                    'idtipo_equipo' => $fila['idtipo_equipo']
                );
            }

            $jsonstring = json_encode($json);

            echo $jsonstring;
            break;

        case 'showPropietario':
            $consulta = "call MostrarPropietario($id)";
            $resultado = mysqli_query($conexion, $consulta);

            if (!$resultado) {
                die('Error de consulta ' . mysqli_error($conexion));
            }

            $json = array();

            while ($fila = mysqli_fetch_array($resultado)) {
                $json[] = array(
                    'id'=> $fila['id'],                    
                    'area'=> $fila['area'],
                    'propietario'=> $fila['propietario'],
                    'fecha'=> $fila['fecha'],
                    'estado'=> $fila['estado'],     
                    'idarea'=> $fila['idarea'],     
                    'idusuario'=> $fila['idusuario']
                );
            }

            $jsonstring = json_encode($json);

            echo $jsonstring;

            break;

        case 'insertPropietario':
            $consulta = "call InsertarPropietario($idarea, $idusuario, $id)";
            $resultado = mysqli_query($conexion, $consulta);
            if ($resultado) echo "0";
            else echo "1";
            break;

        case 'CambiarPropietario':
            $consulta = "call CambiarPropietario($id)";
            $resultado = mysqli_query($conexion, $consulta);
            if ($resultado) echo "0";
            else echo "1";
            break;

        case 'MostrarEquipoUsuario':
            $consulta = "call MostrarEquipoUsuario($idusuario)";
            $resultado = mysqli_query($conexion, $consulta);

            if (!$resultado) {
                die('Error de consulta ' . mysqli_error($conexion));
            }

            $json = array();

            while ($fila = mysqli_fetch_array($resultado)) {
                $json[] = array(
                    'idusuario_equipo'=> $fila['idusuario_equipo'],                    
                    'area'=> $fila['area'],
                    'marca'=> $fila['marca'],
                    'tipo'=> $fila['tipo'],
                    'nombre_equipo'=> $fila['nombre_equipo'],     
                    'usuario_equipo'=> $fila['usuario_equipo'],     
                    'procesador'=> $fila['procesador'],
                    'memoria_ram'=> $fila['memoria_ram'],
                    'disco_duro'=> $fila['disco_duro'],
                    'ip'=> $fila['ip'],
                    'mascara_sub_red'=> $fila['mascara_sub_red'],
                    'puerta_enlace'=> $fila['puerta_enlace'],
                    'dns_preferido'=> $fila['dns_preferido'],
                    'dns_alternativo'=> $fila['dns_alternativo'],
                    'dominio'=> $fila['dominio'],
                    'antivirus'=> $fila['antivirus'],
                    'fecha'=> $fila['fecha'],
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
