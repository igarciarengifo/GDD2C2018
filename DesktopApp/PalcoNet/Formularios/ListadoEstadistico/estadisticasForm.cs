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

namespace PalcoNet.Formularios.ListadoEstadistico
{
    public partial class estadisticasForm : Form
    {
        Estadisticas_Manager estadisticasMng = new Estadisticas_Manager();
        public estadisticasForm()
        {
            InitializeComponent();
            this.cargarAniosDeConsulta();
        }

        private void cargarAniosDeConsulta()
        {
            int anio = estadisticasMng.getMenorAnioActividad();
            int anioMayor = estadisticasMng.getMayorAnioActividad();
            for (int i = anio; i <= anioMayor; i++)
            {
                anioConsultaBox.Items.Add(i);
            }
        }



        private void cancelBtn_Click(object sender, EventArgs e)
        {
            this.Dispose();
            this.Close();
        }

        private void empresasLinkLabel_LinkClicked(object sender, LinkLabelLinkClickedEventArgs e)
        {
            DataTable resultTable = estadisticasMng.getTopEmpresasLocalidadesNoVendidas(Convert.ToInt32(anioConsultaBox.Text), (int)trimestreBox.Value);
            dataGridEstadisticas.DataSource = resultTable;
        }

        private void puntosLinkLabel_LinkClicked(object sender, LinkLabelLinkClickedEventArgs e)
        {
            DataTable resultTable = estadisticasMng.getTopClientesPuntosVencidos(Convert.ToInt32(anioConsultaBox.Text), (int)trimestreBox.Value);
            dataGridEstadisticas.DataSource = resultTable;
        }

        private void comprasLinkLabel_LinkClicked(object sender, LinkLabelLinkClickedEventArgs e)
        {
            DataTable resultTable = estadisticasMng.getTopClientesConMasCompras(Convert.ToInt32(anioConsultaBox.Text), (int)trimestreBox.Value);
            dataGridEstadisticas.DataSource = resultTable;
        }
    }
}
