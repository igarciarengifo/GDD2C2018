using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace PalcoNet.Entidades
{
    public class Cliente
    {
        public int id_cliente, puntos,id_usuario, direccion_nro ;
        public Int64 nro_documento;
        public Nullable<int> direccion_piso;
        public string estado;
        public Boolean baja_logica;
        public string nombre, apellido, tipo_documento, cuil, mail, telefono, direccion_calle, direccion_depto, direccion_localidad, codigo_postal;
        public DateTime fecha_nacimiento, fecha_creacion;

    }
}
