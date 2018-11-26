using PalcoNet.Entidades;
using PalcoNet.Formularios.GenerarPublicacion;
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

namespace PalcoNet.Formularios.EditarPublicacion
{
    public partial class EditarPublicacionForm : Form
    {
        List<Publicacion> publicacionesEncontradas = new List<Publicacion>();
        Publicacion_Manager publicacionMng = new Publicacion_Manager();
        public EditarPublicacionForm()
        {
            InitializeComponent();
            modificarPubli.Enabled = false;
        }

        private void EditarPublicacion_Load(object sender, EventArgs e)
        {

        }

        private void button1_Click(object sender, EventArgs e)
        {
            try
            {
                if (String.IsNullOrEmpty(codPublicBox.Text))
                {
                    publicacionesEncontradas = publicacionMng.getAllPublicaciones();
                }
                else
                {
                    publicacionesEncontradas = publicacionMng.getPublicacionConId(Convert.ToInt32(codPublicBox.Text));
                }

                if (publicacionesEncontradas.Count == 0)
                {
                    modificarPubli.Enabled = false;
                    throw new Exception("No existe espectaculo solicitado");
                }

                publicacionGridView.DataSource = publicacionesEncontradas;
                modificarPubli.Enabled = true;
               
            }
            catch (Exception exc) {
                MessageBox.Show(exc.Message);
            }
            
            
        }

        private void modificarPubli_Click(object sender, EventArgs e)
        {
            if (publicacionGridView.DataSource != null && publicacionGridView.SelectedRows.Count > 0)
            {
                foreach (DataGridViewRow row in publicacionGridView.SelectedRows)
                {
                    Publicacion publicacionSeleccionada = (Publicacion)row.DataBoundItem;
                    AltaEditPublicacionForm editForm = new AltaEditPublicacionForm(publicacionSeleccionada);
                    editForm.ShowDialog();
                    this.Dispose();
                    this.Close();
                }
            }
        }

        private void cancelarBtn_Click(object sender, EventArgs e)
        {
            this.Dispose();
            this.Close();
        }
    }
}
