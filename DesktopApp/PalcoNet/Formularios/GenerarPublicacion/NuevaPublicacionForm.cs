using PalcoNet.Entidades;
using PalcoNet.Managers;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Configuration;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace PalcoNet.Formularios.GenerarPublicacion
{
    public partial class NuevaPublicacionForm : Form
    {
        Grados_Publicacion_Manager gradosPublicacionMng = new Grados_Publicacion_Manager();
        Estado_Publicacion_Manager estadosPublicacionMng = new Estado_Publicacion_Manager();
        Rubro_Manager rubrosMng = new Rubro_Manager();
        List<Ubicacion> ubicaciones = new List<Ubicacion>();
        List<DateTime> fechasSeleccionadas = new List<DateTime>();

        public NuevaPublicacionForm()
        {
            InitializeComponent();
            this.cargarRubros();
            this.cargarEstados();
            this.cargarGradosPublicacion();
            this.cargarHorarios();
            this.cargarUbicaciones();
            publicacionCalendar.MinDate = Convert.ToDateTime(ConfigurationManager.AppSettings["FechaSistema"]);
        }

        private void cargarUbicaciones()
        {
            Ubicaciones_Manager ubicacionMng = new Ubicaciones_Manager();
            ubicaciones = ubicacionMng.getAllUbicaciones();
            foreach (Ubicacion ubicacion in ubicaciones)
            {
                ubicacionesListBox.Items.Add(ubicacion.fila+ubicacion.asiento);
            }
        }

        private void cargarHorarios()
        {
            string hora;
            for (int i = 0; i <= 23; i++)
            {
                hora = i.ToString();
                if (i < 10)
                {
                    hora = '0' + hora;
                }
                horariosListBox.Items.Add(hora + ":00");
            }
        }

        private void cargarGradosPublicacion()
        {
            List<Grado_Publicacion> grados_publicacion = gradosPublicacionMng.getAllGradosPublicacion();
            gradosPublicacionBox.DisplayMember = "descripcion";
            gradosPublicacionBox.ValueMember = "id_grado_publicacion";
            gradosPublicacionBox.DataSource = grados_publicacion;
        }

        private void cargarEstados()
        {
            List<Estado_Publicacion> estados_publicacion = estadosPublicacionMng.getAllEstadosPublicacion();
            estadoBox.DisplayMember = "descripcion";
            estadoBox.ValueMember = "id_estado_publicacion";
            estadoBox.DataSource = estados_publicacion;
        }

        private void cargarRubros()
        {
            List<Rubro> rubros = rubrosMng.getAllRubros();
            rubroBox.DisplayMember = "descripcion";
            rubroBox.ValueMember = "id_rubro";
            rubroBox.DataSource = rubros;
        }

        private void cancelarBtn_Click(object sender, EventArgs e)
        {
            this.Dispose();
            this.Close();
        }

        private void agregarFechaBtn_Click(object sender, EventArgs e)
        {
            DateTime fechaInicio = publicacionCalendar.SelectionStart;
            DateTime fechaFin = publicacionCalendar.SelectionEnd;
            for (DateTime date = fechaInicio; date <= fechaFin; date = date.AddDays(1))
                fechasSeleccionadas.Add(date);
        }

        private void sacarFechaBtn_Click(object sender, EventArgs e)
        {
            for (int i = fechasSeleccionadasBox.SelectedIndices.Count - 1; i >= 0; i--)
            {
                fechasSeleccionadasBox.Items.RemoveAt(fechasSeleccionadasBox.SelectedIndices[i]);
            }
        }

        private void aceptarBtn_Click(object sender, EventArgs e)
        {
            Publicacion_Manager publicacionMng = new Publicacion_Manager();
            try
            {
                this.validarCamposObligatorios();
                publicacionMng.nuevaPublicacion(DatosSesion.id_usuario,
                            Double.Parse(priceBox.Text),
                            descripcionBox.Text,
                            direccionBox.Text,
                            (Grado_Publicacion)gradosPublicacionBox.SelectedValue, 
                            (Estado_Publicacion)estadoBox.SelectedValue, 
                            (Rubro)rubroBox.SelectedValue, 
                            horariosListBox.Items.Cast<String>().ToList(), 
                            ubicacionesListBox.Items.Cast<Ubicacion>().ToList(), 
                            fechasSeleccionadasBox.Items.Cast<DateTime>().ToList());
                MessageBox.Show("Se realizó correctamente la generación de la publicación");
            }
            catch (Exception exc) {
                MessageBox.Show(exc.Message);
            }
            

        }

        private void validarCamposObligatorios()
        {
            if ((horariosListBox.Items.Count == 0) || (ubicacionesListBox.Items.Count == 0) || (fechasSeleccionadasBox.Items.Count == 0))
            {
                throw new Exception("Debe ingresarse horarios, ubicaciones y fechas del espectaculo");
            }

            if (String.IsNullOrEmpty(descripcionBox.Text)) {
                throw new Exception("Debe ingresarse una descripcion");
            }

            if (String.IsNullOrEmpty(direccionBox.Text))
            {
                throw new Exception("Debe ingresarse una direccion");
            }

            this.validarCampoPrecio();
        }

        private void validarCampoPrecio()
        {
            string[] substrings = priceBox.Text.Split(',');
            if (!(substrings.Count()==2)) {
                throw new Exception("El formato del precio no es el correcto. Debe separarse por coma");
            }
            if (!(substrings.All(subString => subString.All(character => Char.IsDigit(character))))){
                throw new Exception("El formato del precio no es el correcto. Solo debe contener numeros");
            }
        }
    }
}
