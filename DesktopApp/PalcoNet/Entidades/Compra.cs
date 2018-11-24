using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace PalcoNet.Entidades
{
    public class Compra {
        public int id_compra, id_cliente, importe_total, cantidad_compra;
        public string medio_pago, entrada;
        public DateTime fecha_compra;
    }
}
