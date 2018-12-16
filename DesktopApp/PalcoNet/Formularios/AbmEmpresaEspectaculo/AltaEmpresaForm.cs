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

namespace PalcoNet.Formularios.AbmEmpresaEspectaculo
{
    public partial class AltaEmpresaForm : Form
    {
        string user, pass, resultado;
        Boolean esModificacion;
        Empresa empresaModificacion;
        Empresa_Manager empresaMng = new Empresa_Manager();
        public AltaEmpresaForm(Empresa empresa) {

            InitializeComponent();
            if (empresa.id_empresa != 0)
            {
                habilitadoCheck.Visible = true;
                razonSocialBox.Text = empresa.razon_social;
                cuitBox.Text = empresa.cuit;
                emailBox.Text = empresa.mail;
                telBox.Text = empresa.telefono;
                dirBox.Text = empresa.direccion_calle;
                nroCalle.Text = empresa.direccion_nro.ToString();
                pisoBox.Text = empresa.direccion_piso.ToString();
                deptoBox.Text = empresa.direccion_depto;
                localidadBox.Text = empresa.direccion_localidad;
                ciudadBox.Text = empresa.ciudad;
                codPostalBox.Text = empresa.cod_postal;
                habilitadoCheck.Checked = empresa.baja_logica;
                esModificacion = true;
                empresaModificacion = empresa;
            }
            else {
                habilitadoCheck.Visible = false;
                esModificacion = false;
            }
            
            
        }
        public AltaEmpresaForm(string username, string passw)
        {
            InitializeComponent();
            user = username;
            pass = passw;
            habilitadoCheck.Visible = false;
            esModificacion = false;
            
        }

        internal string getResultado()
        {
            return resultado;
        }

        private void button2_Click(object sender, EventArgs e)
        {
            this.Dispose();
            this.Close();
        }

        private void button1_Click(object sender, EventArgs e)
        {
            try
            {
                this.verificarCamposObligatorios();
                if (!esModificacion)
                {
                    this.nuevaEmpresa();
                }
                else {
                    this.modificarEmpresa(empresaModificacion);
                }
            }catch (Exception exc)
            {
                MessageBox.Show(exc.Message);
            }
        }

        private void modificarEmpresa(Empresa empresaModificacion)
        {
            empresaModificacion.razon_social = razonSocialBox.Text;
            empresaModificacion.cuit = cuitBox.Text;
            empresaModificacion.mail = emailBox.Text;
            empresaModificacion.telefono = telBox.Text;
            empresaModificacion.direccion_calle = dirBox.Text;
            empresaModificacion.direccion_nro = Convert.ToInt32(nroCalle.Text);
            empresaModificacion.direccion_piso = this.completarPiso();
            empresaModificacion.direccion_depto = deptoBox.Text;
            empresaModificacion.direccion_localidad = localidadBox.Text;
            empresaModificacion.ciudad = ciudadBox.Text;
            empresaModificacion.cod_postal = codPostalBox.Text;
            empresaModificacion.baja_logica = habilitadoCheck.Checked;
            resultado = empresaMng.modificarEmpresa(empresaModificacion);
            
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

        private void nuevaEmpresa()
        {
            Empresa nuevaEmpresa = new Empresa();
            nuevaEmpresa.razon_social = razonSocialBox.Text;
            nuevaEmpresa.cuit = cuitBox.Text;
            nuevaEmpresa.mail = emailBox.Text;
            nuevaEmpresa.telefono = telBox.Text;
            nuevaEmpresa.direccion_calle = dirBox.Text;
            nuevaEmpresa.direccion_nro = Convert.ToInt32(nroCalle.Text);
            nuevaEmpresa.direccion_piso = this.completarPiso();
            nuevaEmpresa.direccion_depto = deptoBox.Text;
            nuevaEmpresa.direccion_localidad = localidadBox.Text;
            nuevaEmpresa.ciudad = ciudadBox.Text;
            nuevaEmpresa.cod_postal = codPostalBox.Text;

            resultado = empresaMng.altaEmpresaYUsuario(user, pass, nuevaEmpresa);
            String[] arrayResultado = resultado.Split(';');
            string passToHash;
            if (arrayResultado.ElementAt(2).Equals("OK"))
            {
                Usuario_Manager userMng = new Usuario_Manager();
                MessageBox.Show("Se realizaron los cambios correctamente.", "Resultado operacion");
                if (user == null)
                {
                    MessageBox.Show("La nueva contraseña es: " + arrayResultado.ElementAt(1) + ".\n El usuario es: " + nuevaEmpresa.cuit, "Operacion correcta");
                    passToHash = arrayResultado.ElementAt(1);
                    this.DialogResult = DialogResult.OK;
                }
                else {
                    passToHash = pass;
                }
                String passHash = Encriptacion.getHashSha256(passToHash);
                userMng.cambiarPassword(passHash, Convert.ToInt32(arrayResultado.ElementAt(0))); 
                this.Dispose();
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

        private Nullable<int> completarPiso()
        {
            if (String.IsNullOrEmpty(pisoBox.Text))
            {
                return null;
            }
            else {
                return Convert.ToInt32(pisoBox.Text);
            }
        }

        private void verificarCamposObligatorios()
        {
            if ((String.IsNullOrEmpty(razonSocialBox.Text)) || (String.IsNullOrEmpty(cuitBox.Text)) || String.IsNullOrEmpty(emailBox.Text))
            {
                throw new ArgumentException("Debe completar los datos de usuario y contraseña");
            }
            this.validarFormatoCUIT();
        }

        private void validarFormatoCUIT()
        {
            if (!cuitBox.Text.Contains("-"))
            {
                throw new Exception("Formato incorrecto. El formato correcto es ##-########-##");
            }

            string[] substrings = cuitBox.Text.Split('-');

            //Si tiene tres partes separadas por  - y todas son numeros
            if (!(substrings.Length.Equals(3) && substrings.All(substring => substring.All(character => Char.IsDigit(character)))))
            {
                throw new Exception("Formato incorrecto. El formato correcto es ##-########-##");
            }

            if (!(substrings.ElementAt(0).Length.Equals(2) && substrings.ElementAt(1).Length.Equals(8) && substrings.ElementAt(2).Length.Equals(2)))
            {
                throw new Exception("Formato incorrecto. El formato correcto es ##-########-##");
            } 
        }
    }
}
