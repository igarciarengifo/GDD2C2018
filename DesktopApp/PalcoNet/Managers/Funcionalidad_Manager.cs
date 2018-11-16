using PalcoNet.Entidades;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace PalcoNet.Managers
{
    public class Funcionalidad_Manager
    {
        public List<Funcionalidad> funcionalidadesXRol(int id_rol)
        {
            DataTable resultTable = SQLManager.ejecutarDataTableStoreProcedure("LOOPP.SP_Funcionalidad_X_Rol", 
                                        SQLArgumentosManager.nuevoParametro("@id_rol", id_rol));
            var lista_funcionalidades = new List<Funcionalidad>();
            if (resultTable != null && resultTable.Rows != null)
            {
                foreach (DataRow row in resultTable.Rows)
                {
                    var funcionalidad = BuildFuncionalidad(row);
                    lista_funcionalidades.Add(funcionalidad);
                }
            }

            return lista_funcionalidades;
        }

        private Funcionalidad BuildFuncionalidad(DataRow row)
        {
            Funcionalidad func = new Funcionalidad();
            func.id_funcionalidad = Convert.ToInt32(row["id_funcionalidad"]);
            func.nombre = Convert.ToString(row["nombre"]);
            return func;
        }
    }

        
}
