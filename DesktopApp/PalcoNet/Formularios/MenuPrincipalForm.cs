using PalcoNet.Entidades;
using PalcoNet.Login;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace PalcoNet.Formularios
{
    public partial class MenuPrincipalForm : Form
    {
        public MenuPrincipalForm()
        {
            InitializeComponent();
            panelEmpresas.Visible = false;
            comprarBtn.Visible = false;
            editCompBtn.Visible = false;
            rendConsBtn.Visible = false;
            newPubBtn.Visible = false;
            editPubBtn.Visible = false;
            puntosBtn.Visible = false;
            this.iniciar_sesion();

        }

        private void iniciar_sesion()
        {
            LoginForm login_scr = new LoginForm();
            login_scr.ShowDialog();
            if (DatosSesion.sesion_iniciada)
            {
                this.habilitar_func_x_rol();
            }
        }

        private void habilitar_func_x_rol()
        {
            List<Funcionalidad> f = DatosSesion.funcionalidades;
            flpCentral.Controls.Clear();

            if (f.Any(func => func.descripcion.Equals("Nueva Publicacion")))
            {
                newPubBtn.Visible = true;
                flpCentral.Controls.Add(newPubBtn);
            }

            if (f.Any(func => func.descripcion.Equals("Editar Publicacion")))
            {
                editPubBtn.Visible = true;
                flpCentral.Controls.Add(editPubBtn);
            }

            if (f.Any(func => func.descripcion.Equals("Comprar")))
            {
                comprarBtn.Visible = true;
                flpCentral.Controls.Add(comprarBtn);
            }

            if (f.Any(func => func.descripcion.Equals("Editar Compra")))
            {
                editCompBtn.Visible = true;
                flpCentral.Controls.Add(editCompBtn);
            }

            if (f.Any(func => func.descripcion.Equals("Puntos")))
            {
                puntosBtn.Visible = true;
                flpCentral.Controls.Add(puntosBtn);
            }

            if (f.Any(func => func.descripcion.Equals("Consultar Rendicion")))
            {
                rendConsBtn.Visible = true;
                flpCentral.Controls.Add(rendConsBtn);
            }

            if (f.Any(func => func.descripcion.Equals("Facturar Comisión")))
            {
                rendConsBtn.Visible = true;
                flpCentral.Controls.Add(factComBtn);
            }
        }

        private void MenuPrincipalForm_Load(object sender, EventArgs e)
        {
         
            toolTip1.ToolTipTitle = "Gestión puntos";
            toolTip1.UseAnimation = true;
            toolTip1.ShowAlways = true;
            toolTip1.AutoPopDelay = 5000;
            toolTip1.InitialDelay = 1000;
            toolTip1.ReshowDelay = 500;
            toolTip1.SetToolTip(puntosBtn, "Boton derecho para más opciones.");
            this.WindowState = FormWindowState.Maximized;
            this.actualizarStatusLabel();
        }

        private void actualizarStatusLabel()
        {
            ToolStripItem status_label = statusStrip1.Items["StatusLabel"];
            status_label.Text = "Usuario: " + DatosSesion.username + " - Rol: " + DatosSesion.id_rol;
        }

        
    }
}
