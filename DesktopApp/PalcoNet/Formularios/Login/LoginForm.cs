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
        public LoginForm()
        {
            InitializeComponent();
            this.connectionString = ConfigurationManager.AppSettings["ConnectionString"].ToString();
            this.completarDiferentesTipos();

        }

        private void completarDiferentesTipos()
        {
            Rol_Manager loginMger = new Rol_Manager();
            List<Rol> todosLosRoles = loginMger.getAllRolesHabilitados();
            iniciosComboBox.DisplayMember = "nombre";
            iniciosComboBox.ValueMember = "id_rol";
            iniciosComboBox.DataSource = todosLosRoles;
        }

        private void iniciarBtn_Click(object sender, EventArgs e)
        {

        }

        private void salirBtn_Click(object sender, EventArgs e)
        {
            
            /* TODO: Mensaje para verificar si desea salir*/
            this.Close();
        }

    }
}
