using PalcoNet.Entidades;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace PalcoNet.Managers {
    class Espectaculo_Manager {

        public List<Espectaculo> getEspectaculosPorEmpresa(int id_empresa) {
            DataTable resultTable = SQLManager.ejecutarDataTableStoreProcedure("LOOPP.SP_AllEspectaculosPorIdEmpresa",
                                        SQLArgumentosManager.nuevoParametro("@idEmpresa", id_empresa));

            List<Espectaculo> espectaculos = new List<Espectaculo>();

            if (resultTable != null && resultTable.Rows != null) {

                foreach (DataRow row in resultTable.Rows) {
                    Espectaculo especItem = new Espectaculo();
                    especItem.id_espectaculo = int.Parse(row["id_espectaculo"].ToString());
                    especItem.descripcion = row["descripcion"].ToString();
                    espectaculos.Add(especItem);
                }
            }

            return espectaculos;
        }
    }
}
