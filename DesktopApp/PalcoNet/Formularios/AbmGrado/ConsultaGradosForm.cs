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

namespace PalcoNet.Formularios.AbmGrado {

    public partial class ConsultaGradosForm : Form {
        public ConsultaGradosForm() {
            InitializeComponent();
            modificarBtn.Enabled = false;
            eliminarBtn.Enabled = false;
            this.cargar_datos();
        }

        Grados_Publicacion_Manager gradoMngr = new Grados_Publicacion_Manager();

        public void cargar_datos() {
            List<Grado_Publicacion> grados = new List<Grado_Publicacion>();
            grados = gradoMngr.getAllGradosPublicacionActivos();

            if (grados.Count > 0) {
                dataGridView1.DataSource = grados;
                modificarBtn.Enabled = true;
                eliminarBtn.Enabled = true;
                
            } else {
                MessageBox.Show("No se encontraron resultados.");

            }
        }

        private void salirBtn_Click(object sender, EventArgs e) {
            this.Dispose();
            this.Close();
        }

        private void nuevoBtn_Click(object sender, EventArgs e) {
            this.Dispose();
            this.Close();
            AltaGradoForm altaGradoForm = new AltaGradoForm();
            altaGradoForm.ShowDialog();
        }

        private void modificarBtn_Click(object sender, EventArgs e) {

            if (dataGridView1.SelectedRows.Count > 0) {              
                DataGridViewRow dtv = dataGridView1.SelectedRows[0];
                Grado_Publicacion gradoSelected = (Grado_Publicacion)dtv.DataBoundItem;
                this.Dispose();
                this.Close();
                EditarGradoForm editarGradoForm = new EditarGradoForm(gradoSelected);
                editarGradoForm.ShowDialog();
                
            }
            
        }

        private void eliminarBtn_Click(object sender, EventArgs e) {
            if (dataGridView1.SelectedRows.Count > 0) {
                DataGridViewRow dtv = dataGridView1.SelectedRows[0];
                Grado_Publicacion gradoSelected = (Grado_Publicacion)dtv.DataBoundItem;
                String salida = gradoMngr.bajaGrado(gradoSelected);

                if (salida.Equals("OK")) {
                    MessageBox.Show("Baja correcta.");
                    this.cargar_datos();
                } else {
                    MessageBox.Show("El grado no se puede eliminar porque está siendo usado.");
                }    
            }
        }


    }
}
