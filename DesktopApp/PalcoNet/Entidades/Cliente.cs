using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace PalcoNet.Entidades
{
    public class Cliente
    {
        public int id_cliente, puntos, nro_documento, id_usuario;
        public Boolean esta_habilitado;
        public string nombre, apellido, tipo_documento, cuil, mail, telefono, direccion_calle, direccion_nro, direccion_piso, direccion_depto, direccion_localidad, codigo_postal;
        public DateTime fecha_nacimiento, fecha_creacion;

    }
}
