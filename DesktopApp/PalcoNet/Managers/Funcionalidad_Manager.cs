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
            SqlConnection sqlConnection = new SqlConnection(ConfigurationManager.AppSettings["ConnectionString"].ToString());
            SqlCommand spCommand = new SqlCommand("LOOPP.SP_Funcionalidad_X_Rol", sqlConnection);
            spCommand.CommandType = CommandType.StoredProcedure;
            sqlConnection.Open();
            var lista_funcionalidades = new List<Funcionalidad>();
            DataTable resultTable = new DataTable();
            resultTable.Load(spCommand.ExecuteReader());

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
            func.descripcion = Convert.ToString(row["descripcion"]);
            return func;
        }
    }

        
}
