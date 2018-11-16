using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace PalcoNet.Entidades
{
    public class Empresa
    {
        public string razon_social, cuit, mail, telefono, direccion_calle, direccion_depto, direccion_localidad, cod_postal, ciudad;
        public DateTime fecha_creacion;
        public int direccion_nro, direccion_piso, id_empresa;
        public int id_usuario;
        public Boolean baja_logica;
        public Empresa() {
            id_usuario = 0;
        }
    }
}
