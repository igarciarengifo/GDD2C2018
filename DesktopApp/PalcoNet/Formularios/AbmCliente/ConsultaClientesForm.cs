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

namespace PalcoNet.Formularios.AbmCliente
{
    public partial class ConsultaClientesForm : Form
    {
        Cliente_Manager clienteMng = new Cliente_Manager();
        public ConsultaClientesForm()
        {
            InitializeComponent();
            newBtn.Enabled = false;
            updateBtn.Enabled = false;

        }

        private void filtrarBtn_Click(object sender, EventArgs e)
        {
            Cliente clienteABuscar = new Cliente();
            clienteABuscar.nombre = nameBox.Text;
            clienteABuscar.apellido = lastNameBox.Text;
            clienteABuscar.mail = emailBox.Text;
            if (string.IsNullOrEmpty(nroDocBox.Text))
            {
                clienteABuscar.nro_documento = 0;
            }
            else {
                clienteABuscar.nro_documento = Int32.Parse(nroDocBox.Text);
            }
            //List<Cliente> clientesEncontrados = new List<Cliente>();

            DataTable clientesEncontrados = clienteMng.buscarClientes(clienteABuscar);
            if (clientesEncontrados.Rows.Count == 0)
            {
                MessageBox.Show("No se encontraron resultados.");
                newBtn.Enabled = true;
            }
            else
            {

                dataClientes.DataSource = clientesEncontrados;
                updateBtn.Enabled = true;

            }
        }

        private void exitBtn_Click(object sender, EventArgs e)
        {
            this.Dispose();
            this.Close();
        }

        private void newBtn_Click(object sender, EventArgs e)
        {
          
            AltaClienteForm altaCliente = new AltaClienteForm(new Cliente());
            altaCliente.Show();
            this.Dispose();
            this.Close();
        }

        private void updateBtn_Click(object sender, EventArgs e)
        {
            if (dataClientes.DataSource != null && dataClientes.SelectedRows.Count > 0)
            {
                foreach (DataGridViewRow row in dataClientes.SelectedRows)
                {
                    Cliente clienteSeleccionado = clienteMng.getClientePorId(Int32.Parse(row.Cells[0].Value.ToString()));
                    AltaClienteForm editForm = new AltaClienteForm(clienteSeleccionado);
                    editForm.ShowDialog();
                    this.Dispose();
                    this.Close();
                }
            }
        }
    }
}
