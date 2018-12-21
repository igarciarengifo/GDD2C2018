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

namespace PalcoNet.Formularios.Comprar{
    public partial class SeleccionUbicacionForm : Form {
        public SeleccionUbicacionForm(Espectaculo espectaculo) {
            InitializeComponent();
            espectaculoItem = espectaculo;
            lblDescripcion.Text = espectaculo.descripcion;
            this.cargarTipoUbicacionCmb(espectaculo);
            this.cargarMediosPagoCmb();
        }

        Compra_Manager compraMngr = new Compra_Manager();
        Cliente_Manager clienteMngr = new Cliente_Manager();
        Tipo_Ubicacion_Manager tpUbicMngr = new Tipo_Ubicacion_Manager();
        FormaPago_Manager formaPagoMngr = new FormaPago_Manager();
        Ubicaciones_Manager ubicacionMngr = new Ubicaciones_Manager();
        Espectaculo espectaculoItem = new Espectaculo();
        List<Ubicacion> ubicacionesList = new List<Ubicacion>();

        private void cargarTipoUbicacionCmb(Espectaculo espectaculo) {
            List<Tipo_Ubicacion> tpUbicaciones = new List<Tipo_Ubicacion>();
            string feDesde = (espectaculo.fecha_espectaculo).ToString("dd-MM-yyyy");
            tpUbicaciones = tpUbicMngr.getTiposUbicacionXEspec(espectaculo.id_espectaculo, feDesde, 
                                                                espectaculo.hora_espectaculo);

            cmbTipoUbicacion.DisplayMember = "descripcion";
            cmbTipoUbicacion.ValueMember = "id_tipo_ubicacion";
            cmbTipoUbicacion.DataSource = tpUbicaciones;
        }

        private void cargarUbicacionCmb(Espectaculo espectaculo, int idTipoUbic) {
            List<Ubicacion> ubicaciones = new List<Ubicacion>();
            string feDesde = (espectaculo.fecha_espectaculo).ToString("dd-MM-yyyy");
            ubicaciones = ubicacionMngr.getUbicacionesEspectaculo(espectaculo.id_espectaculo, feDesde, 
                                                                espectaculo.hora_espectaculo, idTipoUbic);

            cmbUbicacion.DisplayMember = "descripcion";
            cmbUbicacion.ValueMember = "id_ubicacion";
            cmbUbicacion.DataSource = ubicaciones;
        }

        private void cargarMPNuevo() {
            List<Forma_Pago> formasPagos = new List<Forma_Pago>();
            formasPagos = formaPagoMngr.getFormasPagosValidas();
            cmbTipoMP.DisplayMember = "marca";
            cmbTipoMP.ValueMember = "id_forma_pago";
            cmbTipoMP.DataSource = formasPagos;         
        }

        private void cargarMediosPagoCmb() {
            List<Forma_Pago_Cliente> formasPagos = new List<Forma_Pago_Cliente>();
            Cliente cliente = clienteMngr.getClientePorIdUsuario(DatosSesion.id_usuario);
            formasPagos = clienteMngr.getMediosDePagoDeUsuario(cliente.id_cliente);
            if (formasPagos.Count > 0)
            {
                cmbMedioPago.DisplayMember = "marca";
                cmbMedioPago.ValueMember = "id_forma_pago_cliente";
                cmbMedioPago.DataSource = formasPagos;

                panelMP.Visible = false;
            }
            else {
                panelMP.Visible = true;
                this.cargarMPNuevo();
            }            
        }

        private void btnCancelar_Click(object sender, EventArgs e) {
            this.Dispose();
            this.Close();
        }

        private void cmbTipoUbicacion_SelectedIndexChanged(object sender, EventArgs e) {
            int idTpUbic = (int)cmbTipoUbicacion.SelectedValue;
            this.cargarUbicacionCmb(espectaculoItem, idTpUbic);

        }

        private void btnAgregar_Click(object sender, EventArgs e) {
            if (cmbUbicacion.SelectedValue != null) {
                Ubicacion ub = (Ubicacion)cmbUbicacion.SelectedItem;
                ubicacionesList.Add(ub);
                listSeleccionados.Items.Add(ub.descripcion);
            } else {
                MessageBox.Show("Debe seleccionar una ubicación.");
            }
        }

        private void btnNuevoMP_Click(object sender, EventArgs e) {
          
            if (cmbTipoMP.SelectedValue != null) {
                this.validarNumeroTarjeta();
                Cliente cliente = clienteMngr.getClientePorIdUsuario(DatosSesion.id_usuario);
                Forma_Pago_Cliente mp = new Forma_Pago_Cliente();
                mp.id_cliente = cliente.id_cliente;
                mp.id_forma_pago = (int)cmbTipoMP.SelectedValue;
                mp.nro_tarjeta = Int64.Parse(nroTarjetaBox.Text);
                string resultado = clienteMngr.altaDeMedioDePago(mp);
                if (resultado.Equals("OK")) {
                    this.cargarMediosPagoCmb();
                }
            }

        }

        private void validarNumeroTarjeta() {            
            if (!(nroTarjetaBox.Text.Length.Equals(16) && nroTarjetaBox.Text.All(character => Char.IsDigit(character)))) {
                throw new ArgumentException("Formato incorrecto. Debe ingresar 16 numeros.");
            }
        }

        private void btnComprar_Click(object sender, EventArgs e) {
            try
            {
                this.verificarCamposObligatorios();
                string idCadena = "";
                foreach (Ubicacion item in ubicacionesList) {
                    string id_ubic = (item.id_ubicacion).ToString();
                    idCadena += id_ubic + ",";
                }
                idCadena = idCadena.Substring(0, idCadena.Length - 1);
                Cliente cliente = clienteMngr.getClientePorIdUsuario(DatosSesion.id_usuario);
                Compra compra = new Compra();
                compra.id_cliente = cliente.id_cliente;
                compra.id_espectaculo = espectaculoItem.id_espectaculo;
                compra.listUbicaciones = idCadena;
                compra.id_medio_pago = (int)cmbMedioPago.SelectedValue;
                string resultado = compraMngr.comprarEntrada(compra);
                if (resultado.Equals("OK"))
                {
                    MessageBox.Show("La compra se ha realizado con éxito. Disfrute el espectáculo!");
                    this.Dispose();
                    this.Close();
                }
            }
            catch (Exception exc) {
                MessageBox.Show(exc.Message);
            }
            
        }

        private void verificarCamposObligatorios()
        {
            if (String.IsNullOrEmpty(cmbMedioPago.SelectedItem.ToString())) {
                throw new ArgumentException("Debe indicar un medio de pago.");
            }

            if (ubicacionesList.Count == 0) {
                throw new ArgumentException("Debe agregar por lo menos una entrada/ubicación.");
            }

        }

    }
}
