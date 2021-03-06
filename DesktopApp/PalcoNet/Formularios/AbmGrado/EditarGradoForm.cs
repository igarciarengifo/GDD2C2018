﻿using System;
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
        public EditarGradoForm(Grado_Publicacion grado) {
            InitializeComponent();
            id_grado = grado.id_grado_publicacion;
            txtDescripcion.Text = grado.descripcion;
            txtComision.Text = Convert.ToString(grado.comision);
        }

        string salida;
        int id_grado = 0;
        Grados_Publicacion_Manager gradoMngr = new Grados_Publicacion_Manager();

        private void btnCancelar_Click(object sender, EventArgs e) {
            this.Dispose();
            this.Close();
        }

        private void btnAceptar_Click(object sender, EventArgs e) {
            try {
                this.verificarCamposObligatorios();
                Grado_Publicacion nuevoGrado = new Grado_Publicacion();
                nuevoGrado.id_grado_publicacion = id_grado;
                nuevoGrado.descripcion = txtDescripcion.Text;
                nuevoGrado.comision = Convert.ToDouble(txtComision.Text);

                salida = gradoMngr.editarGrado(nuevoGrado);
                if (salida.Equals("OK")) {
                    MessageBox.Show("Se ha modificado correctamente.");
                } else {
                    MessageBox.Show("Ha ocurrido un error.");
                }              

                this.Dispose();
                this.Close();
                ConsultaGradosForm consultaGradoForm = new ConsultaGradosForm();
                consultaGradoForm.ShowDialog();
            } catch (Exception exc) {
                MessageBox.Show(exc.Message);
            }
        }

        private void verificarCamposObligatorios() {
            if ((String.IsNullOrEmpty(txtDescripcion.Text)) || (String.IsNullOrEmpty(txtComision.Text))) {
                throw new ArgumentException("Debe completar los datos requeridos");
            }
        }

        private const char SignoDecimal = ','; // Carácter separador decimal

        private void txtComision_KeyPress(object sender, KeyPressEventArgs e)
        {
            var textBox = (TextBox)sender;
            // Si el carácter pulsado no es un carácter válido se anula
            e.Handled = !char.IsDigit(e.KeyChar) // No es dígito
                        && !char.IsControl(e.KeyChar) // No es carácter de control (backspace)
                        && (e.KeyChar != SignoDecimal // No es signo decimal o es la 1ª posición o ya hay un signo decimal
                            || textBox.SelectionStart == 0
                            || textBox.Text.Contains(SignoDecimal));
        }

     
    }
}
