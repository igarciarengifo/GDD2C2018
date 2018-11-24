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

namespace PalcoNet.Formularios.AbmGrado {
    public partial class EditarGradoForm : Form {
        public EditarGradoForm(Grado grado) {
            InitializeComponent();
            txtDescripcion.Text = grado.descripcion;
            txtComision.Text = Convert.ToString(grado.comision);
        }

        string salida;
        Grado_Manager gradoMngr = new Grado_Manager();

        private void btnCancelar_Click(object sender, EventArgs e) {
            this.Dispose();
            this.Close();
        }

        private void btnAceptar_Click(object sender, EventArgs e) {
            try {
                this.verificarCamposObligatorios();
                Grado nuevoGrado = new Grado();
                nuevoGrado.descripcion = txtDescripcion.Text;
                nuevoGrado.comision = Convert.ToDecimal(txtComision.Text);

                salida = gradoMngr.editarGrado(nuevoGrado);
                if (salida.Equals("OK")) {
                    MessageBox.Show("Se ha modificado correctamente.");
                } else {
                    MessageBox.Show("Ha ocurrido un error.");
                }              

                this.Dispose();
                this.Close();
                ConsultaGradosForm consultaGradoForm = new ConsultaGradosForm();
                consultaGradoForm.Show();
            } catch (Exception exc) {
                MessageBox.Show(exc.Message);
            }
        }

        private void verificarCamposObligatorios() {
            if ((String.IsNullOrEmpty(txtDescripcion.Text)) || (String.IsNullOrEmpty(txtComision.Text))) {
                throw new ArgumentException("Debe completar los datos requeridos");
            }
        }

     
    }
}
