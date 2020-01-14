-- phpMyAdmin SQL Dump
-- version 4.9.2
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 29-12-2019 a las 15:42:01
-- Versión del servidor: 10.4.10-MariaDB
-- Versión de PHP: 7.3.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `inventario`
--

DELIMITER $$
--
-- Procedimientos
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `CambiarEstadoMesaje` (`_id` INT(11), `_estado` TINYINT(4), `_mensaje` TEXT)  update soporte set estado =  _estado, mensaje_soporte = _mensaje
where idsoporte = _id$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `CambiarPropietario` (`_id` INT)  begin
set @idequipo = (select idequipo from usuario_equipo where idusuario_equipo = _id);

update usuario_equipo set estado = 0 where idequipo = @idequipo;

update usuario_equipo set estado = 1
where idusuario_equipo = _id;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `EliminarArea` (`_id` INT)  update area set estado = 0, flag = 0
where idarea = _id$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `EliminarEquipo` (`_id` INT)  update equipo set estado = 0, flag = 0
where idequipo = _id$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `EliminarImpresora` (`_id` INT)  update impresoras set estado = 0, flag = 0
where idimpresoras = _id$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `EliminarMarca` (`_id` INT)  update marca set estado = 0, flag = 0
where idmarca = _id$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `EliminarTipo_Equipo` (`_id` INT)  update Tipo_Equipo set estado = 0, flag = 0
where idTipo_Equipo = _id$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `EliminarTipo_Usuario` (`_id` INT)  update tipo_usuario set estado = 0, flag = 0
where idtipo_usuario = _id$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `EliminarUsuario` (`_id` INT)  update Usuario set estado = 0, flag = 0
where idUsuario = _id$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `EliminarUsuario_Equipo` (`_id` INT)  update ususario_equipo set estado = 0, flag= 0 
where id = _id$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `InsertarArea` (`_nombre` VARCHAR(100))  insert into area (nombre)
values(_nombre)$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `InsertarEquipo` (`_idmarca` INT, `_idtipo_equipo` INT, `_nombre_equio` VARCHAR(100), `_usuario_equipo` VARCHAR(100), `_procesador` VARCHAR(250), `_memoria_ram` VARCHAR(250), `_disco_duro` VARCHAR(250), `_ip` VARCHAR(45), `_mascara_sub_red` VARCHAR(45), `_puerta_enlace` VARCHAR(45), `_dns_preferido` VARCHAR(45), `_dns_alternativo` VARCHAR(45), `_dominio` TINYINT(4), `_antivirus` TINYINT(4), `_sistema_operativo` VARCHAR(100))  insert into Equipo (
idmarca, 
idtipo_equipo, 
nombre_equio,
usuario_equipo,
procesador,
memoria_ram,
disco_duro,
ip,
mascara_sub_red,
puerta_enlace,
dns_preferido,
dns_alternativo,
dominio,
antivirus,
sistema_operativo
)
values(
_idmarca, 
_idtipo_equipo, 
_nombre_equio,
_usuario_equipo,
_procesador,
_memoria_ram,
_disco_duro,
_ip,
_mascara_sub_red,
_puerta_enlace,
_dns_preferido,
_dns_alternativo,
_dominio,
_antivirus,
_sistema_operativo)$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `InsertarImpresora` (`_idarea` INT, `_descripcion` VARCHAR(250))  insert into impresoras (idarea, descripcion)
values(_idarea, _descripcion)$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `InsertarMarca` (`_nombre` VARCHAR(100))  insert into marca (nombre)
values(_nombre)$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `InsertarMensaje` (`_idusuario_equipo` INT(11), `_usuario` VARCHAR(100), `_mensaje` TEXT)  insert into reporte (idusuario_emisor,mensaje)
values(_idusuario_equipo,_mensaje)$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `InsertarPropietario` (`_idarea` INT, `_idusuario` INT, `_idequipo` INT)  insert into usuario_equipo (idarea, idusuario, idequipo, estado)
values(_idarea, _idusuario, _idequipo, 0)$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `InsertarSoporte` (`_idusuario_emisor` INT, `_mensaje` TEXT)  insert into soporte (idusuario_emisor, mensaje)
values(_idusuario_emisor, _mensaje)$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `InsertarTipo_Equipo` (`_descripcion` VARCHAR(100))  insert into Tipo_Equipo (descripcion)
values(_descripcion)$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `InsertarTipo_Usuario` (`_descripcion` VARCHAR(100))  insert into tipo_usuario(descripcion)
values(_descripcion)$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `InsertarUsuario` (`_idtipo_usuario` INT, `_nombres` VARCHAR(250), `_apellidos` VARCHAR(250), `_celular` VARCHAR(9), `_correo` VARCHAR(250))  insert into Usuario (idtipousuario, nombres,apellidos,celular, correo)
values(_idtipo_usuario,_nombres,_apellidos, _celular, _correo)$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `InsertarUsuario_Equipo` (`_idarea` INT, `_idusuario` INT, `_idequipo` INT)  insert into usuario_equipo (idarea, idusuario, idequipo)
values(_idarea, _idusuario, _idequipo)$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `Login` (`_usuario` VARCHAR(45))  select
ue.idusuario_equipo,
tu.descripcion as 'tipo_usuario',
a.nombre as 'area',
concat(u.nombres, " ", u.apellidos) as 'nombre_usuario',
e.usuario_equipo,
u.celular,
u.correo,
u.fecha,
tu.idtipo_usuario,
u.idusuario,
e.idequipo,
a.idarea
from usuario_equipo ue
inner join equipo e on ue.idequipo = e.idequipo
inner join usuario u on ue.idusuario = u.idusuario
inner join tipo_usuario tu on u.idtipousuario = tu.idtipo_usuario
inner join area a on ue.idarea = a.idarea
where e.usuario_equipo = _usuario and ue.flag = 1 and ue.estado = 1$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `ModificarArea` (`_id` INT, `_nombre` VARCHAR(100))  update area set nombre =  _nombre
where idarea = _id$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `ModificarEquipo` (`_id` INT, `_idmarca` INT, `_idtipo_equipo` INT, `_nombre_equio` VARCHAR(100), `_usuario_equipo` VARCHAR(100), `_procesador` VARCHAR(250), `_memoria_ram` VARCHAR(250), `_disco_duro` VARCHAR(250), `_ip` VARCHAR(45), `_mascara_sub_red` VARCHAR(45), `_puerta_enlace` VARCHAR(45), `_dns_preferido` VARCHAR(45), `_dns_alternativo` VARCHAR(45), `_dominio` TINYINT(4), `_antivirus` TINYINT(4), `_sistema_operativo` VARCHAR(100))  update Equipo  set
idmarca = _idmarca, 
idtipo_equipo = _idtipo_equipo, 
nombre_equio = _nombre_equio,
usuario_equipo = _usuario_equipo,
procesador = _procesador,
memoria_ram = _memoria_ram,
disco_duro = _disco_duro,
ip = _ip,
mascara_sub_red = _mascara_sub_red,
puerta_enlace = _puerta_enlace,
dns_preferido = _dns_preferido,
dns_alternativo = _dns_alternativo,
dominio = _dominio,
antivirus = _antivirus,
sistema_operativo = _sistema_operativo
where idequipo = _id$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `ModificarImpresora` (`_id` INT, `_idarea` INT, `_descripcion` VARCHAR(250))  update impresoras set idarea = _idarea,
descripcion = _descripcion
where idimpresoras = _id$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `ModificarMarca` (`_id` INT, `_nombre` VARCHAR(100))  update marca set nombre =  _nombre
where idmarca = _id$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `ModificarTipo_Equipo` (`_id` INT, `_descripcion` VARCHAR(100))  update Tipo_Equipo set descripcion =  _descripcion
where idTipo_Equipo = _id$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `ModificarTipo_Usuario` (`_id` INT, `_descripcion` VARCHAR(100))  update tipo_usuario set descripcion = _descripcion
where idtipo_usuario = _id$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `ModificarUsuario` (`_id` INT, `_idtipo_usuario` INT, `_nombres` VARCHAR(250), `_apellidos` VARCHAR(250), `_celular` VARCHAR(9), `_correo` VARCHAR(250))  update Usuario set
idtipousuario = _idtipo_usuario,
nombres = _nombres,
apellidos = _apellidos,
celular = _celular, 
correo = _correo
where idusuario = _id$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `ModificarUsuario_Equipo` (`_id` INT, `_idarea` INT, `_idusuario` INT, `_idequipo` INT)  update ususario_equipo set idarea = _idarea, idusuario = _idusuario, idequipo = _idequipo
where id = _id$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `MostrarArea` ()  select
idarea as 'idarea',
nombre as 'nombre',
case estado
when 1 then 'Activo'
when 0 then 'Desactivado'
end as 'estado'
from area
where estado = 1 and flag = 1
ORDER by idarea desc$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `MostrarEquipo` ()  select
ue.idequipo as 'id',
m.nombre as 'marca',
te.descripcion as 'tipo_equipo',
nombre_equio as 'nombre_equipo',
usuario_equipo as 'usuario_equipo',
procesador as 'procesador',
memoria_ram as 'memoria_ram',
disco_duro as 'disco_duro',
ip as 'ip',
mascara_sub_red as 'mascara_sub_red',
puerta_enlace as 'puerta_enlace',
dns_preferido as 'dns_preferido',
dns_alternativo as 'dns_alternativo',

