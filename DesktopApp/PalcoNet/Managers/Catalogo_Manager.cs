using PalcoNet.Entidades;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace PalcoNet.Managers
{
    public class Catalogo_Manager
    {

        internal DataTable getCatalogo()
        {
           return SQLManager.ejecutarDataTableStoreProcedure("LOOPP.SP_GetCatalogo");

        }

        internal string canjearProducto(int idProducto, int id_usuario)
        {
            string resultado = SQLManager.ejecutarEscalarQuery<string>("LOOPP.SP_CanjearProducto",
                                    SQLArgumentosManager.nuevoParametro("@idProducto", idProducto)
                                    .add("@idUsuario", id_usuario)
                                    .add("@fechaCanje", DatosSesion.getFechaSistema()));
            string[] resultadoArray = resultado.Split(';');
            if (resultadoArray.ElementAt(0).Equals("OK"))
            {
                return resultadoArray.ElementAt(1);
            }
            else {
                throw new Exception(resultadoArray.ElementAt(1));
            }
        }
    }
}
