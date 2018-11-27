using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using PalcoNet.Entidades;
using PalcoNet.Managers;

namespace PalcoNet.Formularios.GenerarRendicionComisiones {
    public partial class FacturaForm : Form {
        public FacturaForm(Factura fact) {
            InitializeComponent();
            this.cargar_datos(fact);
            this.cargar_datos_grilla(fact.nro_factura);
        }
        Compra_Manager compraMngr = new Compra_Manager();

        private void cargar_datos(Factura fact) {
            txtNumeroFac.Text = Convert.ToString(fact.nro_factura);
            txtTotal.Text = Convert.ToString(fact.importe_total);
            textFecha.Text = Convert.ToString(fact.fecha_factura);
            txtComision.Text = Convert.ToString(fact.importe_comision);
            txtEmpresa.Text = Convert.ToString(fact.empresa);          
        }

        private void cargar_datos_grilla(int nro_factura) {
            DataTable grados = compraMngr.getItemsFactura(nro_factura);
            dataGridView1.DataSource = grados;
        }

        private void btnSalir_Click(object sender, EventArgs e) {
            this.Dispose();
            this.Close();
        }

      
    }
}
