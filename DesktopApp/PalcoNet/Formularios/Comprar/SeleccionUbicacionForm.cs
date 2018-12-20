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
        }

        Compra_Manager compraMngr = new Compra_Manager();
        Tipo_Ubicacion_Manager tpUbicMngr = new Tipo_Ubicacion_Manager();
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
    }
}
