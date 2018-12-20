using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace PalcoNet.Entidades
{
    public class ValidarTiposEntradas
    {

        internal static void numerico(string valorAChequear, string campoAValidar)
        {
            if (!(valorAChequear.All(caracter => Char.IsDigit(caracter)))) {
                throw new Exception("El campo " + campoAValidar + " debe ser númerico");
            }
        }
    }
}
