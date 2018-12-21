using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using PalcoNet.Managers;
using PalcoNet.Entidades;

namespace PalcoNet.Formularios.GenerarRendicionComisiones
{
    public partial class RendicionComisionesForm : Form {

        public RendicionComisionesForm() {
            InitializeComponent();
            this.cargarEmpresasCmb();
        }
        Empresa_Manager mngrEmpresa = new Empresa_Manager();
        Espectaculo_Manager mngrEspectaculo = new Espectaculo_Manager();
        Compra_Manager mngrCompra = new Compra_Manager();

        private void cargarEmpresasCmb() {
            List<Empresa> empresas = new List<Empresa>();
            empresas = mngrEmpresa.getAllEmpresasActivas();
            cmbEmpresa.DisplayMember = "razon_social";
            cmbEmpresa.ValueMember = "id_empresa";
            cmbEmpresa.DataSource = mngrEmpresa.getAllEmpresasActivas();
        }

        private void btnSalir_Click(object sender, EventArgs e) {
            this.Dispose();
            this.Close();
        }

        private void cmbEmpresa_SelectedIndexChanged(object sender, EventArgs e) {
            List<Espectaculo> espectaculos = new List<Espectaculo>();
            int idEmpresa = (int)cmbEmpresa.SelectedValue;

            espectaculos = mngrEspectaculo.getEspectaculosPorEmpresa(idEmpresa);
            cmbEspectaculo.DisplayMember = "descripcion";
            cmbEspectaculo.ValueMember = "id_espectaculo";
            cmbEspectaculo.DataSource = espectaculos;
        }

        private void verificarCamposObligatorios() {
            if ((cmbEmpresa.SelectedValue == null) || (cmbEspectaculo.SelectedValue == null) 
                                                   || (String.IsNullOrEmpty(txtCantidad.Text))) {
                throw new ArgumentException("Debe completar los datos requeridos");
            }
        }
        private void validarTiposCampos()
        {
            ValidarTiposEntradas.numerico(txtCantidad.Text, "Cantidad");

        }

        private void btnComision_Click(object sender, EventArgs e) {
            this.verificarCamposObligatorios();
            this.validarTiposCampos();
            int idEmpresa = (int)cmbEmpresa.SelectedValue;
            int idEspectaculo = (int)cmbEspectaculo.SelectedValue;
            int cantidad = Convert.ToInt32(txtCantidad.Text);
            Factura factura = mngrCompra.generarRendicion(idEmpresa, idEspectaculo, cantidad);
            FacturaForm facturaForm = new FacturaForm(factura);
            facturaForm.ShowDialog();
            this.Dispose();
            this.Close();
        }
    }
}
