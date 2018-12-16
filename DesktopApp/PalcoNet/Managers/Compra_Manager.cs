using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using PalcoNet.Entidades;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;

namespace PalcoNet.Managers {
    public class Compra_Manager {

        private Factura buildCompra(DataRow row) {
            Factura nuevoFactura = new Factura();
            nuevoFactura.nro_factura = Convert.ToInt32(row["nro_factura"]);
            nuevoFactura.importe_total = Convert.ToInt32(row["total_factura"]);
            nuevoFactura.importe_comision = Convert.ToDecimal(row["total_comision"]);
            nuevoFactura.empresa = Convert.ToString(row["razon_social"]);
            nuevoFactura.fecha_factura = Convert.ToDateTime(row["fecha_factura"]);

            return nuevoFactura;
        }

        public Factura generarRendicion(int id_empresa, int id_espectaculo, int cantidad) {
            DataTable resultTable = SQLManager.ejecutarDataTableStoreProcedure("LOOPP.SP_GenerarRendicionComision",
                                            SQLArgumentosManager.nuevoParametro("@idEmpresa", id_empresa)
                                            .add("@idEspectaculo", id_espectaculo)
                                            .add("@cantidad", id_espectaculo));
            Factura factura = new Factura();

            if (resultTable != null && resultTable.Rows != null) {
                foreach (DataRow row in resultTable.Rows) {
                    Factura item = buildCompra(row);
                    factura = item;
                    break;
                }
            }
            return factura;
        }

        public DataTable getItemsFactura(int nro_factura) {
            DataTable resultTable = SQLManager.ejecutarDataTableStoreProcedure("LOOPP.SP_DevuelveItemsPorIdFactura",
                                            SQLArgumentosManager.nuevoParametro("@idFactura", nro_factura));         
            return resultTable;
        }

        public List<Grado_Publicacion> getAllGrados()
        {
            DataTable resultTable = SQLManager.ejecutarDataTableStoreProcedure("LOOPP.SP_GetAllGradosPublicacion");
            var lista_grados = new List<Grado_Publicacion>();
            if (resultTable != null && resultTable.Rows != null)
            {
                foreach (DataRow row in resultTable.Rows)
                {
                   // var grado = BuildGrado(row);
                    //lista_grados.Add(grado);
                }
            }

            return lista_grados;
        }
    }
}
