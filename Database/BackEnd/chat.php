<?php
require("conexion.php");

$id = isset($_GET["id"]) ? $_GET["id"] : "";


$idusuario_emisor = isset($_GET["idusuario_emisor"]) ? $_GET["idusuario_emisor"] : "";
$mensaje = isset($_GET["mensaje"]) ? $_GET["mensaje"] : "";

$idsoporte = isset($_GET["idsoporte"]) ? $_GET["idsoporte"] : ""; 
$estado = isset($_GET["estado"]) ? $_GET["estado"] : ""; 

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
        case 'sendMensaje':
            $consulta = "call InsertarSoporte($idusuario_emisor,'$mensaje')";
            $resultado = mysqli_query($conexion, $consulta);
            if ($resultado) echo "0";
            else echo "1";
            break;
        case 'insertMesage':
            $consulta = "call CambiarEstadoMesaje($idsoporte, $estado)";
            $resultado = mysqli_query($conexion, $consulta);
            if ($resultado) echo "0";
            else echo "1";
            break;

        case 'showMensajesSoporte':
            $consulta = "call MostrarSoporteCliente($id)";
            $resultado = mysqli_query($conexion, $consulta);

            if (!$resultado) {
                die('Error de consulta ' . mysqli_error($conexion));
            }

            $json = array();

            while ($fila = mysqli_fetch_array($resultado)) {
                $json[] = array(
                    'type' => "text",                    
                    'author'=> $fila['usuario'],                                        
                    'data'=> array(
                        'text'=> $fila['mensaje'],
                        'fecha' => $fila["fecha"]
                    )

                );
            }

            $jsonstring = json_encode($json);

            echo $jsonstring;
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

        case 'showMensajes':
            $consulta = "call MostrarSoporte()";
            $resultado = mysqli_query($conexion, $consulta);

            if (!$resultado) {
                die('Error de consulta ' . mysqli_error($conexion));
            }

            $json = array();

            while ($fila = mysqli_fetch_array($resultado)) {
                $json[] = array(
                    'type' => "text",                    
                    'author'=> $fila['usuario'],                                        
                    'data'=> array(
                        'text'=> $fila['mensaje'],
                        'fecha' => $fila["fecha"],
                        'id' => $fila["id_mesaje"],
                        'estado' => $fila["estado"]
                    )

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
