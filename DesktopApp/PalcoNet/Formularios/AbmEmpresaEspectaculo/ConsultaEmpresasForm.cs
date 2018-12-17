using PalcoNet.Entidades;
using PalcoNet.Managers;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace PalcoNet.Formularios.AbmEmpresaEspectaculo
{
    public partial class ConsultaEmpresasForm : Form
    {
        Empresa_Manager empresaMng = new Empresa_Manager();
        public ConsultaEmpresasForm()
        {
            InitializeComponent();
            newEmpresaBtn.Enabled = false;
            updateBox.Enabled = false;
        }

        private void button5_Click(object sender, EventArgs e)
        {
            this.Dispose();
            this.Close();

        }

        private void filtrarBtn_Click(object sender, EventArgs e)
        {
            Empresa empresaABuscar = new Empresa();
            empresaABuscar.cuit = cuitBox.Text;
            empresaABuscar.razon_social = razonBox.Text;
            empresaABuscar.mail = emailBox.Text;
            //List<Empresa> empresasEncontradas = new List<Empresa>();
            DataTable empresasEncontradas = empresaMng.buscarEmpresas(empresaABuscar);
            if (empresasEncontradas.Rows.Count == 0)
            {
                MessageBox.Show("No se encontraron resultados.");
                newEmpresaBtn.Enabled = true;
            }
            else
            {

                dataEmpresas.DataSource = empresasEncontradas;
                updateBox.Enabled = true;

            }
        }

        private void newEmpresaBtn_Click(object sender, EventArgs e)
        {
            
            AltaEmpresaForm altaEmpresa = new AltaEmpresaForm(new Empresa());
            altaEmpresa.Show();
            this.Dispose();
            this.Close();
        }

        private void updateBox_Click(object sender, EventArgs e)
        {
            if (dataEmpresas.DataSource != null && dataEmpresas.SelectedRows.Count > 0)
            {
                foreach (DataGridViewRow row in dataEmpresas.SelectedRows)
                {
                    Empresa empresaSeleccionada = empresaMng.getEmpresaPorId(Int32.Parse(row.Cells[0].Value.ToString()));
                    AltaEmpresaForm editForm = new AltaEmpresaForm(empresaSeleccionada);
                    editForm.ShowDialog();
                    this.Dispose();
                    this.Close();
                }
            }
        }
    }
}
