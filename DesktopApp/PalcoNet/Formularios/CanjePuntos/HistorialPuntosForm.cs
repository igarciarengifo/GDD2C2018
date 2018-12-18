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

namespace PalcoNet.Formularios.CanjePuntos
{
    public partial class HistorialPuntosForm : Form
    {
        public HistorialPuntosForm()
        {
            InitializeComponent();
        }

        private void HistorialPuntosForm_Load(object sender, EventArgs e)
        {
            Cliente_Manager clienteMng = new Cliente_Manager();
            DataTable canjesDeUsuario = clienteMng.getCanjesDeUsuario(DatosSesion.id_usuario);
            if (canjesDeUsuario.Rows.Count == 0)
            {
                MessageBox.Show("El cliente no realizó canjes.");
                this.Close();
            }
            else
            {
                historialGrid.DataSource = canjesDeUsuario;
            }
        }

        private void volverBtn_Click(object sender, EventArgs e)
        {
            this.Dispose();
            this.Close();
        }
    }
}
