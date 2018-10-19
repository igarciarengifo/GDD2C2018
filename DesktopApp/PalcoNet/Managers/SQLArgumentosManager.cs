using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace PalcoNet.Managers
{
    public  class SQLArgumentosManager
    {
        public  Dictionary <string, object> parametros;
        public SQLArgumentosManager(string nombre, object valor){
            parametros = new Dictionary<string, object>();
            parametros.Add(nombre, valor);
        }

        public static SQLArgumentosManager nuevoParametro (string nombre, object valor) {
            return new SQLArgumentosManager(nombre, valor);
        }

        public SQLArgumentosManager add(string nombre, object valor) {
            parametros.Add(nombre, valor);
            return this;
        }
    }
}