case dominio
when 1 then 'Si'
when 0 then 'No'
end as 'dominio',
case antivirus
when 1 then 'Si'
when 0 then 'No'
end as 'antivirus',
sistema_operativo as 'sistema_operativo',
ue.fecha as 'fecha',
case ue.estado
when 1 then 'Activo'
when 0 then 'Desactivado'
end as 'estado',
ue.idmarca,
ue.idtipo_equipo
from equipo ue
inner join marca m on ue.idmarca = m.idmarca
inner join tipo_equipo te on ue.idtipo_equipo = te.idtipo_equipo
where ue.estado = 1 and ue.flag = 1$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `MostrarEquipoUsuario` (`_id` INT)  select
ue.idusuario_equipo,
a.nombre as 'area',
m.nombre as 'marca',
te.descripcion as 'tipo',
e.nombre_equio as 'nombre_equipo',
e.usuario_equipo,
e.procesador,
e.memoria_ram,
e.disco_duro,
e.ip,
e.mascara_sub_red,
e.puerta_enlace,
e.dns_preferido,
e.dns_alternativo,
case e.dominio 
when 1 then 'Si'
when 0 then 'No'
end as 'dominio'
,
case e.antivirus 
when 1 then 'Si'
when 0 then 'No'
end as 'antivirus',
e.sistema_operativo,
ue.fecha,
case ue.estado
when 1 then 'Activo'
when 0 then 'Inactivo'
end as 'estado',
ue.flag
from usuario_equipo ue
inner join usuario u on ue.idusuario = u.idusuario
inner join area a on ue.idarea = a.idarea
inner join equipo e on ue.idequipo = e.idequipo
inner join marca m on e.idmarca = m.idmarca
inner join tipo_equipo te on e.idtipo_equipo = te.idtipo_equipo
where u.idusuario = _id  
order by ue.estado desc$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `MostrarImpresora` ()  select
i.idimpresoras,
a.nombre as 'area',
i.descripcion,
case i.estado
when 1 then 'Activo'
when 0 then 'Desactivado'
end as 'estado',
i.idarea
from impresoras i
inner join area a on i.idarea = a.idarea
where i.flag = 1$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `MostrarMarca` ()  select 
idmarca,
nombre,
case estado
when 1 then 'Activo'
when 0 then 'Desactivado'
end as 'estado'
from marca
where estado = 1 and flag = 1$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `MostrarPropietario` (`_idequipo` INT)  select
ue.idusuario_equipo as 'id',
a.nombre as 'area',
CONCAT(u.nombres, " ", u.apellidos) as 'propietario',
ue.fecha,
case ue.estado 
when 0 then "Inactivo"
when 1 then "Activo"
end as "estado",
a.idarea,
ue.idusuario as 'idusuario'
from usuario_equipo ue
inner join equipo e on ue.idequipo = e.idequipo
inner join usuario u on ue.idusuario = u.idusuario
inner join area a on ue.idarea = a.idarea
where ue.idequipo = _idequipo
order by ue.estado desc$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `MostrarSoporte` ()  select
ue.idusuario_equipo as 'id',
concat(usu.nombres, " ", usu.apellidos) as 'usuario',
s.mensaje,
s.fecha,
s.idsoporte as 'id_mesaje',
s.estado as 'estado',
s.mensaje_soporte
from soporte s
inner join usuario_equipo ue on s.idusuario_emisor = ue.idusuario_equipo
inner join usuario usu on ue.idusuario = usu.idusuario
order by idsoporte desc$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `MostrarSoporteCliente` (`_id` INT(11))  select
ue.idusuario_equipo as 'id',
concat(usu.nombres, " ", usu.apellidos) as 'usuario',
s.mensaje,
s.fecha
from soporte s
inner join usuario_equipo ue on s.idusuario_emisor = ue.idusuario_equipo
inner join usuario usu on ue.idusuario = usu.idusuario 
where ue.idusuario_equipo= _id
order by idsoporte asc$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `MostrarTipo_Equipo` ()  select
idtipo_equipo,
descripcion,
case estado
when 1 then 'Activo'
when 0 then 'Desactivado'
end as 'estado'
from Tipo_Equipo
where estado = 1 and flag = 1$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `MostrarTipo_Usuario` ()  select
idtipo_usuario,
descripcion,
case estado
when 1 then 'Activo'
when 0 then 'Desactivado'
end as 'estado'
from tipo_usuario
where estado = 1 and flag = 1$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `MostrarUsuario` ()  select
idusuario,
tu.descripcion as 'tipo_usuario',
nombres,
apellidos,
celular,
correo,
fecha,
case u.estado
when 1 then 'Activo'
when 0 then 'Desactivado'
end as 'estado',
idtipousuario

