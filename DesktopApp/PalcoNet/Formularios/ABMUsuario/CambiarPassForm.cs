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

namespace PalcoNet.Formularios.ABMUsuario
{
    public partial class CambiarPassForm : Form
    {
        private string username;
        private string passInicio;
        private int id_usuario;
        public CambiarPassForm()
        {
            InitializeComponent();
            userBox.Text = DatosSesion.username;
            passInicio = DatosSesion.password;
            id_usuario = DatosSesion.id_usuario;
        }

        public CambiarPassForm(string username, string passInicio, int id_usuario)
        {
            InitializeComponent();
            userBox.Text = username;
            this.username = username;
            this.passInicio = passInicio;
            this.id_usuario = id_usuario;
        }

        private void changePassBtn_Click(object sender, EventArgs e)
        {
            try
            {
                this.verificarCamposObligatorios();
                this.verificarPassActual();
                this.verificarNuevaPass();
                if (this.cambiarPassword() != 0)
                {
                    this.DialogResult = DialogResult.OK;
                    MessageBox.Show("Se modificó correctamente la contraseña");
                }
                else
                {
                    MessageBox.Show("No pudo realizarse el cambio. Vuelva a intentarlo");
                }

            }
            catch (Exception exc) {
                MessageBox.Show(exc.Message);
            }
            
        }

        private int cambiarPassword()
        {
            string newPassHash = Encriptacion.getHashSha256(newPassBox.Text);
            Usuario_Manager userMng = new Usuario_Manager();
            return userMng.cambiarPassword(newPassHash, id_usuario); 
        }

        private void verificarNuevaPass()
        {
            if (newPassBox.Text != repeatPassBox.Text)
            {
                throw new Exception("No coinciden las contraseñas. Reingreselo");
            }
        }

        private void verificarPassActual()
        {
            if (passInicio != Encriptacion.getHashSha256(actualPassBox.Text)) {
                throw new Exception("La contraseña actual ingresada no coincide");
            }
        }

        private void verificarCamposObligatorios()
        {
            if (String.IsNullOrEmpty(actualPassBox.Text) || String.IsNullOrEmpty(newPassBox.Text) || String.IsNullOrEmpty(repeatPassBox.Text)) {
                throw new Exception("Todos los campos son obligatorios, debe completarlos"); 
            }
        }

        private void cancelBtn_Click(object sender, EventArgs e)
        {
            this.Dispose();
            this.Close();
        }
    }
}
