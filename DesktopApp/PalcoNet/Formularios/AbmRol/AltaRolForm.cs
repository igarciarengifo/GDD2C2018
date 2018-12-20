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

namespace PalcoNet.Formularios.AbmRol {
    public partial class AltaRolForm : Form {
        public AltaRolForm() {
            InitializeComponent();
            this.cargarCheckedListBox();
        }
        
        Rol_Manager rolMngr = new Rol_Manager();
        Funcionalidad_Manager funcionalidadMngr = new Funcionalidad_Manager();

        public void cargarCheckedListBox() {
            List<Funcionalidad> items = new List<Funcionalidad>();
            items = funcionalidadMngr.getAllFuncionalidades();

            foreach (Funcionalidad func in items)
            {
                checkedListBox1.Items.Add(func, false);
            }
            checkedListBox1.DisplayMember = "nombre";
            checkedListBox1.ValueMember = "id_funcionalidad";      
        }

        private void btnAceptar_Click(object sender, EventArgs e) {
            try {
                string id_rol;
                string salida;
                this.verificarCamposObligatorios();
                Rol nuevoRol = new Rol();
                nuevoRol.nombre = txtNombre.Text;
                id_rol = rolMngr.nuevoRol(nuevoRol);
                if (!(id_rol.Equals("Error"))) {
                    foreach (Funcionalidad item in checkedListBox1.CheckedItems) {
                        int id_Func = item.id_funcionalidad;
                        salida = funcionalidadMngr.nuevaFuncXRol(int.Parse(id_rol), id_Func);
                        if (salida.Equals("ERROR")) {
                            MessageBox.Show("Ha ocurrido un error");
                            break;
                        }
                    }
                    MessageBox.Show("Nuevo rol agregado correctamente.");
                    this.Dispose();
                    this.Close();
                    ConsultaRolesForm consultaRolForm = new ConsultaRolesForm();
                    consultaRolForm.ShowDialog();
                } else {
                    MessageBox.Show("Ha ocurrido un error");
                }
                
            } catch (Exception exc) {
                MessageBox.Show(exc.Message);
            }
        }

        private void btnCancelar_Click(object sender, EventArgs e) {
            this.Dispose();
            this.Close();
        }

        private void verificarCamposObligatorios() {
            if (String.IsNullOrEmpty(txtNombre.Text)) {
                throw new ArgumentException("Debe completar el campo 'Nombre'");
            }
            if (!(checkedListBox1.CheckedItems.Count > 0)) {
                throw new ArgumentException("Debe agregar por lo menos una funcionalidad.");
            }
        }
      
    }
}
