using PalcoNet.Entidades;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace PalcoNet.Managers
{
    public class Grados_Publicacion_Manager
    {

        public List<Grado_Publicacion> getAllGradosPublicacion()
        {
            DataTable resultTable = SQLManager.ejecutarDataTableStoreProcedure("LOOPP.SP_GetAllGradosPublicacion");
            List<Grado_Publicacion> lista_grados = new List<Grado_Publicacion>();
            if (resultTable != null && resultTable.Rows != null)
            {
                foreach (DataRow row in resultTable.Rows)
                {
                    var grado = BuildGradoPublicacion(row);
                    lista_grados.Add(grado);
                }
            }

            return lista_grados;
        }

        private Grado_Publicacion BuildGradoPublicacion(DataRow row)
        {
            Grado_Publicacion nuevoGrado = new Grado_Publicacion();
            nuevoGrado.id_grado_publicacion = Convert.ToInt32(row["id_estado_publicacion"]);
            nuevoGrado.prioridad = Convert.ToInt32(row["prioridad"]);
            nuevoGrado.comision = Convert.ToDouble(row["comision"]);
            nuevoGrado.descripcion = Convert.ToString(row["descripcion"]);
            return nuevoGrado;
        }
    }
}