from Usuario u
inner join tipo_usuario tu on u.idtipousuario = tu.idtipo_usuario
where u.flag = 1$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `MostrarUsuario_Equipo` ()  select
ue.idusuario_equipo as 'id',
a.nombre as 'area',
concat(u.nombres,' ',u.apellidos) as 'usuario',
e.nombre_equio as 'nombre_equipo',
ue.estado,
e.idequipo as 'id_equipo'
from usuario_equipo ue
inner join area a on ue.idarea = a.idarea
inner join usuario u on ue.idusuario = u.idusuario
inner join equipo e on ue.idequipo = e.idequipo
where ue.flag = 1$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `MostrarUsuario_EquipoHome` (`_id_equipo` INT(11))  select
ue.idusuario_equipo as 'id',
a.nombre as 'area',
concat(u.nombres,' ',u.apellidos) as 'usuario',
e.nombre_equio as 'nombre_equipo',
ue.estado,
e.idequipo as 'id_equipo'
from usuario_equipo ue
inner join area a on ue.idarea = a.idarea
inner join usuario u on ue.idusuario = u.idusuario
inner join equipo e on ue.idequipo = e.idequipo
where (ue.flag = 1 and ue.idequipo = _id_equipo) and ue.estado = 1$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `area`
--

CREATE TABLE `area` (
  `idarea` int(11) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `estado` tinyint(4) DEFAULT 1,
  `flag` tinyint(4) DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `area`
--

INSERT INTO `area` (`idarea`, `nombre`, `estado`, `flag`) VALUES
(1, 'TI', 1, 1),
(2, 'SISTEMAS', 1, 1),
(3, 'NUEVA AREA', 1, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `equipo`
--

CREATE TABLE `equipo` (
  `idequipo` int(11) NOT NULL,
  `idmarca` int(11) DEFAULT NULL,
  `idtipo_equipo` int(11) DEFAULT NULL,
  `nombre_equio` varchar(100) DEFAULT NULL,
  `usuario_equipo` varchar(100) DEFAULT NULL,
  `procesador` varchar(250) DEFAULT NULL,
  `memoria_ram` varchar(250) DEFAULT NULL,
  `disco_duro` varchar(250) DEFAULT NULL,
  `ip` varchar(45) DEFAULT NULL,
  `mascara_sub_red` varchar(45) DEFAULT NULL,
  `puerta_enlace` varchar(45) DEFAULT NULL,
  `dns_preferido` varchar(45) DEFAULT NULL,
  `dns_alternativo` varchar(45) DEFAULT NULL,
  `dominio` tinyint(4) DEFAULT NULL,
  `antivirus` tinyint(4) DEFAULT NULL,
  `sistema_operativo` varchar(100) DEFAULT NULL,
  `fecha` date DEFAULT current_timestamp(),
  `estado` tinyint(4) DEFAULT 1,
  `flag` tinyint(4) DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `equipo`
--

INSERT INTO `equipo` (`idequipo`, `idmarca`, `idtipo_equipo`, `nombre_equio`, `usuario_equipo`, `procesador`, `memoria_ram`, `disco_duro`, `ip`, `mascara_sub_red`, `puerta_enlace`, `dns_preferido`, `dns_alternativo`, `dominio`, `antivirus`, `sistema_operativo`, `fecha`, `estado`, `flag`) VALUES
(1, 1, 1, 'MAICK-PC', 'MAICK', 'INTEL CORE I7', '16GB', '1TB', '192.168.43.172', 'mascar 1', 'puertita', 'dnsaa', 'dnsaooo', 1, 1, 'Widows 19', '2019-12-15', 1, 1),
(10, 2, 2, 'JUAN-PC', 'JUAN', 'INTEL CORE I9', '32 GB', '1 TB', '192.168.1.100', '', '', '', '', 1, 1, 'W10', '2019-12-17', 1, 1),
(11, 3, 2, 'SIN NOMBRE', 'NADA', 'MD 2019', '16 GB', '2TB', '', '', '', '', '', 1, 0, 'LINUX', '2019-12-17', 0, 0),
(12, 2, 1, 'JUNIOR-PC', 'JUNIOR', 'INTEL CORE I5', '8GB', '500GB', '', '', '', '', '', 0, 1, 'WINDOWS 8', '2019-12-17', 0, 0),
(13, 5, 2, 'FRANK-PC', 'FRANK', 'I3', '8GB', '500GB', '', '', '', '', '', 1, 1, 'WINDOWS XP', '2019-12-26', 1, 1),
(14, 4, 2, 'NUEVO EQUIPO', 'NUEVO-USER', 'INTEL CORE I7', '32 RAM', '1 TB', '', '', '', '', '', 0, 0, 'WINDOWS 10', '2019-12-28', 1, 1),
(15, 4, 2, 'WS_LOR_48', 'sromayna', 'intel core i5-6400 CPU@ 2.70GHZ', '8GB', '1TB', '10.24.2.48', '255.255.0.0', '10.24.1.151', '10.24.1.13', '', 1, 1, 'Windows8', '2019-12-28', 1, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `impresoras`
--

CREATE TABLE `impresoras` (
  `idimpresoras` int(11) NOT NULL,
  `idarea` int(11) DEFAULT NULL,
  `descripcion` varchar(250) DEFAULT NULL,
  `estado` tinyint(4) DEFAULT 1,
  `flag` tinyint(4) DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `impresoras`
--

INSERT INTO `impresoras` (`idimpresoras`, `idarea`, `descripcion`, `estado`, `flag`) VALUES
(1, 1, 'HP PAVILON', 1, 1),
(3, 2, 'HP DKST - 2019', 0, 0),
(4, 2, 'otras', 0, 0),
(5, 2, 'sss', 0, 0),
(6, 1, '1111', 0, 0),
(7, 2, 'dddd', 0, 0),
(8, 2, 'ddddfff', 0, 0),
(9, 1, 'gg', 0, 0),
(10, 2, 'fefefefe', 1, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `marca`
--

CREATE TABLE `marca` (
  `idmarca` int(11) NOT NULL,
  `nombre` varchar(100) DEFAULT NULL,
  `estado` tinyint(4) DEFAULT 1,
  `flag` tinyint(4) DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `marca`
--

INSERT INTO `marca` (`idmarca`, `nombre`, `estado`, `flag`) VALUES
(1, 'MSI', 1, 1),
(2, 'LENOVO', 1, 1),
(3, 'HP', 0, 0),
(4, 'ADVANCE', 1, 1),
(5, 'HP', 1, 1),
(6, 'NUEVA MARCA', 1, 1),
(7, 'OTRA MARCAdadsffsf', 1, 1),
(8, 'mimo marca', 1, 1),
(9, 'NUEVA MARCA XXXXX', 1, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `soporte`
--

CREATE TABLE `soporte` (
  `idsoporte` int(11) NOT NULL,
  `idusuario_emisor` int(11) DEFAULT NULL,
  `mensaje` text DEFAULT NULL,
  `fecha` datetime DEFAULT current_timestamp(),
  `estado` tinyint(4) DEFAULT 0,
  `flag` tinyint(4) DEFAULT 1,
  `mensaje_soporte` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `soporte`
--

INSERT INTO `soporte` (`idsoporte`, `idusuario_emisor`, `mensaje`, `fecha`, `estado`, `flag`, `mensaje_soporte`) VALUES
(80, 16, 'jola', '2019-12-28 22:02:46', 0, 1, NULL),
(81, 16, 'asdad', '2019-12-28 22:02:49', 0, 1, NULL),
(82, 16, 'cecee', '2019-12-28 22:02:50', 0, 1, NULL),
(83, 16, 'cgegeg', '2019-12-28 22:02:52', 0, 1, NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tipo_equipo`
--

CREATE TABLE `tipo_equipo` (
  `idtipo_equipo` int(11) NOT NULL,
  `descripcion` varchar(100) DEFAULT NULL,
  `estado` tinyint(4) DEFAULT 1,
  `flag` tinyint(4) DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `tipo_equipo`
--

INSERT INTO `tipo_equipo` (`idtipo_equipo`, `descripcion`, `estado`, `flag`) VALUES
(1, 'LAPTOP', 1, 1),
(2, 'DESKTOP', 1, 1),
(3, 'TODO EN UNO', 1, 1),
(4, 'TIPO NUEVO', 1, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tipo_usuario`
--

CREATE TABLE `tipo_usuario` (
  `idtipo_usuario` int(11) NOT NULL,
  `descripcion` varchar(100) DEFAULT NULL,
  `estado` tinyint(4) DEFAULT 1,
  `flag` tinyint(4) DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `tipo_usuario`
--

INSERT INTO `tipo_usuario` (`idtipo_usuario`, `descripcion`, `estado`, `flag`) VALUES
(1, 'ADMIN', 1, 1),
(2, 'USUARIO2', 1, 1),
(3, 'SUPER-ADMIN', 1, 1),
(4, 'OTROS', 1, 1),
(5, 'NUEVO', 1, 1),
(6, 'OTRO-NUEVO', 1, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuario`
--

CREATE TABLE `usuario` (
  `idusuario` int(11) NOT NULL,
  `idtipousuario` int(11) DEFAULT NULL,
  `nombres` varchar(250) DEFAULT NULL,
  `apellidos` varchar(250) DEFAULT NULL,
  `celular` varchar(9) DEFAULT NULL,
  `correo` varchar(250) DEFAULT NULL,
  `fecha` date DEFAULT current_timestamp(),
  `usuario` varchar(45) DEFAULT NULL,
  `estado` tinyint(4) DEFAULT 1,
  `flag` tinyint(4) DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `usuario`
--

INSERT INTO `usuario` (`idusuario`, `idtipousuario`, `nombres`, `apellidos`, `celular`, `correo`, `fecha`, `usuario`, `estado`, `flag`) VALUES
(8, 1, 'MAICK', 'DAVILA', '970637964', '', '2019-12-28', NULL, 1, 1),
(9, 1, 'MIRKO', 'MELENDEZ', '', '', '2019-12-28', NULL, 1, 1),
(10, 6, 'XXX', 'XXXCXCCV', '22424', 'VXXVXVX', '2019-12-28', NULL, 1, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuario_equipo`
--

CREATE TABLE `usuario_equipo` (
  `idusuario_equipo` int(11) NOT NULL,
  `idarea` int(11) DEFAULT NULL,
  `idusuario` int(11) DEFAULT NULL,
  `idequipo` int(11) DEFAULT NULL,
  `fecha` datetime DEFAULT current_timestamp(),
  `estado` tinyint(4) DEFAULT 1,
  `flag` tinyint(4) DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `usuario_equipo`
--

INSERT INTO `usuario_equipo` (`idusuario_equipo`, `idarea`, `idusuario`, `idequipo`, `fecha`, `estado`, `flag`) VALUES
(14, 2, 9, 1, '2019-12-28 21:24:00', 0, 1),
(15, 2, 9, 14, '2019-12-28 21:24:34', 1, 1),
(16, 1, 10, 13, '2019-12-28 21:37:21', 1, 1),
(17, 3, 10, 15, '2019-12-28 21:40:42', 1, 1),
(18, 2, 8, 15, '2019-12-28 21:42:29', 0, 1);

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `area`
--
ALTER TABLE `area`
  ADD PRIMARY KEY (`idarea`);

--
-- Indices de la tabla `equipo`
--
ALTER TABLE `equipo`
  ADD PRIMARY KEY (`idequipo`),
  ADD KEY `fk_usuario_equipo_marca_idx` (`idmarca`),
  ADD KEY `fk_usuario_equipo_tipo_equipo_idx` (`idtipo_equipo`);

--
-- Indices de la tabla `impresoras`
--
ALTER TABLE `impresoras`
  ADD PRIMARY KEY (`idimpresoras`),
  ADD KEY `fk_impresoras_area_idx` (`idarea`);

--
-- Indices de la tabla `marca`
--
ALTER TABLE `marca`
  ADD PRIMARY KEY (`idmarca`);

--
-- Indices de la tabla `soporte`
--
ALTER TABLE `soporte`
  ADD PRIMARY KEY (`idsoporte`),
  ADD KEY `fk_soporte_usuario_idx` (`idusuario_emisor`);

--
-- Indices de la tabla `tipo_equipo`
--
ALTER TABLE `tipo_equipo`
  ADD PRIMARY KEY (`idtipo_equipo`);

--
-- Indices de la tabla `tipo_usuario`
--
ALTER TABLE `tipo_usuario`
  ADD PRIMARY KEY (`idtipo_usuario`);

--
-- Indices de la tabla `usuario`
--
ALTER TABLE `usuario`
  ADD PRIMARY KEY (`idusuario`),
  ADD UNIQUE KEY `usuario_UNIQUE` (`usuario`),
  ADD KEY `fk_usuario_tipo_usuario_idx` (`idtipousuario`);

--
-- Indices de la tabla `usuario_equipo`
--
ALTER TABLE `usuario_equipo`
  ADD PRIMARY KEY (`idusuario_equipo`),
  ADD KEY `fk_usuario_equipo_equipo_idx` (`idequipo`),
  ADD KEY `fk_usuario_equipo_usuario_idx` (`idusuario`),
  ADD KEY `fk_usuario_equipo_area_idx` (`idarea`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `area`
--
ALTER TABLE `area`
  MODIFY `idarea` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `equipo`
--
ALTER TABLE `equipo`
  MODIFY `idequipo` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT de la tabla `impresoras`
--
ALTER TABLE `impresoras`
  MODIFY `idimpresoras` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT de la tabla `marca`
--
ALTER TABLE `marca`
  MODIFY `idmarca` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT de la tabla `soporte`
--
ALTER TABLE `soporte`
  MODIFY `idsoporte` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=84;

--
-- AUTO_INCREMENT de la tabla `tipo_equipo`
--
ALTER TABLE `tipo_equipo`
  MODIFY `idtipo_equipo` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `tipo_usuario`
--
ALTER TABLE `tipo_usuario`
  MODIFY `idtipo_usuario` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT de la tabla `usuario`
--
ALTER TABLE `usuario`
  MODIFY `idusuario` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT de la tabla `usuario_equipo`
--
ALTER TABLE `usuario_equipo`
  MODIFY `idusuario_equipo` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `equipo`
--
ALTER TABLE `equipo`
  ADD CONSTRAINT `fk_equipo_marca` FOREIGN KEY (`idmarca`) REFERENCES `marca` (`idmarca`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_equipo_tipo_equipo` FOREIGN KEY (`idtipo_equipo`) REFERENCES `tipo_equipo` (`idtipo_equipo`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `impresoras`
--
ALTER TABLE `impresoras`
  ADD CONSTRAINT `fk_impresoras_area` FOREIGN KEY (`idarea`) REFERENCES `area` (`idarea`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `soporte`
--
ALTER TABLE `soporte`
  ADD CONSTRAINT `fk_soporte_usuario` FOREIGN KEY (`idusuario_emisor`) REFERENCES `usuario_equipo` (`idusuario_equipo`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `usuario`
--
ALTER TABLE `usuario`
  ADD CONSTRAINT `fk_usuario_tipo_usuario` FOREIGN KEY (`idtipousuario`) REFERENCES `tipo_usuario` (`idtipo_usuario`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `usuario_equipo`
--
ALTER TABLE `usuario_equipo`
  ADD CONSTRAINT `fk_usuario_equipo_area` FOREIGN KEY (`idarea`) REFERENCES `area` (`idarea`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_usuario_equipo_equipo` FOREIGN KEY (`idequipo`) REFERENCES `equipo` (`idequipo`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_usuario_equipo_usuario` FOREIGN KEY (`idusuario`) REFERENCES `usuario` (`idusuario`) ON DELETE NO ACTION ON UPDATE NO ACTION;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
