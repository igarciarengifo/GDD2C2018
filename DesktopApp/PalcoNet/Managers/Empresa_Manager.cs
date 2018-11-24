using PalcoNet.Entidades;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace PalcoNet.Managers
{
    public class Empresa_Manager
    {
        public string altaEmpresaYUsuario(string user, string pass, Entidades.Empresa nuevaEmpresa)
        {
            DateTime fechaCreacion = Convert.ToDateTime(ConfigurationManager.AppSettings["FechaSistema"]);
           return SQLManager.ejecutarEscalarQuery<string> ("LOOPP.SP_NuevoEmpresa",
                                                 SQLArgumentosManager.nuevoParametro("@razon",nuevaEmpresa.razon_social)
                                                 .add("@cuit",nuevaEmpresa.cuit)
                                                 .add("@email",nuevaEmpresa.mail)
                                                 .add("@tel", nuevaEmpresa.telefono)
                                                 .add("@dir", nuevaEmpresa.direccion_calle)
                                                 .add("@dir_nro", nuevaEmpresa.direccion_nro)
                                                 .add("@dir_piso", nuevaEmpresa.direccion_piso)
                                                 .add("@dir_depto", nuevaEmpresa.direccion_depto)
                                                 .add("@localidad", nuevaEmpresa.direccion_localidad)
                                                 .add("@ciudad", nuevaEmpresa.ciudad)
                                                 .add("@codPostal", nuevaEmpresa.cod_postal)
                                                 .add("@user", user)
                                                 .add("@pass", pass)
                                                 .add("@fec_creacion", fechaCreacion));
        }

        public List<Empresa> buscarEmpresas(Empresa empresaABuscar)
        {
            DataTable resultTable = SQLManager.ejecutarDataTableStoreProcedure("LOOPP.SP_FiltrarEmpresas",
                                            SQLArgumentosManager.nuevoParametro("@cuit", empresaABuscar.cuit)
                                            .add("@razon_soc", empresaABuscar.razon_social)
                                            .add("@email", empresaABuscar.mail));

            List<Empresa> empresasEncontradas = new List<Empresa>();

            if (resultTable != null && resultTable.Rows != null)
            {
                foreach (DataRow row in resultTable.Rows)
                {
                    Empresa empresaEncontrada = this.BuildEmpresa(row);
                    empresasEncontradas.Add(empresaEncontrada);
                }
            }

            return empresasEncontradas;
        }

        public List<Empresa> getAllEmpresasActivas() {
            DataTable resultTable = SQLManager.ejecutarDataTableStoreProcedure("LOOPP.SP_AllEmpresasActivas");
            List<Empresa> lista_Empresas = new List<Empresa>();

            if (resultTable != null && resultTable.Rows != null) {

                foreach (DataRow row in resultTable.Rows) {
                    Empresa empresa = new Empresa();
                    empresa.id_empresa = int.Parse(row["id_empresa"].ToString());
                    empresa.razon_social = row["razon_social"].ToString();
                    lista_Empresas.Add(empresa);
                }
            }

            return lista_Empresas;
        }

        private Empresa BuildEmpresa(DataRow row)
        {
            Empresa empresa = new Empresa();
            empresa.id_empresa = int.Parse(row["id_empresa"].ToString());
            empresa.razon_social = row["razon_social"].ToString();
            empresa.mail = row["mail"].ToString();
            empresa.cuit = row["cuit"].ToString();
            empresa.telefono = row["telefono"].ToString();
            empresa.direccion_calle = row["direccion_calle"].ToString();
            empresa.direccion_nro = int.Parse(row["direccion_nro"].ToString());
            empresa.direccion_piso = int.Parse(row["direccion_piso"].ToString());
            empresa.direccion_depto = row["direccion_depto"].ToString();
            empresa.direccion_localidad = row["direccion_localidad"].ToString();
            empresa.cod_postal = row["cod_postal"].ToString();
            empresa.ciudad = row["ciudad"].ToString();
            empresa.baja_logica = (Boolean)row["baja_logica"];
            return empresa;
        }
    }
}
