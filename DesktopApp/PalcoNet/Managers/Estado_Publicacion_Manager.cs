using PalcoNet.Entidades;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace PalcoNet.Managers
{
    public class Estado_Publicacion_Manager
    {
        public List<Estado_Publicacion> getAllEstadosPublicacion()
        {
            DataTable resultTable = SQLManager.ejecutarDataTableStoreProcedure("LOOPP.SP_GetAllEstadosPublicacion");
            List<Estado_Publicacion> lista_estados = new List<Estado_Publicacion>();
            if (resultTable != null && resultTable.Rows != null)
            {
                foreach (DataRow row in resultTable.Rows)
                {
                    var estado = BuildEstadoPublicacion(row);
                    lista_estados.Add(estado);
                }
            }

            return lista_estados;
        }

        private Estado_Publicacion BuildEstadoPublicacion(DataRow row)
        {
            Estado_Publicacion nuevoEstado = new Estado_Publicacion();
            nuevoEstado.id_estado_publicacion = Convert.ToInt32(row["id_estado_publicacion"]);
            nuevoEstado.descripcion = Convert.ToString(row["descripcion"]);
            return nuevoEstado;
        }
    }
}
