using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using PalcoNet.Entidades;
using System.Data;
using System.Data.SqlClient;

namespace PalcoNet.Managers {
    class Grado_Manager {

        public List<Grado> getAllGrados() {
            DataTable resultTable = SQLManager.ejecutarDataTableStoreProcedure("LOOPP.SP_GetAllGradosPublicacion");
            var lista_grados = new List<Grado>();
            if (resultTable != null && resultTable.Rows != null)
            {
                foreach (DataRow row in resultTable.Rows)
                {
                    var grado = BuildGrado(row);
                    lista_grados.Add(grado);
                }
            }

            return lista_grados;
        }

        public string nuevoGrado(Grado nuevoGrado) {

            return SQLManager.ejecutarEscalarQuery<string>("LOOPP.SP_NuevoGrado",
                                                  SQLArgumentosManager.nuevoParametro("@comision", nuevoGrado.comision)
                                                  .add("@descripcion", nuevoGrado.descripcion));

        }

        public string editarGrado(Grado gradoModificado) {

            return SQLManager.ejecutarEscalarQuery<string>("LOOPP.SP_ModificarGrado",
                                                  SQLArgumentosManager.nuevoParametro("@id", gradoModificado.id_grado)
                                                  .add("@comision", gradoModificado.comision)
                                                  .add("@descripcion", gradoModificado.descripcion));

        }

        public string bajaGrado(Grado gradoBaja) {

            return SQLManager.ejecutarEscalarQuery<string>("LOOPP.SP_BajaLogicaGrado",
                                                  SQLArgumentosManager.nuevoParametro("@id", gradoBaja.id_grado));

        }

        private Grado BuildGrado(DataRow row) {
            Grado nuevoGrado = new Grado();
            nuevoGrado.id_grado = Convert.ToInt32(row["id_grado_publicacion"]);
            nuevoGrado.descripcion = Convert.ToString(row["descripcion"]);
            nuevoGrado.comision = Convert.ToDecimal(row["comision"]);
            nuevoGrado.estado = Convert.ToBoolean(row["activo"]);

            return nuevoGrado;
        }
    }
}
