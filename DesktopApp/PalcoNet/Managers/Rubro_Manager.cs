using PalcoNet.Entidades;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace PalcoNet.Managers
{
    public class Rubro_Manager
    {
        public List<Rubro> getAllRubros()
        {
            DataTable resultTable = SQLManager.ejecutarDataTableStoreProcedure("LOOPP.SP_GetAllRubros");
            List<Rubro> lista_rubros = new List<Rubro>();
            if (resultTable != null && resultTable.Rows != null) {
                foreach (DataRow row in resultTable.Rows) {
                    Rubro rubro = BuildRubro(row);
                    lista_rubros.Add(rubro);
                }
            }

            return lista_rubros;
        }

        private Rubro BuildRubro(DataRow row)
        {
            Rubro nuevoRubro = new Rubro();
            nuevoRubro.id_rubro = Convert.ToInt32(row["id_rubro"]);
            nuevoRubro.descripcion = Convert.ToString(row["descripcion"]);
            return nuevoRubro;
        }
    }
}
