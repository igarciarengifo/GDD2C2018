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

namespace PalcoNet.Formularios.CanjePuntos
{
    public partial class CanjePuntosForm : Form
    {
        int puntosTotales;
        Catalogo_Manager catalogoMng = new Catalogo_Manager();
        public CanjePuntosForm()
        {
            InitializeComponent();
            dataCatalogo.CellClick += dataCatalogo_CellClick;
            this.cargarCatalogo();
            this.cargarPuntosTotales();
        }

        private void cargarPuntosTotales()
        {
            Cliente_Manager clienteMng = new Cliente_Manager();
            puntosTotales =clienteMng.getPuntosClienteConIdUsuario(DatosSesion.id_usuario);
            labelPuntos.Text = puntosTotales.ToString();
        }

        private void cargarCatalogo()
        {

            DataTable productosCatalogo = catalogoMng.getCatalogo();
            if (productosCatalogo.Rows.Count == 0)
            {
                MessageBox.Show("No se encontraron productos.");
            }
            else
            {
                dataCatalogo.DataSource = productosCatalogo;
                if (!(dataCatalogo.Columns.Contains("Canjear") && dataCatalogo.Columns["Canjear"].Visible))
                {
                    DataGridViewButtonColumn canjearBtn = new DataGridViewButtonColumn();
                    int indexColumn = productosCatalogo.Columns.Count;
                    dataCatalogo.Columns.Insert(indexColumn, canjearBtn);
                    canjearBtn.HeaderText = "Canjear";
                    canjearBtn.Name = "Canjear";
                    canjearBtn.Text = "Canje";
                }
               
            }
        }

        private void dataCatalogo_CellClick(object sender, DataGridViewCellEventArgs e)
        {
            if (e.ColumnIndex == dataCatalogo.Columns["Canjear"].Index)
            {
                int idProducto = Int32.Parse(dataCatalogo.Rows[e.RowIndex].Cells[1].Value.ToString());
                DateTime fechaCanje = DatosSesion.getFechaSistema();
                try
                {
                    int stockActual = Int32.Parse(dataCatalogo.Rows[e.RowIndex].Cells[2].Value.ToString());
                    int puntosRequeridos = Int32.Parse(dataCatalogo.Rows[e.RowIndex].Cells[4].Value.ToString());
                    this.validarCanje(stockActual, puntosRequeridos);
                    string resultado = catalogoMng.canjearProducto(idProducto, DatosSesion.id_usuario);
                    MessageBox.Show("Se realizó el canje correctamente. \n CODIGO DE CANJE: " + resultado);
                    cargarCatalogo();
                    this.cargarPuntosTotales();
                }
                catch (Exception exc)
                {
                    MessageBox.Show(exc.Message,
                   "No pudo realizarse operacion",
                   MessageBoxButtons.OK,
                   MessageBoxIcon.Exclamation,
                   MessageBoxDefaultButton.Button1);
                }

            }
        }

        private void validarCanje(int stockActual, int puntosRequeridos)
        {
            if (stockActual == 0) {
                throw new Exception("Sin stock.");
            }

            if (puntosTotales < puntosRequeridos) {
                throw new Exception("Puntos faltantes para el canje elegido.");
            }
        }

        private void cancelBtn_Click(object sender, EventArgs e)
        {
            this.Dispose();
            this.Close();
        }

        private void historialPuntosBtn_Click(object sender, EventArgs e)
        {
            HistorialPuntosForm historialPuntos = new HistorialPuntosForm();
            historialPuntos.ShowDialog();
        }
    }
}
