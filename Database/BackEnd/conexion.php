<?php

$conexion = mysqli_connect("localhost", "root", "", "inventario");
mysqli_query($conexion, "SELECT NAMES 'utf8'");
if (!$conexion) {
    echo "¡Falló la comunicación con el servidor!";
}
