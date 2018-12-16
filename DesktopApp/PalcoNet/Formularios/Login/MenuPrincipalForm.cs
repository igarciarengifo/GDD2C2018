using PalcoNet.Entidades;
using PalcoNet.Formularios.AbmCliente;
using PalcoNet.Formularios.AbmEmpresaEspectaculo;
using PalcoNet.Formularios.ABMUsuario;
using PalcoNet.Formularios.GenerarPublicacion;
using PalcoNet.Formularios.ListadoEstadistico;
using PalcoNet.Formularios.HistorialCliente;
using PalcoNet.Formularios.GenerarRendicionComisiones;
using PalcoNet.Formularios.AbmGrado;
//using PalcoNet.Formularios.AbmRol;
//using PalcoNet.Formularios.Comprar;
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
            historialClienteBtn.Visible = false;
            estadisticasBtn.Visible = false;
            menuStrip1.Visible = false;
            this.iniciar_sesion();

        }

        private void iniciar_sesion()
        {
            LoginForm login_scr = new LoginForm();
            login_scr.ShowDialog();
            if (DatosSesion.sesion_iniciada)
            {
                menuStrip1.Visible = true;
                this.actualizarStatusLabel();
                this.habilitar_func_x_rol();
            }
            else { 
                this.Dispose();
                this.Close();
            }
        }

        private void habilitar_func_x_rol()
        {
            List<Funcionalidad> f = DatosSesion.funcionalidades;
            flpCentral.Controls.Clear();

            if (f.Any(func => func.nombre.Equals("Publicar Espectaculo")))
            {
                newPubBtn.Visible = true;
                flpCentral.Controls.Add(newPubBtn);
            }

            if (f.Any(func => func.nombre.Equals("Modificar Publicacion")))
            {
                editPubBtn.Visible = true;
                flpCentral.Controls.Add(editPubBtn);
            }

            if (f.Any(func => func.nombre.Equals("Comprar Entrada")))
            {
                comprarBtn.Visible = true;
                flpCentral.Controls.Add(comprarBtn);
            }

            if (f.Any(func => func.nombre.Equals("Modificar Compra")))
            {
                editCompBtn.Visible = true;
                flpCentral.Controls.Add(editCompBtn);
            }

            if (f.Any(func => func.nombre.Equals("Historal Cliente")))
            {
                historialClienteBtn.Visible = true;
                flpCentral.Controls.Add(historialClienteBtn);
            }

            if (f.Any(func => func.nombre.Equals("Facturar rendiciones")))
            {
                rendConsBtn.Visible = true;
                factComBtn.Visible = true;
                flpCentral.Controls.Add(factComBtn);
                flpCentral.Controls.Add(rendConsBtn);
            }

            if (f.Any(func => func.nombre.Equals("Listado Estadistico")))
            {

                estadisticasBtn.Visible = true;
                flpCentral.Controls.Add(estadisticasBtn);
            }

            ToolStripItemCollection items = menuStrip1.Items;

            ToolStripItem menu_roles = menuStrip1.Items.Find("rolesToolStripMenuItem", true)[0];
            menu_roles.Visible = f.Any(func => func.nombre.Equals("ABM Rol"));

            ToolStripItem menu_clientes = menuStrip1.Items.Find("clientesToolStripMenuItem", true)[0];
            menu_clientes.Visible = f.Any(func => func.nombre.Equals("ABM Clientes"));

            ToolStripItem menu_empresas = menuStrip1.Items.Find("empresasToolStripMenuItem", true)[0];
            menu_empresas.Visible = f.Any(func => func.nombre.Equals("ABM Empresas"));

            ToolStripItem menu_grados = menuStrip1.Items.Find("gradosDePublicaciónToolStripMenuItem", true)[0];
            menu_grados.Visible = f.Any(func => func.nombre.Equals("ABM Grado Publicacion"));

            ToolStripItem menu_historial_puntos = menuStrip1.Items.Find("puntosToolStripMenuItem", true)[0];
            menu_historial_puntos.Visible = f.Any(func => func.nombre.Equals("Canjear Puntos"));

            this.Visible = true;
        }

        private void MenuPrincipalForm_Load(object sender, EventArgs e)
        {
         
            this.WindowState = FormWindowState.Maximized;
            this.actualizarStatusLabel();
        }

        private void actualizarStatusLabel()
        {
            ToolStripItem status_label = statusStrip1.Items["estadoActualLabel"];
            status_label.Text = "Usuario: " + DatosSesion.username + " - Rol: " + DatosSesion.id_rol;
        }

        private void nuevaEmpresaToolStripMenuItem_Click(object sender, EventArgs e)
        {
            AltaEmpresaForm newEmpresaForm = new AltaEmpresaForm(new Empresa());
            newEmpresaForm.ShowDialog();
        }

        private void consultarEmpresasToolStripMenuItem_Click(object sender, EventArgs e)
        {
            ConsultaEmpresasForm consEmpresaForm = new ConsultaEmpresasForm();
            consEmpresaForm.ShowDialog();
        }

        private void nuevoClienteToolStripMenuItem_Click(object sender, EventArgs e)
        {
            AltaClienteForm newClienteForm = new AltaClienteForm(new Cliente());
            newClienteForm.ShowDialog();
        }

        private void consultarClientesToolStripMenuItem_Click(object sender, EventArgs e)
        {
            ConsultaClientesForm consClientesForm = new ConsultaClientesForm();
            consClientesForm.ShowDialog();
        }

        private void modificarUsuarioToolStripMenuItem_Click(object sender, EventArgs e)
        {
            CambiarPassForm cambiarPassForm = new CambiarPassForm();
            cambiarPassForm.ShowDialog();
        }

        private void cerrarSesionToolStripMenuItem_Click(object sender, EventArgs e)
        {
            DatosSesion.cerrar_sesion();
            this.Visible = false;
            iniciar_sesion();
           
        }

        private void historialPuntosToolStripMenuItem_Click(object sender, EventArgs e)
        {

        }

        private void canjeDePuntosToolStripMenuItem_Click(object sender, EventArgs e)
        {
            
        }

        private void newPubBtn_Click(object sender, EventArgs e)
        {
            AltaEditPublicacionForm nuevaPublicacionForm = new AltaEditPublicacionForm();
            nuevaPublicacionForm.ShowDialog();
        }

        private void estadisticasBtn_Click(object sender, EventArgs e)
        {
            EstadisticasForm estadisticasForm = new EstadisticasForm();
            estadisticasForm.ShowDialog();
        }

        private void editPubBtn_Click(object sender, EventArgs e)
        {

        }

        private void historialClienteBtn_Click(object sender, EventArgs e) {
            HistorialClienteForm historialClienteForm = new HistorialClienteForm();
            historialClienteForm.ShowDialog();
        }

        private void rendConsBtn_Click(object sender, EventArgs e) {
            RendicionComisionesForm rendicionComisionesForm = new RendicionComisionesForm();
            rendicionComisionesForm.ShowDialog();
        }

        private void consultarGradosToolStripMenuItem_Click(object sender, EventArgs e) {
            ConsultaGradosForm consultaGradoForm = new ConsultaGradosForm();
            consultaGradoForm.ShowDialog();
        }

        private void consultarRolesToolStripMenuItem_Click(object sender, EventArgs e) {
            //ConsultaRolesForm consultaRolesForm = new ConsultaRolesForm();
            //consultaRolesForm.ShowDialog();
        }

        private void nuevoRolToolStripMenuItem_Click(object sender, EventArgs e) {
            //AltaRolForm altaRolForm = new AltaRolForm();
            //altaRolForm.ShowDialog();
        }

        private void nuevoToolStripMenuItem_Click(object sender, EventArgs e){
            AltaGradoForm altaGradoForm = new AltaGradoForm();
            altaGradoForm.ShowDialog();
        }

      
        
    }
}
