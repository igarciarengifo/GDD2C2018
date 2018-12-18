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
    public partial class AltaDePublicacion : Form
    {
        Ubicaciones_Manager ubicacionMng = new Ubicaciones_Manager();
        Grados_Publicacion_Manager gradosPublicacionMng = new Grados_Publicacion_Manager();
        Estado_Publicacion_Manager estadosPublicacionMng = new Estado_Publicacion_Manager();
        Espectaculo_Manager espectaculoMng = new Espectaculo_Manager();
        Rubro_Manager rubrosMng = new Rubro_Manager();

        public AltaDePublicacion()
        {
            InitializeComponent();
            this.cargarOpciones();
        }

        private void cargarOpciones()
        {
            this.cargarRubros();
            this.cargarEstados();
            this.cargarGradosPublicacion();
            this.cargarHorarios();
            this.cargarUbicaciones();
            publicacionCalendar.MinDate = DatosSesion.getFechaSistema();
        }

        private void cargarUbicaciones()
        {
            Ubicaciones_Manager ubicacionMng = new Ubicaciones_Manager();
            List<Ubicacion> ubicaciones = ubicacionMng.getAllUbicaciones();
            
            foreach (Ubicacion ubicacion in ubicaciones)
            {
                string descripcion = (ubicacion.id_ubicacion).ToString() + '-' + ubicacion.descripcion;
                ubicacionesListBox.Items.Add(descripcion);
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
            List<DateTime> fechasSeleccionadas = new List<DateTime>();
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
                this.validarCamposObligatorios();
             
                this.generarNuevaPublicacion();

                this.Dispose();
                this.Close();
            }
            catch (Exception exc) {
                MessageBox.Show(exc.Message);
            }
        }

        private void generarNuevaPublicacion()
        {
            Espectaculo_Manager publicacionMng = new Espectaculo_Manager();
            try {
                
                publicacionMng.nuevaPublicacion(DatosSesion.id_usuario,
                            Double.Parse(priceBox.Text),
                            descripcionBox.Text,
                            direccionBox.Text,
                            (int)gradosPublicacionBox.SelectedValue,
                            (int)estadoBox.SelectedValue,
                            (int)rubroBox.SelectedValue,
                            horariosListBox.CheckedItems.Cast<String>().ToList(),
                            ubicacionesListBox.CheckedItems.Cast<String>().ToList(),
                            fechasSeleccionadasBox.Items.Cast<DateTime>().ToList());
                MessageBox.Show("Se realizó correctamente la generación de la publicación");
            } catch (Exception exc ){
                MessageBox.Show(exc.Message);
            }
            
            
        }

        private void validarCamposObligatorios()
        {
            if ((ubicacionesListBox.CheckedItems.Count == 0) || (horariosListBox.CheckedItems.Count == 0) || (fechasSeleccionadasBox.Items.Count == 0))
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

            if (gradosPublicacionBox.SelectedItem.Equals("No Definido"))
            {
                throw new Exception("Debe indicar un grado de publicacion válido");
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

        private void plateaAltaBtn_Click(object sender, EventArgs e)
        {
            for (int count = 0; count < ubicacionesListBox.Items.Count; count++)
            {
                if (ubicacionesListBox.Items[count].ToString().Contains("Platea Alta"))
                {
                    if (ubicacionesListBox.CheckedItems.Contains(ubicacionesListBox.Items[count]))
                    {
                        ubicacionesListBox.SetItemChecked(count, false);
                    }
                    else {
                        ubicacionesListBox.SetItemChecked(count, true);
                    }
                    
                }
            }
        }

        private void plateaBajaBtn_Click(object sender, EventArgs e)
        {
            for (int count = 0; count < ubicacionesListBox.Items.Count; count++)
            {
                if (ubicacionesListBox.Items[count].ToString().Contains("Platea Baja"))
                {
                    if (ubicacionesListBox.CheckedItems.Contains(ubicacionesListBox.Items[count]))
                    {
                        ubicacionesListBox.SetItemChecked(count, false);
                    }
                    else
                    {
                        ubicacionesListBox.SetItemChecked(count, true);
                    }

                }
            }
        }

        private void vipBtn_Click(object sender, EventArgs e)
        {
            for (int count = 0; count < ubicacionesListBox.Items.Count; count++)
            {
                if (ubicacionesListBox.Items[count].ToString().Contains("-Vip-"))
                {
                    if (ubicacionesListBox.CheckedItems.Contains(ubicacionesListBox.Items[count]))
                    {
                        ubicacionesListBox.SetItemChecked(count, false);
                    }
                    else
                    {
                        ubicacionesListBox.SetItemChecked(count, true);
                    }

                }
            }
        }

        private void campoBtn_Click(object sender, EventArgs e)
        {
            for (int count = 0; count < ubicacionesListBox.Items.Count; count++)
            {
                if (ubicacionesListBox.Items[count].ToString().Contains("-Campo-"))
                {
                    if (ubicacionesListBox.CheckedItems.Contains(ubicacionesListBox.Items[count]))
                    {
                        ubicacionesListBox.SetItemChecked(count, false);
                    }
                    else
                    {
                        ubicacionesListBox.SetItemChecked(count, true);
                    }

                }
            }
        }

        private void campoVipBtn_Click(object sender, EventArgs e)
        {
            for (int count = 0; count < ubicacionesListBox.Items.Count; count++)
            {
                if (ubicacionesListBox.Items[count].ToString().Contains("Campo Vip"))
                {
                    if (ubicacionesListBox.CheckedItems.Contains(ubicacionesListBox.Items[count]))
                    {
                        ubicacionesListBox.SetItemChecked(count, false);
                    }
                    else
                    {
                        ubicacionesListBox.SetItemChecked(count, true);
                    }

                }
            }
        }

        private void pullmanBtn_Click(object sender, EventArgs e)
        {
            for (int count = 0; count < ubicacionesListBox.Items.Count; count++)
            {
                if (ubicacionesListBox.Items[count].ToString().Contains("-PullMan-"))
                {
                    if (ubicacionesListBox.CheckedItems.Contains(ubicacionesListBox.Items[count]))
                    {
                        ubicacionesListBox.SetItemChecked(count, false);
                    }
                    else
                    {
                        ubicacionesListBox.SetItemChecked(count, true);
                    }

                }
            }
        }

        private void superPullBtn_Click(object sender, EventArgs e)
        {
            for (int count = 0; count < ubicacionesListBox.Items.Count; count++)
            {
                if (ubicacionesListBox.Items[count].ToString().Contains("Super PullMan"))
                {
                    if (ubicacionesListBox.CheckedItems.Contains(ubicacionesListBox.Items[count]))
                    {
                        ubicacionesListBox.SetItemChecked(count, false);
                    }
                    else
                    {
                        ubicacionesListBox.SetItemChecked(count, true);
                    }

                }
            }
        }

        private void cabeceraBtn_Click(object sender, EventArgs e)
        {
            for (int count = 0; count < ubicacionesListBox.Items.Count; count++)
            {
                if (ubicacionesListBox.Items[count].ToString().Contains("Cabecera"))
                {
                    if (ubicacionesListBox.CheckedItems.Contains(ubicacionesListBox.Items[count]))
                    {
                        ubicacionesListBox.SetItemChecked(count, false);
                    }
                    else
                    {
                        ubicacionesListBox.SetItemChecked(count, true);
                    }

                }
            }
        }

        private void todasUbiBtn_Click(object sender, EventArgs e)
        {

            foreach (int i in ubicacionesListBox.CheckedIndices)
            {
                ubicacionesListBox.SetItemCheckState(i, CheckState.Unchecked);
            }

            for (int count = 0; count < ubicacionesListBox.Items.Count; count++)
            {
                
                if (ubicacionesListBox.CheckedItems.Contains(ubicacionesListBox.Items[count]))
                {
                    ubicacionesListBox.SetItemChecked(count, false);
                }
                else
                {
                    ubicacionesListBox.SetItemChecked(count, true);
                }

                
            }
        }
    }
}
