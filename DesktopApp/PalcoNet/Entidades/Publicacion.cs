using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace PalcoNet.Entidades
{
    public class Publicacion
    {
        int id_espectaculo, id_usuario_responsable, id_rubro, id_estado_publicacion, id_grado_publicacion;
        DateTime fecha_publicacion;
        String descripcion, direccion;
        Double precio_base;
    }
}
