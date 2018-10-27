﻿using PalcoNet.Entidades;
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
        Empresa_Manager empresaMng = new Empresa_Manager();
        public AltaEmpresaForm(Empresa empresa) {
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
                habilitadoCheck.Checked = empresa.esta_habilitado;

            }
            else {
                habilitadoCheck.Visible = false;
            }
            
            
        }
        public AltaEmpresaForm(string username, string passw)
        {
            InitializeComponent();
            user = username;
            pass = passw;
            habilitadoCheck.Visible = false;
            
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
                Empresa nuevaEmpresa = new Empresa();
                nuevaEmpresa.razon_social = razonSocialBox.Text;
                nuevaEmpresa.cuit = cuitBox.Text;
                nuevaEmpresa.mail = emailBox.Text;
                nuevaEmpresa.telefono= telBox.Text;
                nuevaEmpresa.direccion_calle = dirBox.Text;
                nuevaEmpresa.direccion_nro = Convert.ToInt32(nroCalle.Text);
                nuevaEmpresa.direccion_piso = Convert.ToInt32(pisoBox.Text);
                nuevaEmpresa.direccion_depto = deptoBox.Text;
                nuevaEmpresa.direccion_localidad = localidadBox.Text;
                nuevaEmpresa.ciudad = ciudadBox.Text;
                nuevaEmpresa.cod_postal = codPostalBox.Text;
             
                resultado = empresaMng.altaEmpresaYUsuario(user, pass, nuevaEmpresa);
                MessageBox.Show(resultado);
            }
            catch (Exception exc)
            {
                MessageBox.Show(exc.Message);
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