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
    class Compra_Manager {

        private Compra buildCompra(DataRow row) {
            Compra nuevoCompra = new Compra();
            nuevoCompra.id_compra = Convert.ToInt32(row["id_compra"]);
            //nuevoCompra.id_cliente = Convert.ToInt32(row["id_rol"]);
            nuevoCompra.importe_total = Convert.ToInt32(row["Importe Total"]);
            //nuevoCompra.cantidad_compra = Convert.ToInt32(row["id_rol"]);
            //nuevoCompra.medio_pago = Convert.ToString(row["nombre"]);
            nuevoCompra.entrada = Convert.ToString(row["Espectaculo"]);
            nuevoCompra.fecha_compra = Convert.ToDateTime(row["Fecha Compra"]);

            return nuevoCompra;
        }

        public List<Compra> getComprasPorEmpEsp(int id_empresa, int id_espectaculo) {
            DataTable resultTable = SQLManager.ejecutarDataTableStoreProcedure("LOOPP.SP_AllComprasPorEmpresa",
                                            SQLArgumentosManager.nuevoParametro("@idEmpresa", id_empresa)
                                            .add("@idEspectaculo", id_espectaculo));
            List<Compra> lista_compras = new List<Compra>();

            if (resultTable != null && resultTable.Rows != null) {
                foreach (DataRow row in resultTable.Rows) {
                    var compra = buildCompra(row);
                    lista_compras.Add(compra);
                }
            }
            return lista_compras;
        }
    }
}
