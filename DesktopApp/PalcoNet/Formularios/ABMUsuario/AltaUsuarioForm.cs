using PalcoNet.Formularios.AbmCliente;
using PalcoNet.Formularios.AbmEmpresaEspectaculo;
using PalcoNet.Managers;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace PalcoNet.Formularios.ABMUsuario
{
    public partial class AltaUsuarioForm : Form
    {
        Usuario_Manager userMng = new Usuario_Manager();

        public AltaUsuarioForm()
        {
            InitializeComponent();
            this.cargarTiposUsuarios();
        }

        private void cargarTiposUsuarios()
        {
            tipoComboBox.Text = "Seleccione un tipo de usuario";
            tipoComboBox.Items.Add("Cliente");
            tipoComboBox.Items.Add("Empresa");
        }

        private void button2_Click(object sender, EventArgs e)
        {
            this.Dispose();
            this.Close();
        }

        private void newUserBtn_Click(object sender, EventArgs e)
        {
            try
            {

                this.verificarCamposObligatorios();
                if (tipoComboBox.SelectedItem.Equals("Cliente"))
                {
                    var nuevaEntidadForm = new AltaClienteForm(userBox.Text, passBox.Text);

                    if (nuevaEntidadForm.ShowDialog(this) == DialogResult.OK)
                    {
                        MessageBox.Show(nuevaEntidadForm.getResultado());
                    }
                    else
                    {
                        throw new Exception("Operacion cancelada");
                    }
                }
                else
                {
                    var nuevaEntidadForm = new AltaEmpresaForm(userBox.Text, passBox.Text);
                    if (nuevaEntidadForm.ShowDialog(this) == DialogResult.OK)
                    {
                        MessageBox.Show(nuevaEntidadForm.getResultado());
                    }
                    else
                    {
                        throw new Exception("Operacion cancelada");
                    }
                }

            }
            catch (Exception exc)
            {
                MessageBox.Show(exc.Message);

            }
            finally {
                this.Dispose();
                this.Close();
            }
        }

        private void verificarCamposObligatorios()
        {
            if ((String.IsNullOrEmpty(userBox.Text)) || (String.IsNullOrEmpty(passBox.Text)))
            {
                throw new ArgumentException("Debe completar los datos de usuario y contraseña");
            }

            if (passBox.Text != confirmPassBox.Text)
            {
                throw new Exception("No coinciden las contraseñas. Reingreselo");
            }
        }
    }
}
