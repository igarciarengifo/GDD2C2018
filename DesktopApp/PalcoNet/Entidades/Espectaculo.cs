using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace PalcoNet.Entidades {

    public class Espectaculo {
        public string descripcion { get; set; }
        public DateTime fecha_publicacion;
        public int id_estado_publicacion, id_publicacion;
        public int id_rubro;
        public int id_espectaculo { get; set; }
      
    }
}
