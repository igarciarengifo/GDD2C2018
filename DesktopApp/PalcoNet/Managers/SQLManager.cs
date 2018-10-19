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
    public class SQLManager
    {
        static SqlConnection connection = new SqlConnection(ConfigurationManager.AppSettings["ConnectionString"].ToString());

        public static DataTable ejecutarDataTableStoreProcedure(string stringCommand) { 
            return ejecutarDataTableStoreProcedure(stringCommand, null);
        }

        public static DataTable ejecutarDataTableStoreProcedure(string stringCommand, SQLArgumentosManager argManager)
        {
            SqlCommand spCommand = new SqlCommand(stringCommand, connection);
            spCommand.CommandType = CommandType.StoredProcedure;
            connection.Open();
            DataTable resultTable = new DataTable();
            try
            {
                if (argManager != null) {

                    spCommand.Parameters.Clear();
                    /*Itero sobre el Dictionary para agregar los parametros*/
                    foreach (KeyValuePair<string, object> entry in argManager.parametros)
                    {
                        spCommand.Parameters.Add(new SqlParameter(entry.Key, entry.Value));
                    }
                }
                
                resultTable.Load(spCommand.ExecuteReader());
            }
            finally {
                connection.Close();
            }
            return resultTable;
        }




        public static int ejecutarNonQuery(string stringComando, SQLArgumentosManager argManager)
        {
            SqlCommand spCommand = new SqlCommand(stringComando, connection);
            spCommand.CommandType = CommandType.StoredProcedure;
            connection.Open();
            try
            {
                if (argManager != null)
                {

                    spCommand.Parameters.Clear();
                    /*Itero sobre el Dictionary para agregar los parametros*/
                    foreach (KeyValuePair<string, object> entry in argManager.parametros)
                    {
                        spCommand.Parameters.Add(new SqlParameter(entry.Key, entry.Value));
                    }
                }

                int filasAfectadas = spCommand.ExecuteNonQuery();
            }
            finally
            {
                connection.Close();
            }
            return filasAfectadas;
        }
    }
}
