using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace PalcoNet.Entidades
{
    public class Factura {

        public int nro_factura;
        public int id_cliente { get; set; }
        public int importe_total { get; set; }
        public decimal importe_comision { get; set; }
        public int cantidad_compra;
        public string empresa { get; set; }
        public DateTime fecha_factura { get; set; }

    }
}
