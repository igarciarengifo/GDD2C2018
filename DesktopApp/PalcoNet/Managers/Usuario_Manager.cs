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
    public class Usuario_Manager
    {
        public Usuario getUsuario(String usuario) {
            SqlConnection connection = new SqlConnection(ConfigurationManager.AppSettings["ConnectionString"].ToString());
            SqlCommand spCommand = new SqlCommand("CUATROGDD2018.SP_GetUsuario", connection);
            spCommand.CommandType = CommandType.StoredProcedure;
            connection.Open();
            spCommand.Parameters.Clear();
            //agrego parametros al SP_GetUsuario
            spCommand.Parameters.Add(new SqlParameter("@username", usuario));

            List<Usuario> usuariosEncontrados = new List<Usuario>();
            DataTable usuariosTable = new DataTable();
            usuariosTable.Load(spCommand.ExecuteReader());
            if (usuariosTable != null && usuariosTable.Rows != null)
            {
                foreach (DataRow row in usuariosTable.Rows)
                {
                    Usuario personaEncontrado = this.BuildUsuario(row);
                    usuariosEncontrados.Add(personaEncontrado);
                }
            }
            else {
                return null;
            }

            return usuariosEncontrados.ElementAt(0);

        }

        private Usuario BuildUsuario(DataRow row)
        {
            throw new NotImplementedException();
        }

        internal void reiniciarIntentos(int p)
        {
            throw new NotImplementedException();
        }

        internal void agregarIntentoFallido(int p)
        {
            throw new NotImplementedException();
        }
    }
}
