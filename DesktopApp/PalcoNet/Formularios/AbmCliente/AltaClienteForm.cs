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
        Boolean esModificacion;
        string user, pass, resultado;
        Cliente_Manager clienteMng = new Cliente_Manager();
        Cliente clienteModificacion;
        public AltaClienteForm(Cliente cliente) {
            InitializeComponent();
            if (cliente.id_cliente != 0)
            {
                clienteModificacion = cliente;
                habilitadoBox.Visible = true;
                nameBox.Text = cliente.nombre;
                lastNameBox.Text = cliente.apellido;
                comboTipo.SelectedValue = cliente.tipo_documento;
                documentoBox.Text = cliente.nro_documento.ToString();
                cuilBox.Text = cliente.cuil;
                fechaNacBox.Value = cliente.fecha_nacimiento;
                mailBox.Text = cliente.mail;
                telBox.Text = cliente.telefono;
                direccionBox.Text = cliente.direccion_calle;
                nroBox.Text = cliente.direccion_nro.ToString();
                pisoBox.Text = cliente.direccion_piso.ToString();
                deptoBox.Text = cliente.direccion_depto;
                localidadBox.Text = cliente.direccion_localidad;
                codPostalBox.Text = cliente.codigo_postal;
                habilitadoBox.Checked = cliente.baja_logica;
                esModificacion = true;
            }
            else {
                habilitadoBox.Visible = false;
                esModificacion = false;
            }
  
        }

        public AltaClienteForm(string username, string passw)
        {
            InitializeComponent();
            user = username;
            pass = passw;
            habilitadoBox.Visible = false;
            esModificacion = false;
        }

        public string getResultado()
        {
            return resultado;
        }

        private void newClienteBtn_Click(object sender, EventArgs e)
        {
            try {
                this.verificarCamposObligatorios();
                if (!esModificacion)
                {
                    this.nuevoCliente();
                }
                else {
                    this.modificarCliente();
                }
                
               
            }
            catch (Exception exc) {
                MessageBox.Show(exc.Message);
            }
            
        }

        private void modificarCliente( )
        {
            clienteModificacion.nombre = nameBox.Text;
            clienteModificacion.apellido = lastNameBox.Text;
            clienteModificacion.tipo_documento = comboTipo.SelectedValue.ToString();
            clienteModificacion.nro_documento = Int32.Parse(documentoBox.Text);
            clienteModificacion.cuil = cuilBox.Text;
            clienteModificacion.mail = mailBox.Text;
            clienteModificacion.fecha_nacimiento = fechaNacBox.Value;
            clienteModificacion.telefono = telBox.Text;
            clienteModificacion.direccion_calle = direccionBox.Text;
            clienteModificacion.direccion_nro = Convert.ToInt32(nroBox.Text);
            clienteModificacion.direccion_piso = this.completarPiso();
            clienteModificacion.direccion_depto = deptoBox.Text;
            clienteModificacion.direccion_localidad = localidadBox.Text;
            clienteModificacion.codigo_postal = codPostalBox.Text;
            clienteModificacion.baja_logica = habilitadoBox.Checked;
            resultado = clienteMng.modificarCliente(clienteModificacion);

            if (resultado.Equals("OK"))
            {
                MessageBox.Show("Se realizaron los cambios correctamente.", "Operacion correcta");
                this.Dispose();
                this.Close();

            }
            else
            {
                MessageBox.Show(resultado,
                    "No pudo realizarse operacion",
                    MessageBoxButtons.OK,
                    MessageBoxIcon.Exclamation,
                    MessageBoxDefaultButton.Button1);
            }
        }

        private Nullable<int> completarPiso()
        {
            if (String.IsNullOrEmpty(pisoBox.Text))
            {
                return null;
            }
            else
            {
                return Convert.ToInt32(pisoBox.Text);
            }
        }

        private void nuevoCliente()
        {
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
            String[] arrayResultado = resultado.Split(';');
            string passToHash;
            if (arrayResultado.ElementAt(2).Equals("OK"))
            {
                Usuario_Manager userMng = new Usuario_Manager();
                MessageBox.Show("Se realizaron los cambios correctamente.", "Resultado operacion");
                if (user == null)
                {
                    MessageBox.Show("La nueva contraseña es: " + arrayResultado.ElementAt(1) + ".\n El usuario es: " + nuevaPersona.cuil, "Operacion correcta");
                    passToHash = arrayResultado.ElementAt(1);
                    this.DialogResult = DialogResult.OK;
                }
                else
                {
                    passToHash = pass;
                }
                String passHash = Encriptacion.getHashSha256(passToHash);
                userMng.cambiarPassword(passHash, Convert.ToInt32(arrayResultado.ElementAt(0)));
                this.DialogResult = DialogResult.OK;
                this.Close();
            }
            else
            {
                MessageBox.Show(arrayResultado.ElementAt(0),
                    "No pudo realizarse operacion",
                    MessageBoxButtons.OK,
                    MessageBoxIcon.Exclamation,
                    MessageBoxDefaultButton.Button1);
            }
        }

        private void verificarCamposObligatorios()
        {
            if ((String.IsNullOrEmpty(nroBox.Text)) || (String.IsNullOrEmpty(comboTipo.SelectedItem.ToString())) || (String.IsNullOrEmpty(cuilBox.Text)) || String.IsNullOrEmpty(mailBox.Text) || String.IsNullOrEmpty(nameBox.Text) || String.IsNullOrEmpty(lastNameBox.Text))
            {
                throw new ArgumentException("Debe completar los datos obligatorios indicados");
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

        private void AltaClienteForm_Load(object sender, EventArgs e)
        {
            comboTipo.DataSource = new TiposDocumento().getAll();
        }
    }
}
