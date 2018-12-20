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
        Usuario_Manager usuario_Mng = new Usuario_Manager();
        Cliente clienteModificacion;
        List<Forma_Pago> formasDePago = new List<Forma_Pago>();
        List<Forma_Pago_Cliente> nuevasFormasDePago = new List<Forma_Pago_Cliente>();
        List<Forma_Pago_Cliente> formasPagoModificadas = new List<Forma_Pago_Cliente>();

        public AltaClienteForm(Cliente cliente) {
            InitializeComponent();
            cargarCombosTarjetas();
            if (cliente.id_cliente != 0)
            {
                clienteModificacion = cliente;
                dadoDeBajaBox.Visible = true;
                inhabilitadoBox.Visible = true;
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
                dadoDeBajaBox.Checked = cliente.baja_logica;
                inhabilitadoBox.Checked = !usuario_Mng.esUsuarioHabilitado(cliente.id_cliente);
                nuevasFormasDePago=clienteMng.getMediosDePagoDeUsuario(clienteModificacion.id_cliente);
                this.cargarDataTarjetasActuales();
                esModificacion = true;
            }
            else {
                dadoDeBajaBox.Visible = false;
                esModificacion = false;
            }
  
        }

        private void cargarDataTarjetasActuales()
        {
            foreach (Forma_Pago_Cliente formaPagoCliente in nuevasFormasDePago) { 
                Forma_Pago formaPago = formasDePago.Find(formaDePago => formaDePago.id_forma_pago==formaPagoCliente.id_forma_pago);
                agregarNuevaTarjetaData(formaPagoCliente.nro_tarjeta, formaPago.marca, formaPago.descripcion);
            }
            
        }

        public AltaClienteForm(string username, string passw)
        {
            InitializeComponent();
            user = username;
            pass = passw;
            cargarCombosTarjetas();
            dadoDeBajaBox.Visible = false;
            inhabilitadoBox.Visible = false;
            esModificacion = false;
        }



        private void newClienteBtn_Click(object sender, EventArgs e)
        {
            try {
                this.validarTiposCampos();
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

            agregarFormasDePago(formasPagoModificadas);
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
            clienteModificacion.baja_logica = dadoDeBajaBox.Checked;
            resultado = clienteMng.modificarCliente(inhabilitadoBox.Checked, clienteModificacion, nuevasFormasDePago, formasPagoModificadas);

            if (resultado.Equals("OK"))
            {
                MessageBox.Show("Se realizaron los cambios sobre los datos del cliente.", "Operacion correcta");
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

        private void validarTiposCampos()
        {
            ValidarTiposEntradas.numerico(documentoBox.Text, "Documento");
            ValidarTiposEntradas.numerico(telBox.Text, "Telefono");
            ValidarTiposEntradas.numerico(nroBox.Text, "Nro de calle");

            ValidarTiposEntradas.numerico(pisoBox.Text,"Piso");

            ValidarTiposEntradas.numerico(codPostalBox.Text, "Cod Postal");

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
            this.agregarFormasDePago(nuevasFormasDePago);
            ResultadoAltaCliente resultadoAlta = clienteMng.altaClienteYUsuario(user, pass, nuevaPersona, nuevasFormasDePago);
            
            string passToHash;
            if (resultadoAlta.resultadoCliente.Equals("OK"))
            {
                Usuario_Manager userMng = new Usuario_Manager();
                if (user == null)
                {
                    MessageBox.Show("La nueva contraseña es: " + resultadoAlta.password + ".\n El usuario es: " + resultadoAlta.username, "Operacion correcta");
                    passToHash = resultadoAlta.password;
                    this.DialogResult = DialogResult.OK;
                }
                else
                {
                    passToHash = pass;
                }
                String passHash = Encriptacion.getHashSha256(passToHash);
                userMng.cambiarPassword(passHash, resultadoAlta.id_usuario);
                if (resultadoAlta.resultadoTarjeta.Equals("OK"))
                {
                    MessageBox.Show("Se realizaron los cambios correctamente.", "Resultado operacion");
                }
                else {
                    MessageBox.Show("Contacte con el administrador para agregar un medio de pago.", "Resultado operacion");
                }
                this.DialogResult = DialogResult.OK;
                this.Close();
            }
            else
            {
                MessageBox.Show(resultadoAlta.resultadoCliente,
                    "No pudo realizarse operacion",
                    MessageBoxButtons.OK,
                    MessageBoxIcon.Exclamation,
                    MessageBoxDefaultButton.Button1);
            }
        }

        private void agregarFormasDePago(List<Forma_Pago_Cliente> listaFormasPago)
        {

            foreach (DataGridViewRow row in dataFormasPago.Rows)
            {
                Forma_Pago_Cliente nuevaFormaPago = new Forma_Pago_Cliente();
                nuevaFormaPago.nro_tarjeta = Int64.Parse(row.Cells[0].Value.ToString());
                string marca=row.Cells[1].Value.ToString();
                string descripcion = row.Cells[2].Value.ToString();
                Forma_Pago formaPagoGral = formasDePago.Find(formaPago => formaPago.marca.Equals(marca) && formaPago.descripcion.Equals(descripcion));
                nuevaFormaPago.id_forma_pago = formaPagoGral.id_forma_pago;
                listaFormasPago.Add(nuevaFormaPago);
            }

        }

        private void verificarCamposObligatorios()
        {
            if ((String.IsNullOrEmpty(nroBox.Text)) || (String.IsNullOrEmpty(comboTipo.SelectedItem.ToString())) || (String.IsNullOrEmpty(cuilBox.Text)) || String.IsNullOrEmpty(mailBox.Text) || String.IsNullOrEmpty(nameBox.Text) || String.IsNullOrEmpty(lastNameBox.Text))
            {
                throw new ArgumentException("Debe completar los datos obligatorios indicados");
            }
            this.validarFormatoCUIL();
            if (dataFormasPago.Rows.Count == 0) {
                throw new ArgumentException("Debe ingresar al menos un medio de pago");
            }

        }

        private void validarNumeroTarjeta()
        {
            foreach (DataGridViewRow row in dataFormasPago.Rows)
            {
                if (row.Cells["NroTarjeta"].Value.ToString().Equals(nroTarjetaBox.Text)) {
                    throw new Exception("Ya se agregó una tarjeta con el numero ingresado.");
                }
            }

            if (!(nroTarjetaBox.Text.Length.Equals(16) &&  nroTarjetaBox.Text.All(character => Char.IsDigit(character))))
            {
                throw new Exception("Formato incorrecto. Debe ingresar 16 numeros");
            }
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
            if (esModificacion && nuevasFormasDePago.Count == 0) {
                MessageBox.Show("Debe ingresar forma de pago. ");
            }
            if (dataFormasPago.RowCount == 0)
            {
                button2.Enabled = false;
            }
            else {
                button2.Enabled = true;
            }
        }

        private void cargarCombosTarjetas()
        {
            FormaPago_Manager formaPagoMng = new FormaPago_Manager();
            formasDePago = formaPagoMng.getFormasPagosValidas();
            List<String> marcasList = formasDePago.Select(formaPago => formaPago.marca).ToList();
            marcaBox.DataSource = (new HashSet<String>(marcasList).ToList());
            List<String> descripcionList = formasDePago.Select(formaPago => formaPago.descripcion).ToList();
            descripcionPagoBox.DataSource = (new HashSet<String>(descripcionList)).ToList();

        }

        private void agregarTarjetaBtn_Click(object sender, EventArgs e)
        {
            try
            {
                validarNumeroTarjeta();
                this.agregarNuevaTarjetaData(Int64.Parse(nroTarjetaBox.Text), marcaBox.SelectedValue.ToString(), descripcionPagoBox.SelectedValue.ToString());
                
                button2.Enabled = true;
            }
            catch (Exception exc) {
                MessageBox.Show(exc.Message,
                    "No pudo realizarse operacion",
                    MessageBoxButtons.OK,
                    MessageBoxIcon.Exclamation,
                    MessageBoxDefaultButton.Button1);
            }
            

        }

        private void agregarNuevaTarjetaData(Int64 nroTarjeta, string marca, string descripcion)
        {
            var index = dataFormasPago.Rows.Add();
            dataFormasPago.Rows[index].Cells["NroTarjeta"].Value = nroTarjeta.ToString();
            dataFormasPago.Rows[index].Cells["Descripcion"].Value = marca;
            dataFormasPago.Rows[index].Cells["Marca"].Value = descripcion;
        }

        private void button2_Click(object sender, EventArgs e)
        {
            if (dataFormasPago.SelectedRows.Count > 0)
            {

                foreach (DataGridViewRow row in dataFormasPago.SelectedRows)
                {
                    dataFormasPago.Rows.RemoveAt(row.Index);
                }
            }
            if (dataFormasPago.RowCount == 0)
            {
                button2.Enabled = false;
            }
            else
            {
                button2.Enabled = true;
            }
        }
    }
}
