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
            List<Funcionalidad> lista_funcionalidades = new List<Funcionalidad>();
            if (resultTable != null && resultTable.Rows != null)
            {
                foreach (DataRow row in resultTable.Rows)
                {
                    Funcionalidad funcionalidad = BuildFuncionalidad(row);
                    lista_funcionalidades.Add(funcionalidad);
                }
            }

            return lista_funcionalidades;
        }

        public List<Funcionalidad> getAllFuncionalidades() {
            DataTable resultTable = SQLManager.ejecutarDataTableStoreProcedure("LOOPP.SP_GetAllFuncionalidad");
            List<Funcionalidad> lista_funcionalidades = new List<Funcionalidad>();
            if (resultTable != null && resultTable.Rows != null) {
                foreach (DataRow row in resultTable.Rows) {
                    Funcionalidad funcionalidad = BuildFuncionalidad(row);
                    lista_funcionalidades.Add(funcionalidad);
                }
            }

            return lista_funcionalidades;
        }

        public string deshabilitarFuncsXRol(int id_rol) {

            return SQLManager.ejecutarEscalarQuery<string>("LOOPP.SP_InhabilitarFunc_X_idRol",
                                                  SQLArgumentosManager.nuevoParametro("@id_rol ", id_rol));

        }

        public string nuevaFuncXRol(int id_rol, int id_funcionalidad) {

            return SQLManager.ejecutarEscalarQuery<string>("LOOPP.SP_AgregarFuncRol",
                                                  SQLArgumentosManager.nuevoParametro("@idRol", id_rol)
                                                  .add("@idFunc", id_funcionalidad));
        }

        private Funcionalidad BuildFuncionalidad(DataRow row) {
            Funcionalidad func = new Funcionalidad();
            func.id_funcionalidad = int.Parse(row["id_funcionalidad"].ToString());
            func.nombre = row["nombre"].ToString();
            return func;
        }
    }

        
}
