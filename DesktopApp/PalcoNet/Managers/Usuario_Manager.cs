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
            DataTable resultTable = SQLManager.ejecutarDataTableStoreProcedure("LOOPP.SP_GetUsuario",
                                        SQLArgumentosManager.nuevoParametro("@username", usuario));

            List<Usuario> usuariosEncontrados = new List<Usuario>();

            if (resultTable != null && resultTable.Rows != null)
            {
                foreach (DataRow row in resultTable.Rows)
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
            Usuario nuevoUsuario = new Usuario();
            nuevoUsuario.id_usuario = Convert.ToInt32(row["id_usuario"]);
            nuevoUsuario.username = Convert.ToString(row["username"]);
            nuevoUsuario.password = Convert.ToString(row["password"]);
            nuevoUsuario.esta_habilitado = Convert.ToBoolean(row["esta_habilitado"]);
            return nuevoUsuario;
        }

        public int reiniciarIntentos(int id_user)
        {
            /*las NO Query retorna cantidad de filas afectadas*/
            return (SQLManager.ejecutarNonQuery("LOOPP.SP_ReiniciarIntentosLogin",
                                        SQLArgumentosManager.nuevoParametro("@id_user", id_user)));
            
        }

        public int agregarIntentoFallido(int id_user)
        {
            /*las NO Query retorna cantidad de filas afectadas*/
            return (SQLManager.ejecutarNonQuery("LOOPP.SP_NuevoIntentoFallido",
                                        SQLArgumentosManager.nuevoParametro("@id_user", id_user)));
        }

    }
}
