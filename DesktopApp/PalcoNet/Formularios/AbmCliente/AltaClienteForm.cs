using PalcoNet.Entidades;
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

namespace PalcoNet.Formularios.AbmCliente
{
    public partial class AltaClienteForm : Form
    {
        string user, pass, resultado;
        Cliente_Manager clienteMng = new Cliente_Manager();

        public AltaClienteForm(Cliente cliente) {
            if (cliente.id_cliente != 0)
            {
                habilitadoBox.Visible = true;
                nameBox.Text = cliente.nombre;
                lastNameBox.Text = cliente.apellido;
                comboTipo.SelectedValue = cliente.tipo_documento;
                documentoBox.Text = cliente.nro_documento.ToString();
                cuilBox.Text = cuilBox.Text;
                fechaNacBox.Value = cliente.fecha_nacimiento;
                mailBox.Text = cliente.mail;
                telBox.Text = cliente.telefono;
                direccionBox.Text = cliente.direccion_calle;
                nroBox.Text = cliente.direccion_nro.ToString();
                pisoBox.Text = cliente.direccion_piso.ToString();
                deptoBox.Text = cliente.direccion_depto;
                localidadBox.Text = cliente.direccion_localidad;
                codPostalBox.Text = cliente.codigo_postal;
                habilitadoBox.Checked = cliente.esta_habilitado;

            }
            else {
                habilitadoBox.Visible = false;
           
            }
  
        }

        public AltaClienteForm(string username, string passw)
        {
            InitializeComponent();
            user = username;
            pass = passw;
        }

        public string getResultado()
        {
            return resultado;
        }

        private void newClienteBtn_Click(object sender, EventArgs e)
        {
            try {
                this.verificarCamposObligatorios();
                Cliente nuevaPersona = new Cliente();
                nuevaPersona.nombre = nameBox.Text;
                nuevaPersona.apellido = lastNameBox.Text;
                nuevaPersona.tipo_documento = (string)comboTipo.SelectedValue;
                nuevaPersona.nro_documento = Convert.ToInt32(documentoBox.Text);
                nuevaPersona.cuil = cuilBox.Text;
                nuevaPersona.fecha_nacimiento = fechaNacBox.Value;
                nuevaPersona.mail = mailBox.Text;
                nuevaPersona.telefono = telBox.Text;
                nuevaPersona.direccion_calle = direccionBox.Text;
                nuevaPersona.direccion_nro = Convert.ToInt32(nroBox.Text);
                nuevaPersona.direccion_piso = Convert.ToInt32(pisoBox.Text);
                nuevaPersona.direccion_depto = deptoBox.Text;
                nuevaPersona.codigo_postal = codPostalBox.Text;
                
                resultado = clienteMng.altaClienteYUsuario(user, pass, nuevaPersona);
                MessageBox.Show(resultado);
            }
            catch (Exception exc) {
                MessageBox.Show(exc.Message);
            }
            
        }

        private void verificarCamposObligatorios()
        {
            if ((String.IsNullOrEmpty(nroBox.Text)) || (String.IsNullOrEmpty(comboTipo.SelectedText)) || (String.IsNullOrEmpty(cuilBox.Text)) || String.IsNullOrEmpty(mailBox.Text) || String.IsNullOrEmpty(nameBox.Text) || String.IsNullOrEmpty(lastNameBox.Text))
            {
                throw new ArgumentException("Debe completar los datos de usuario y contraseña");
            }
            this.validarFormatoCUIL();

        }

        private void validarFormatoCUIL()
        {
            if (! cuilBox.Text.Contains("-")) {
                throw new Exception("Formato incorrecto. El formato correcto es ##-########-##");
            }

            string[] substrings  = cuilBox.Text.Split('-');

            //Si tiene tres partes separadas por  - y todas son numeros
            if (!(substrings.Length.Equals(3) && substrings.All(substring => substring.All(character => Char.IsDigit(character))))){
                throw new Exception("Formato incorrecto. El formato correcto es ##-########-##");
            }
            
            if (!(substrings.ElementAt(0).Length.Equals(2) && substrings.ElementAt(1).Length.Equals(8) && substrings.ElementAt(2).Length.Equals(2))){
                throw new Exception("Formato incorrecto. El formato correcto es ##-########-##");            
            } 
        }

        private void exitBtn_Click(object sender, EventArgs e)
        {
            this.Dispose();
            this.Close();
        }
    }
}
