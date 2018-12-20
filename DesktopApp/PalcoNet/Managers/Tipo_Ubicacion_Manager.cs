using PalcoNet.Entidades;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace PalcoNet.Managers
{
    public class Tipo_Ubicacion_Manager
    {
        internal List<Tipo_Ubicacion> getAllTiposUbicacion()
        {
            DataTable resultTable = SQLManager.ejecutarDataTableStoreProcedure("LOOPP.SP_GetAllTiposUbicacion");
            List<Tipo_Ubicacion> lista_tipos = new List<Tipo_Ubicacion>();
            if (resultTable != null && resultTable.Rows != null)
            {
                foreach (DataRow row in resultTable.Rows)
                {
                    var tipo = BuildTipoUbicacion(row);
                    lista_tipos.Add(tipo);
                }
            }

            return lista_tipos;
        }

        public List<Tipo_Ubicacion> getTiposUbicacionXEspec(int id_espectaculo, string fecha, string hora)
        {
            DataTable resultTable = SQLManager.ejecutarDataTableStoreProcedure("LOOPP.SP_GetTipoUbicXEspect",
                                                SQLArgumentosManager.nuevoParametro("@id", id_espectaculo)
                                                            .add("@fecha", fecha)
                                                            .add("@hora", hora));
            List<Tipo_Ubicacion> lista_tipos = new List<Tipo_Ubicacion>();
            if (resultTable != null && resultTable.Rows != null)
            {
                foreach (DataRow row in resultTable.Rows)
                {
                    var tipo = BuildTipoUbicacion(row);
                    lista_tipos.Add(tipo);
                }
            }

            return lista_tipos;
        }

        private Tipo_Ubicacion BuildTipoUbicacion(DataRow row)
        {
            Tipo_Ubicacion nuevoTipo = new Tipo_Ubicacion();
            nuevoTipo.id_tipo_ubicacion = Convert.ToInt32(row["id_tipo_ubicacion"]);
            nuevoTipo.porcentual = Convert.ToDouble(row["porcentual"]);
            nuevoTipo.descripcion = Convert.ToString(row["descripcion"]);
            return nuevoTipo;
        }
    }
}
