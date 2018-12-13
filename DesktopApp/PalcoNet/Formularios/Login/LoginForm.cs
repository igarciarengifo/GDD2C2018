using PalcoNet.Entidades;
using PalcoNet.Formularios.ABMUsuario;
using PalcoNet.Formularios.Login;
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
        string password, username;
        private List<Funcionalidad> funcionalidades;
        List<Rol> rolesDeUsuario = new List<Rol>();
        Funcionalidad_Manager funcMng = new Funcionalidad_Manager();
        Usuario_Manager usuMng = new Usuario_Manager();
        Rol_Manager rolMng = new Rol_Manager();

        public LoginForm()
        {
            InitializeComponent();

        }

        private void iniciarBtn_Click(object sender, EventArgs e)
        {
            try
            {
                this.verificarCamposObligatorios();
                Login_Manager loginMng = new Login_Manager();
                password = Encriptacion.getHashSha256(passBox.Text);
                id_usuario = loginMng.iniciarLogin(userBox.Text, password);
                username = userBox.Text;
                if (id_usuario != 0)
                {
                    rolesDeUsuario = rolMng.getRolesConIDUsuario(id_usuario);
                    if (rolesDeUsuario.Count > 1)
                    {
                        //Abro ventana para seleccionar rol, en caso de ser necesario
                        SeleccionRolForm seleccionForm = new SeleccionRolForm(rolesDeUsuario);
                        if (seleccionForm.ShowDialog(this) == DialogResult.OK)
                        {
                            id_rol_seleccionado = seleccionForm.get_IdRolSeleccionado();
                            Boolean result = loginMng.esPrimerLogueo(id_usuario);
                        }
                        else
                        {
                            MessageBox.Show("Operacion cancelada");
                        }
                        seleccionForm.Dispose();
                        seleccionForm.Close();
                        this.limpiarCampos();
                    }
                    else
                    {
                        id_rol_seleccionado = rolesDeUsuario.ElementAt(0).id_rol;
                    }

                    funcionalidades = funcMng.funcionalidadesXRol(id_rol_seleccionado);
                    DatosSesion.iniciarSesion(id_usuario, username, password, id_rol_seleccionado, funcionalidades);
                    this.Close();
                }
                
            }
            catch (Exception exc)
            {
                MessageBox.Show(exc.Message);
            }

        }

        private void limpiarCampos()
        {
            userBox.Clear();
            passBox.Clear();
        }

        private void verificarCamposObligatorios()
        {
            if ((String.IsNullOrEmpty(userBox.Text)) || (String.IsNullOrEmpty(passBox.Text))) {
                throw new ArgumentException("Debe completar los datos de usuario y contraseña");
            }
        }

        private void salirBtn_Click(object sender, EventArgs e)
        {
            
            /* TODO: Mensaje para verificar si desea salir*/
            this.Dispose();
            this.Close();
        }

        private void linkRegistro_LinkClicked(object sender, LinkLabelLinkClickedEventArgs e)
        {
            AltaUsuarioForm altaUsuarioForm = new AltaUsuarioForm();
            altaUsuarioForm.Show();
            
        }

    }
}
