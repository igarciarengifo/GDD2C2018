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
            DataTable resultTable = SQLManager.ejecutarDataTableStoreProcedure("LOOPP.SP_GetAllRoles");
            var lista_Roles = new List<Rol>();
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
            nuevoRol.estado = Convert.ToBoolean(row["baja_logica"]);

            return nuevoRol;
        }

        public List<Rol> getAllRolesHabilitados()
        {
            DataTable resultTable =  SQLManager.ejecutarDataTableStoreProcedure("LOOPP.SP_GetAllRolesHab");
            var lista_Roles = new List<Rol>();
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

        public List<Rol> getRolesConIDUsuario(int id_usuario)
        {
            DataTable resultTable = SQLManager.ejecutarDataTableStoreProcedure("LOOPP.SP_GetRolesIDUser",
                                        SQLArgumentosManager.nuevoParametro("@id_user", id_usuario));

            List<Rol> rolesEncontrados = new List<Rol>();

            if (resultTable != null && resultTable.Rows != null)
            {
                foreach (DataRow row in resultTable.Rows)
                {
                    Rol rolEncontrado = this.BuildRol(row);
                    rolesEncontrados.Add(rolEncontrado);
                }
            }
           
            return rolesEncontrados;
        }

        public int habilitarRol(int id_rol) {
            return (SQLManager.ejecutarNonQuery("LOOPP.SP_HabilitarRol",
                                        SQLArgumentosManager.nuevoParametro("@idRol", id_rol)));
        }

        public int deshabilitarRol(int id_rol) {
            return (SQLManager.ejecutarNonQuery("LOOPP.SP_InhabilitarRol",
                                        SQLArgumentosManager.nuevoParametro("@idRol", id_rol)));
        }

        public string nuevoRol(Rol nuevoRol) {
            return SQLManager.ejecutarEscalarQuery<string>("LOOPP.SP_AltaNuevoRol",
                                                  SQLArgumentosManager.nuevoParametro("@nombre", nuevoRol.nombre));

        }

        public string modificarRol(int id_rol, string descripcion) {
            return SQLManager.ejecutarEscalarQuery<string>("LOOPP.SP_ModificarDescRol",
                                        SQLArgumentosManager.nuevoParametro("@idRol", id_rol)
                                        .add("@descripcion", descripcion));
        }
    }
}
