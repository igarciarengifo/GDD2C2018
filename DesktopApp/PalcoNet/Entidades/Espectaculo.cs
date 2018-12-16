using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace PalcoNet.Entidades {

    public class Espectaculo {
        public string descripcion { get; set; }
        public string direccion;
        public DateTime fecha_publicacion;
        public int id_estado_publicacion, id_grado_publicacion, id_usuario_responsable;
        public int id_rubro;
        public int id_espectaculo { get; set; }
        public Double precio_base;
      
    }
}
