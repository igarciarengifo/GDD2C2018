using PalcoNet.Entidades;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace PalcoNet.Managers
{
    public class FormaPago_Manager
    {
        internal List<Forma_Pago> getFormasPagosValidas()
        {
            DataTable resultTable = SQLManager.ejecutarDataTableStoreProcedure("LOOPP.SP_GetFormasPagoValidas");

            List<Forma_Pago> lista_pagos = new List<Forma_Pago>();
            if (resultTable != null && resultTable.Rows != null)
            {
                foreach (DataRow row in resultTable.Rows)
                {
                    Forma_Pago formaPago = BuildFormaPago(row);
                    lista_pagos.Add(formaPago);
                }
            }

            return lista_pagos;       
        }

        private Forma_Pago BuildFormaPago(DataRow row)
        {
            Forma_Pago pago = new Forma_Pago();
            pago.id_forma_pago = int.Parse(row["id_forma_pago"].ToString());
            pago.descripcion = row["descripcion"].ToString();
            pago.marca = row["marca"].ToString();
            return pago;
        }
    }
}
