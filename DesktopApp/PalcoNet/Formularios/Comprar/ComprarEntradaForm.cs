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

namespace PalcoNet.Formularios.Comprar {
    public partial class ComprarEntradaForm : Form {
        public ComprarEntradaForm() {
            InitializeComponent();
            this.cargarCheckedListBox();
            this.cargarEspectaculosCmb();
        }
        Compra_Manager compraMngr = new Compra_Manager();
        Rubro_Manager rubroMngr = new Rubro_Manager();
        Espectaculo_Manager especMngr = new Espectaculo_Manager();

        private DataTable total_los_datos = new DataTable();
        private int total = 0;
        private int pagina = 0;
        private int maximo_paginas = 0;
        private int items_por_pagina = 10;

        public void cargarCheckedListBox() {
            List<Rubro> items = new List<Rubro>();
            items = rubroMngr.getAllRubros();

            foreach (Rubro func in items) {
                checkedListBox1.Items.Add(func, false);
            }
            checkedListBox1.DisplayMember = "descripcion";
            checkedListBox1.ValueMember = "id_rubro";
        }

        private void cargarEspectaculosCmb() {
            List<Espectaculo> espectaculos = new List<Espectaculo>();
            espectaculos = especMngr.getEspectaculosActivos();
            cmbEspectaculo.DisplayMember = "descripcion";
            cmbEspectaculo.ValueMember = "id_espectaculo";
            cmbEspectaculo.DataSource = espectaculos;
        }

        private void btnSalir_Click(object sender, EventArgs e) {
            this.Dispose();
            this.Close();
        }

        private void btnFiltrar_Click(object sender, EventArgs e) {
            if (this.verificarCamposObligatorios()) {
                string idCadena = "";
                foreach (Rubro item in checkedListBox1.CheckedItems) {
                    string id_Rubro = (item.id_rubro).ToString();
                    idCadena += id_Rubro + ",";
                }
                idCadena = idCadena.Substring(0, idCadena.Length - 1);
                int idEspectaculo = (int)cmbEspectaculo.SelectedValue;
                DateTime desde = dateTimePicker1.Value;
                DateTime hasta = dateTimePicker2.Value;
                DataTable datos = especMngr.getEspectaculosFiltro(idEspectaculo, idCadena, desde, hasta);
                if (datos.Rows.Count > 0) {
                    this.cargar_datos(datos);
                } else {
                    MessageBox.Show("No hay resultados.");
                }
                
            }
        }

        private bool verificarCamposObligatorios() {           
            if (cmbEspectaculo.SelectedValue == null) {
                MessageBox.Show("Debe elegir un espectáculo.");
                return false;
            }
            if (!(checkedListBox1.CheckedItems.Count > 0)){
                MessageBox.Show("Debe seleccionar por lo menos una categoría.");
                return false;
            }
            return true;
        }

        

        public void cargar_datos(DataTable dt) {
            total_los_datos = dt;
            total = dt.Rows.Count;
            double valor = total / items_por_pagina;
            maximo_paginas = Convert.ToInt32(Math.Ceiling(valor));
            lbl_total_paginas.Text = maximo_paginas.ToString();
            dgv_vista.DataSource = split(total_los_datos);
            habilitar_Botones();
        }

        private DataTable split(DataTable dt) {
            lbl_Pagina.Text = (pagina + 1).ToString();
            habilitar_Botones();
            return dt.Select().Skip(items_por_pagina * pagina).Take(items_por_pagina).CopyToDataTable();
        }

        private void btnSiguiente_Click(object sender, EventArgs e) {
            pagina = pagina + 1;
            dgv_vista.DataSource = split(total_los_datos);
        }

        private void btnPrevio_Click(object sender, EventArgs e) {
            pagina = pagina - 1;
            dgv_vista.DataSource = split(total_los_datos);
        }

        private void habilitar_Botones() {
            if (pagina == 0) {
                btnPrevio.Enabled = false;
            } else {
                btnPrevio.Enabled = true;
            }

            if (pagina == (maximo_paginas - 1)) {
                btnSiguiente.Enabled = false;
            } else {
                btnSiguiente.Enabled = true;
            }
        }

        private void btnPrimera_Click(object sender, EventArgs e) {
            pagina = 0;
            dgv_vista.DataSource = split(total_los_datos);
        }

        private void btnUltima_Click(object sender, EventArgs e) {
            pagina = maximo_paginas - 1;
            dgv_vista.DataSource = split(total_los_datos);
        }

    }
}
