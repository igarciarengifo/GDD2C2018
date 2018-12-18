using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using PalcoNet.Managers;
using PalcoNet.Entidades;

namespace PalcoNet.Formularios.HistorialCliente
{
    public partial class HistorialClienteForm : Form {

        public HistorialClienteForm() {
            InitializeComponent();
            DataTable resultTable = clienteMngr.getHistorialCliente(DatosSesion.id_usuario);
            if (resultTable != null && resultTable.Rows.Count > 0){
                this.cargar_datos(resultTable);
            }
            else {
                MessageBox.Show("No posee información de compras.");
            }
            
        }
        Cliente_Manager clienteMngr = new Cliente_Manager();

        private void cerrar_ventana(object sender, EventArgs e)
        {
            this.Dispose();
            this.Close();
        }

        private DataTable total_los_datos = new DataTable();
        private int total = 0;
        private int pagina = 0;
        private int maximo_paginas = 0;
        private int items_por_pagina = 10;

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

        private void btnSalir_Click(object sender, EventArgs e) {
            this.Dispose();
            this.Close();
        }

    }
}
