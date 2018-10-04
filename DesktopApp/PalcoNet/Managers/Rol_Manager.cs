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
    class Rol_Manager
    {
        public List<Rol> getAllRoles()
        {
            SqlConnection sqlConnection = new SqlConnection(ConfigurationManager.AppSettings["ConnectionString"].ToString());
            SqlCommand spCommand = new SqlCommand("LOOPP.SP_GetAllRoles", sqlConnection);
            spCommand.CommandType = CommandType.StoredProcedure;
            sqlConnection.Open();
            var lista_Roles = new List<Rol>();
            DataTable resultTable = new DataTable();
            resultTable.Load(spCommand.ExecuteReader());

            if (resultTable != null && resultTable.Rows != null)
            {
                foreach (DataRow row in resultTable.Rows)
                {
                    var rol = BuildRol(row);
                    lista_Roles.Add(rol);
                }
            }

            return lista_Roles;
        }

        private Rol BuildRol(DataRow row)
        {
            Rol nuevoRol = new Rol();
            nuevoRol.id_rol = Convert.ToInt32(row["id_rol"]);
            nuevoRol.nombre = Convert.ToString(row["nombre"]);
            nuevoRol.estado = Convert.ToBoolean(row["estado"]);

            return nuevoRol;
        }

        public List<Rol> getAllRolesHabilitados()
        {
            SqlConnection sqlConnection = new SqlConnection(ConfigurationManager.AppSettings["ConnectionString"].ToString());
            SqlCommand spCommand = new SqlCommand("LOOPP.SP_GetAllRolesHab", sqlConnection);
            spCommand.CommandType = CommandType.StoredProcedure;
            sqlConnection.Open();
            var lista_Roles = new List<Rol>();
            DataTable resultTable = new DataTable();
            resultTable.Load(spCommand.ExecuteReader());

            if (resultTable != null && resultTable.Rows != null)
            {
                foreach (DataRow row in resultTable.Rows)
                {
                    var rol = BuildRol(row);
                    lista_Roles.Add(rol);
                }
            }

            return lista_Roles;
        }
    }
}
