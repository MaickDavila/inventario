<?php

$conexion = mysqli_connect("localhost", "root", "", "inventario");
mysqli_query($conexion, "SET NAMES 'uft8'");

if (!$conexion) {
    echo "¡Falló la comunicación con el servidor!";
}


?>