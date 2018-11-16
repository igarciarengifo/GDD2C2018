﻿using PalcoNet.Entidades;
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
            nuevaUbicacion.id_tipo_ubicacion = Convert.ToInt32(row["id_tipo_ubicacion"]);
            return nuevaUbicacion;
        }

    }
}
