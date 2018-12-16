using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace PalcoNet.Entidades
{
    public class Ubicacion
    {
        public int id_ubicacion  { get; set; }
        public int id_tipo_ubicacion  { get; set; }
        public string fila  { get; set; }
        public string asiento  { get; set; }
        public Boolean sin_numerar  { get; set; }
        public string descripcion { get; set; }
    }
}
