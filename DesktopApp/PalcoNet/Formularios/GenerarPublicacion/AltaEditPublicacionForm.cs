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
    public partial class AltaEditPublicacionForm : Form
    {
        Grados_Publicacion_Manager gradosPublicacionMng = new Grados_Publicacion_Manager();
        Estado_Publicacion_Manager estadosPublicacionMng = new Estado_Publicacion_Manager();
        Espectaculo_Manager espectaculoMng = new Espectaculo_Manager();
        Rubro_Manager rubrosMng = new Rubro_Manager();
        List<Ubicacion> ubicaciones = new List<Ubicacion>();
        List<DateTime> fechasSeleccionadas = new List<DateTime>();
        Boolean esModificacion;
        List<Ubicacion_X_Espectaculo> ubicacionesXEspec = new List<Ubicacion_X_Espectaculo>();

        public AltaEditPublicacionForm()
        {
            InitializeComponent();
            this.cargarOpciones();
            esModificacion =false;
        }

        private void cargarOpciones()
        {
            this.cargarRubros();
            this.cargarEstados();
            this.cargarGradosPublicacion();
            this.cargarHorarios();
            this.cargarUbicaciones();
            publicacionCalendar.MinDate = Convert.ToDateTime(ConfigurationManager.AppSettings["FechaSistema"]);
        }

        
        public AltaEditPublicacionForm(Espectaculo publicacionSeleccionada)
        {
            // TODO: Complete member initialization
            esModificacion = true;
            this.cargarOpciones();            
            descripcionBox.Text = publicacionSeleccionada.descripcion;
            gradosPublicacionBox.SelectedValue = publicacionSeleccionada.id_grado_publicacion;
            rubroBox.SelectedValue = publicacionSeleccionada.id_rubro;
            estadoBox.SelectedValue = publicacionSeleccionada.id_estado_publicacion;
            direccionBox.Text = publicacionSeleccionada.direccion;
            priceBox.Text = publicacionSeleccionada.precio_base.ToString();
            this.checkHorarios(this.getHorariosDeEspectaculo(publicacionSeleccionada.id_espectaculo));
            this.checkUbicaciones(this.getUbicacionesDeEspectaculo(publicacionSeleccionada.id_espectaculo));
            this.completarFechas(this.getFechasDeEspectaculo(publicacionSeleccionada.id_espectaculo));
        }

        private void completarFechas(HashSet<DateTime> fechasDelEspectaculo)
        {
            
            foreach(DateTime fechaEspectaculo in fechasDelEspectaculo){
                fechasSeleccionadasBox.Items.Add(fechaEspectaculo);
            }
        }

        private HashSet<DateTime> getFechasDeEspectaculo(int id_espectaculo)
        {
            List<DateTime> listaUbicaciones=ubicacionesXEspec.Select(ubicacion=> ubicacion.fecha_espectaculo).ToList();
            return new HashSet<DateTime>(listaUbicaciones);
            
        }

        private void checkUbicaciones(List<Ubicacion> ubicacionesEspectaculo)
        {
            for (int count = 0; count < ubicacionesListBox.Items.Count; count++)
            {
                if (ubicacionesEspectaculo.Any(ubicacion=> (ubicacion.fila+ubicacion.asiento).Equals(ubicacionesListBox.Items[count].ToString())))
                {
                    ubicacionesListBox.SetItemChecked(count, true);
                }
            }
        }

        private List<Ubicacion> getUbicacionesDeEspectaculo(int id_espectaculo)
        {
            Ubicaciones_Manager ubicacionMng = new Ubicaciones_Manager();
            return ubicacionMng.getUbicacionesEspectaculo(id_espectaculo);
        }

        private void checkHorarios(HashSet<String > horariosEspectaculo)
        {
            
            for (int count = 0; count < horariosListBox.Items.Count; count++)
            {
                if (horariosEspectaculo.Contains(horariosListBox.Items[count].ToString()))
                {
                    horariosListBox.SetItemChecked(count, true);
                }
            }
        }

        private HashSet<String> getHorariosDeEspectaculo(int id_espectaculo)
        {
            List<String> horarios = ubicacionesXEspec.Select(ubicacion => ubicacion.hora_espectaculo).ToList();
            return new HashSet<String>(horarios);
            
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
            for (DateTime date = fechaInicio; date <= fechaFin; date = date.AddDays(1)) {
                fechasSeleccionadas.Add(date);
                fechasSeleccionadasBox.Items.Add(date);
            }
            
            
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
            try
            {
                if (!esModificacion)
                {
                    this.generarNuevaPublicacion();

                }
                else
                {
                    this.modificarPublicacion();
                }
            }
            catch (Exception exc) {
                MessageBox.Show(exc.Message);
            }
        }

        private void modificarPublicacion()
        {
            throw new NotImplementedException();
        }

        private void generarNuevaPublicacion()
        {
            Espectaculo_Manager publicacionMng = new Espectaculo_Manager();
            
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
