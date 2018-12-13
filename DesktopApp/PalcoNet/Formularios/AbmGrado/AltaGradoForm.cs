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
    public partial class AltaGradoForm : Form {
        public AltaGradoForm() {
            InitializeComponent();
        }

        string salida;
        Grados_Publicacion_Manager gradoMngr = new Grados_Publicacion_Manager();

        private void btnAceptar_Click(object sender, EventArgs e) {
            try {
                this.verificarCamposObligatorios();
                Grado_Publicacion nuevoGrado = new Grado_Publicacion();
                nuevoGrado.descripcion = txtDescripcion.Text;
                nuevoGrado.comision = Convert.ToDouble(txtComision.Text);

                salida = gradoMngr.nuevoGrado(nuevoGrado);
                if (salida.Equals("OK")) {
                    MessageBox.Show("Alta exitosa!");
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

        private void btnCancelar_Click(object sender, EventArgs e) {
            this.Dispose();
            this.Close();
        }

        private void verificarCamposObligatorios() {
            if ((String.IsNullOrEmpty(txtDescripcion.Text)) || (String.IsNullOrEmpty(txtComision.Text))) {
                throw new ArgumentException("Debe completar los datos requeridos");
            }
        }
      
    }
}
