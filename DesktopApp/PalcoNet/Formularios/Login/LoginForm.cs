using PalcoNet.Entidades;
using PalcoNet.Managers;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Configuration;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace PalcoNet.Login
{
    public partial class LoginForm : Form
    {
        public string connectionString;
        int id_usuario, id_rol_seleccionado;
        string password, usuario;
        private List<Funcionalidad> funcionalidades;
        Funcionalidad_Manager funcMng = new Funcionalidad_Manager();

        public LoginForm()
        {
            InitializeComponent();
            this.connectionString = ConfigurationManager.AppSettings["ConnectionString"].ToString();

        }

        private void completarDiferentesTipos()
        {
           /* Rol_Manager loginMger = new Rol_Manager();
            List<Rol> todosLosRoles = loginMger.getAllRolesHabilitados();
            iniciosComboBox.DisplayMember = "nombre";
            iniciosComboBox.ValueMember = "id_rol";
            iniciosComboBox.DataSource = todosLosRoles;*/
        }

        private void iniciarBtn_Click(object sender, EventArgs e)
        {
            try
            {
                this.verificarCamposObligatorios();
                Login_Manager loginMng = new Login_Manager();
                password = Encriptacion.getHashSha256(passBox.Text);
                id_usuario = loginMng.iniciarLogin(userBox.Text, password); 
                username = userLoginBox.Text;
                //Abro ventana para seleccionar hotel y rol
                SelHotelRolLoginForm seleccionForm = new SelHotelRolLoginForm(id_usuario);
                if (seleccionForm.ShowDialog(this) == DialogResult.OK)
                {
                    id_rol = seleccionForm.id_RolSeleccionado;
                    id_hotel = seleccionForm.id_hotelSeleccionado;
                    panelSession.Enabled = false;
                    iniciarButton.Enabled = true;
                    iniciarButton.Focus();
                }
                else
                {
                    MessageBox.Show("Operacion cancelada");
                }
                seleccionForm.Dispose();
                if (id_usuario != 0)
                {
                    password = Encriptacion.getHashSha256(passBox.Text);
                    usuario = userBox.Text;
                    funcionalidades = funcMng.funcionalidadesXRol(id_rol_seleccionado);
                    DatosSesion.iniciarSesion(id_usuario, usuario, password, id_rol_seleccionado, funcionalidades);

                }
                else { 
                
                }
                
            }
            catch (Exception exc)
            {
                MessageBox.Show(exc.Message);
            }

        }

        private void verificarCamposObligatorios()
        {
            throw new NotImplementedException();
        }

        private void salirBtn_Click(object sender, EventArgs e)
        {
            
            /* TODO: Mensaje para verificar si desea salir*/
            this.Close();
        }

        private void linkRegistro_LinkClicked(object sender, LinkLabelLinkClickedEventArgs e)
        {

        }

    }
}
