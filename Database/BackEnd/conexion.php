<?php

$conexion = mysqli_connect("localhost", "root", "Yaqha13579!", "inventario");
mysqli_query($conexion, "SELECT NAMES 'utf8'");
if (!$conexion) {
    echo "¡Falló la comunicación con el servidor!";
}
