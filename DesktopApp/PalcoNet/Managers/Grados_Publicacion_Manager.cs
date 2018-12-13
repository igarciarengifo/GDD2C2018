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

        public string nuevoGrado(Grado_Publicacion nuevoGrado)
        {

            return SQLManager.ejecutarEscalarQuery<string>("LOOPP.SP_NuevoGrado",
                                                  SQLArgumentosManager.nuevoParametro("@comision", nuevoGrado.comision)
                                                  .add("@descripcion", nuevoGrado.descripcion));

        }

         public string editarGrado(Grado_Publicacion gradoModificado)
         {

            return SQLManager.ejecutarEscalarQuery<string>("LOOPP.SP_ModificarGrado",
                                                  SQLArgumentosManager.nuevoParametro("@id", gradoModificado.id_grado_publicacion)
                                                  .add("@comision", gradoModificado.comision)
                                                  .add("@descripcion", gradoModificado.descripcion));

        }

        public string bajaGrado(Grado_Publicacion gradoBaja)
        {

            return SQLManager.ejecutarEscalarQuery<string>("LOOPP.SP_BajaLogicaGrado",
                                                  SQLArgumentosManager.nuevoParametro("@id", gradoBaja.id_grado_publicacion));

        }

        private Grado_Publicacion BuildGradoPublicacion(DataRow row)
        {
            Grado_Publicacion nuevoGrado = new Grado_Publicacion();
            nuevoGrado.id_grado_publicacion = Convert.ToInt32(row["id_grado_publicacion"]);
            nuevoGrado.comision = Convert.ToDouble(row["comision"]);
            nuevoGrado.activo = Convert.ToBoolean(row["activo"]);
            nuevoGrado.descripcion = Convert.ToString(row["descripcion"]);
            return nuevoGrado;
        }
    }
}
