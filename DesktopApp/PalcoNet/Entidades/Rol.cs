using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace PalcoNet.Entidades
{
    public class Rol
    {
        public int id_rol { get; set; }
        public string nombre { get; set; }
        public bool estado { get; set; }
        public List<Funcionalidad> lista_funcionalidades { get; set; }

        public Rol()
        {
            lista_funcionalidades = new List<Funcionalidad>();
        }
    }
}
