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
            cmbEmpresa.DataSource = empresas;
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

        private void btnFiltrar_Click(object sender, EventArgs e) {
            this.verificarCamposObligatorios();
            int idEmpresa = (int)cmbEmpresa.SelectedValue;
            int idEspectaculo = (int)cmbEspectaculo.SelectedValue;
            List<Compra> compras = new List<Compra>();
            compras = mngrCompra.getComprasPorEmpEsp(idEmpresa, idEspectaculo);

            if (compras.Count > 0) {
                dataGridView1.DataSource = compras;
            } else {
                MessageBox.Show("No se encontraron resultados.");

            }
        }

        private void verificarCamposObligatorios() {
            if (cmbEmpresa.SelectedValue == null) {
                throw new ArgumentException("Debe completar los datos requeridos");
            }
        }
    }
}
