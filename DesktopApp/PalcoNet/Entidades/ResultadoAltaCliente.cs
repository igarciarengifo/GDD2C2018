using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace PalcoNet.Entidades
{
    public class ResultadoAltaCliente
    {
        public int id_cliente { get; set; }
        public int id_usuario { get; set; }
        public string resultadoCliente { get; set; }
        public string resultadoTarjeta { get; set; }
        public string username { get; set; }
        public string password { get; set; }
    }
}
