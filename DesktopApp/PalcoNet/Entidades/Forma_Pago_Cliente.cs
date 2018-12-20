using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace PalcoNet.Entidades
{
    public class Forma_Pago_Cliente
    {
        public Int64 nro_tarjeta { get; set; }
        public int id_forma_pago { get; set; }
        public int id_forma_pago_cliente { get; set; }
        public int id_cliente { get; set; }
        public string marca { get; set; }
    }
}
