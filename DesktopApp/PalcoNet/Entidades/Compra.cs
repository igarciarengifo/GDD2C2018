using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace PalcoNet.Entidades
{
    public class Compra {
        public int id_compra, importe_total, cantidad_compra;
        public int id_cliente { get; set; }
        public int id_medio_pago { get; set; }
        public string medio_pago { get; set; }
        public string listUbicaciones { get; set; }
        public int id_espectaculo { get; set; }
        public string entrada;
        public DateTime fecha_compra;
    }
}
