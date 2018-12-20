using PalcoNet.Entidades;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace PalcoNet.Managers
{
    public class Ubicaciones_Manager
    {
        public List<Ubicacion> getAllUbicaciones()
        {
            DataTable resultTable = SQLManager.ejecutarDataTableStoreProcedure("LOOPP.SP_GetAllUbicaciones");
            List<Ubicacion> lista_ubicaciones = new List<Ubicacion>();
            if (resultTable != null && resultTable.Rows != null)
            {
                foreach (DataRow row in resultTable.Rows)
                {
                    var ubicacion = BuildUbicacion(row);
                    lista_ubicaciones.Add(ubicacion);
                }
            }

            return lista_ubicaciones;
        }

        private Ubicacion BuildUbicacion(DataRow row)
        {
            Ubicacion nuevaUbicacion = new Ubicacion();
            nuevaUbicacion.id_ubicacion = Convert.ToInt32(row["id_ubicacion"]);
            nuevaUbicacion.fila = Convert.ToString(row["fila"]);
            nuevaUbicacion.asiento = Convert.ToString(row["asiento"]);
            nuevaUbicacion.sin_numerar = Convert.ToBoolean(row["sin_numerar"]);
            nuevaUbicacion.descripcion = Convert.ToString(row["descripcion"]);
            nuevaUbicacion.id_tipo_ubicacion = Convert.ToInt32(row["id_tipo_ubicacion"]);
            return nuevaUbicacion;
        }

        private Ubicacion_X_Espectaculo BuildUbicacionEspectaculo(DataRow row){
            Ubicacion_X_Espectaculo ubiXEsp = new Ubicacion_X_Espectaculo();
            ubiXEsp.id_espectaculo = Convert.ToInt32(row["id_espectaculo"]);
            ubiXEsp.id_ubicacion = Convert.ToInt32(row["id_ubicacion"]);
            ubiXEsp.precio = Convert.ToDouble(row["precio"]);
            return ubiXEsp;
        }

        internal List<Ubicacion> getUbicacionesEspectaculo(int id_espectaculo)
        {
            DataTable resultTable = SQLManager.ejecutarDataTableStoreProcedure("LOOPP.SP_GetUbicacionesEspectaculo",
                SQLArgumentosManager.nuevoParametro("@id_espectaculo", id_espectaculo));
            List<Ubicacion> lista_ubicaciones = new List<Ubicacion>();
            if (resultTable != null && resultTable.Rows != null)
            {
                foreach (DataRow row in resultTable.Rows)
                {
                    var ubicacion = BuildUbicacion(row);
                    lista_ubicaciones.Add(ubicacion);
                }
            }

            return lista_ubicaciones;
        }

        public List<Ubicacion> getUbicacionesEspectaculo(int id_espectaculo, string fecha, string hora, int id_tpUb) {
            DataTable resultTable = SQLManager.ejecutarDataTableStoreProcedure("LOOPP.SP_GetUbicacionesXEspec",
                                                SQLArgumentosManager.nuevoParametro("@id", id_espectaculo)
                                                            .add("@fecha", fecha)
                                                            .add("@hora", hora)
                                                            .add("@idTipoUbic", id_tpUb));
            List<Ubicacion> lista_ubicaciones = new List<Ubicacion>();
            if (resultTable != null && resultTable.Rows != null) {
                foreach (DataRow row in resultTable.Rows) {
                    Ubicacion ubicacion = new Ubicacion();
                    ubicacion.id_ubicacion = Convert.ToInt32(row["id_ubicacion"]);
                    ubicacion.descripcion = Convert.ToString(row["Ubicacion"]);
                    lista_ubicaciones.Add(ubicacion);
                }
            }

            return lista_ubicaciones;
        }
    }
}
