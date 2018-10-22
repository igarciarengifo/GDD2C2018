using PalcoNet.Entidades;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace PalcoNet.Formularios.Login
{
    public partial class SeleccionRolForm : Form
    {
        int id_RolSeleccionado;
        List<Rol> rolesUsuario = new List<Rol>();

        public SeleccionRolForm(List<Rol> roles)
        {
            rolesUsuario = roles;
            this.cargarRolesSesion();
        }

        private void cargarRolesSesion()
        {
            rolesUsuarioBox.DisplayMember = "nombre";
            rolesUsuarioBox.ValueMember = "id_rol";
            rolesUsuarioBox.DataSource = rolesUsuario;
        }

        public int get_IdRolSeleccionado(){
            return this.id_RolSeleccionado;
        }

        private void acceptButton_Click(object sender, EventArgs e)
        {
            id_RolSeleccionado = (int)rolesUsuarioBox.SelectedValue;
            this.DialogResult = DialogResult.OK;
            this.Close();
        }

        private void exitBtn_Click(object sender, EventArgs e)
        {
            this.DialogResult = DialogResult.Cancel;
            this.Close();
        }
    }
}
