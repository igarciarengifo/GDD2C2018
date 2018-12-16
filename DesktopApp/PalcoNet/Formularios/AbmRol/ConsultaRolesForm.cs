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

namespace PalcoNet.Formularios.AbmRol
{
    public partial class ConsultaRolesForm : Form {
        public ConsultaRolesForm() {
            InitializeComponent();
            this.cargar_datos();
            btnHabilitar.Enabled = false;
            btnDeshabilitar.Enabled = false;
        }

        Rol_Manager rolMngr = new Rol_Manager();

        public void cargar_datos() {
            List<Rol> roles = new List<Rol>();
            roles = rolMngr.getAllRoles();

            if (roles.Count > 0) {
                dataGridView1.DataSource = roles;
                modificarBtn.Enabled = true;
                //eliminarBtn.Enabled = true;

            } else {
                MessageBox.Show("No se encontraron resultados.");

            }
        }

        private void salirBtn_Click(object sender, EventArgs e) {
            this.Dispose();
            this.Close();
        }

        private void nuevoBtn_Click(object sender, EventArgs e) {
            AltaRolForm altaRolForm = new AltaRolForm();
            altaRolForm.Show();
        }

        private void modificarBtn_Click(object sender, EventArgs e) {
            if (dataGridView1.SelectedRows.Count > 0) {
                DataGridViewRow dtv = dataGridView1.SelectedRows[0];
                Rol rolSelected = (Rol)dtv.DataBoundItem;
                EditarRolForm editarGradoForm = new EditarRolForm(rolSelected);
                editarGradoForm.Show();
            }
        }

        private void dataGridView1_CellClick(object sender, DataGridViewCellEventArgs e) {
            DataGridViewRow fila = dataGridView1.Rows[e.RowIndex];
            Rol rolSelected = (Rol)fila.DataBoundItem;
            if (rolSelected.estado){
                btnHabilitar.Enabled = true;
                btnDeshabilitar.Enabled = false;               
            } else {
                btnDeshabilitar.Enabled = true;
                btnHabilitar.Enabled = false;                
            }
        }

        private void btnHabilitar_Click(object sender, EventArgs e) {
            if (dataGridView1.SelectedRows.Count > 0) {
                DataGridViewRow dtv = dataGridView1.SelectedRows[0];
                Rol rolSelected = (Rol)dtv.DataBoundItem;
                rolMngr.habilitarRol(rolSelected.id_rol);
                this.cargar_datos();
            }
        }

        private void btnDeshabilitar_Click(object sender, EventArgs e) {
            if (dataGridView1.SelectedRows.Count > 0) {
                DataGridViewRow dtv = dataGridView1.SelectedRows[0];
                Rol gradoSelected = (Rol)dtv.DataBoundItem;
                rolMngr.deshabilitarRol(gradoSelected.id_rol);
                this.cargar_datos();
            }
        }

    }
}
