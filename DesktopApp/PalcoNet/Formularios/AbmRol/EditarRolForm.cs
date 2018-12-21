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
    public partial class EditarRolForm : Form {
        public EditarRolForm(Rol rol) {
            InitializeComponent();
            rolEdited = rol;
            txtNombre.Text = rol.nombre;
            this.cargarCheckedListBox();
        }
        Rol rolEdited = new Rol();
        Rol_Manager rolMngr = new Rol_Manager();
        Funcionalidad_Manager funcionalidadMngr = new Funcionalidad_Manager();

        public void cargarCheckedListBox() {
            List<Funcionalidad> items = new List<Funcionalidad>();
            items = funcionalidadMngr.getAllFuncionalidades();

            foreach (Funcionalidad func in items) {
                checkedListBox1.Items.Add(func, false);
            }
            checkedListBox1.DisplayMember = "nombre";
            checkedListBox1.ValueMember = "id_funcionalidad";
            this.cargarDatosCheckedListBox(rolEdited.id_rol);
        }

        public void cargarDatosCheckedListBox(int idRol) {
            List<Funcionalidad> items = new List<Funcionalidad>();
            items = funcionalidadMngr.funcionalidadesXRol(idRol);
            foreach (Funcionalidad fun in items) {
                int id_Func = fun.id_funcionalidad;
                for (int i = 0; i < checkedListBox1.Items.Count; i++){
                    Funcionalidad item = (Funcionalidad) checkedListBox1.Items[i];
                    if(item.id_funcionalidad.Equals(id_Func)){
                        checkedListBox1.SetItemChecked(i, true);
                    }
                }         
            }                       
        }

        private void verificarCamposObligatorios() {
            if (String.IsNullOrEmpty(txtNombre.Text)) {
                //MessageBox.Show("Debe completar el campo 'Nombre'");
                //return;
                throw new ArgumentException("Debe completar el campo 'Nombre'");
            }
            if (!(checkedListBox1.CheckedItems.Count > 0)) {
                //MessageBox.Show("Debe agregar por lo menos una funcionalidad.");
                //return;
                throw new ArgumentException("Debe agregar por lo menos una funcionalidad.");
            }
        }

        private void btnCancelar_Click(object sender, EventArgs e) {
            this.Dispose();
            this.Close();
        }

        private void btnAceptar_Click(object sender, EventArgs e) {
            try {
                string salida1;
                string salida;
                this.verificarCamposObligatorios();
                Rol nuevoRol = new Rol();
                nuevoRol.nombre = txtNombre.Text;
                salida1 = rolMngr.modificarRol(rolEdited.id_rol, nuevoRol.nombre);
                salida1 = "OK";
                if (salida1.Equals("OK")) {
                    funcionalidadMngr.deshabilitarFuncsXRol(rolEdited.id_rol);
                    foreach (Funcionalidad item in checkedListBox1.CheckedItems) {
                        int id_Func = item.id_funcionalidad;
                        salida = funcionalidadMngr.nuevaFuncXRol(rolEdited.id_rol, id_Func);
                        if (salida.Equals("ERROR")) {
                            MessageBox.Show("Ha ocurrido un error");
                            return;
                        }
                    }
                    MessageBox.Show("Se ha modificado el rol correctamente.");
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
  
     
    }
}
