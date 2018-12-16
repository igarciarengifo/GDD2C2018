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

namespace PalcoNet.Formularios.EditarPublicacion
{
    public partial class EditarPublicacionForm : Form
    {
        Ubicaciones_Manager ubicacionMng = new Ubicaciones_Manager();
        Grados_Publicacion_Manager gradosPublicacionMng = new Grados_Publicacion_Manager();
        Estado_Publicacion_Manager estadosPublicacionMng = new Estado_Publicacion_Manager();
        Espectaculo_Manager espectaculoMng = new Espectaculo_Manager();
        Rubro_Manager rubrosMng = new Rubro_Manager();
        List<Ubicacion> ubicacionesActuales = new List<Ubicacion>();
        List<Ubicacion> nuevasUbicaciones = new List<Ubicacion>();
        private Espectaculo publicacionSeleccionada;
        private Espectaculo publicacionModificada;

        public EditarPublicacionForm()
        {
            InitializeComponent();
           
        }


        private void checkUbicaciones(List<Ubicacion> ubicacionesEspectaculo)
        {
            for (int count = 0; count < ubicacionesListBox.Items.Count; count++)
            {
                if (ubicacionesEspectaculo.Any(ubicacion => (ubicacion.fila + ubicacion.asiento).Equals(ubicacionesListBox.Items[count].ToString())))
                {
                    ubicacionesListBox.SetItemChecked(count, true);
                }
            }
        }

        private List<Ubicacion> getUbicacionesDeEspectaculo(int id_espectaculo)
        {
            Ubicaciones_Manager ubicacionMng = new Ubicaciones_Manager();
            ubicacionesActuales = ubicacionMng.getUbicacionesEspectaculo(id_espectaculo);
            return ubicacionesActuales;
        }

        private void cargarOpciones()
        {
            this.cargarRubros();
            this.cargarEstados();
            this.cargarGradosPublicacion();
            this.cargarHorarios();
            this.cargarUbicaciones();
            fechaEspectaculoPicker.MinDate = Convert.ToDateTime(ConfigurationManager.AppSettings["FechaSistema"]);
        }

        public EditarPublicacionForm(Espectaculo publicacionSeleccionada)
        {
            InitializeComponent();
            this.publicacionSeleccionada = publicacionSeleccionada;
            this.cargarOpciones();
            descripcionBox.Text = publicacionSeleccionada.descripcion;
            gradosPublicacionBox.SelectedValue = publicacionSeleccionada.id_grado_publicacion;
            rubroBox.SelectedValue = publicacionSeleccionada.id_rubro;
            estadoBox.SelectedValue = publicacionSeleccionada.id_estado_publicacion;
            direccionBox.Text = publicacionSeleccionada.direccion;
            priceBox.Text = publicacionSeleccionada.precio_base.ToString();
            horariosListBox.SelectedItem = publicacionSeleccionada.hora_espectaculo;
            this.checkUbicaciones(this.getUbicacionesDeEspectaculo(publicacionSeleccionada.id_espectaculo));
            fechaEspectaculoPicker.Value = publicacionModificada.fecha_espectaculo;
        }

        private void cancelarBtn_Click(object sender, EventArgs e)
        {
            this.Dispose();
            this.Close();
        }

        private void validarCamposObligatorios()
        {
            if (ubicacionesListBox.Items.Count == 0)
            {
                throw new Exception("Debe seleccionar ubicaciones para el espectaculo");
            }

            if (String.IsNullOrEmpty(descripcionBox.Text))
            {
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
            if (!(substrings.Count() == 2))
            {
                throw new Exception("El formato del precio no es el correcto. Debe separarse por coma");
            }
            if (!(substrings.All(subString => subString.All(character => Char.IsDigit(character)))))
            {
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
                    else
                    {
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

        private void aceptarBtn_Click(object sender, EventArgs e)
        {
            try
            {
                validarCamposObligatorios();
                publicacionModificada = new Espectaculo();
                publicacionModificada.id_espectaculo = publicacionSeleccionada.id_espectaculo;
                publicacionModificada.descripcion = this.descripcionBox.Text;
                publicacionModificada.precio_base = Convert.ToDouble(this.priceBox.Text);
                publicacionModificada.direccion = direccionBox.Text;
                publicacionModificada.id_grado_publicacion = (int)gradosPublicacionBox.SelectedValue;
                publicacionModificada.id_estado_publicacion = (int)estadoBox.SelectedValue;
                publicacionModificada.id_rubro = (int)rubroBox.SelectedValue;
                publicacionModificada.hora_espectaculo = horariosListBox.SelectedItem.ToString();
                publicacionModificada.fecha_espectaculo = fechaEspectaculoPicker.Value;
                espectaculoMng.modificarEspectaculo(publicacionModificada, publicacionSeleccionada, ubicacionesActuales, ubicacionesListBox.CheckedItems.Cast<String>().ToList());
                MessageBox.Show("Se realizó correctamente la generación de la publicación");

            }
            catch (Exception exc) {
                MessageBox.Show(exc.Message);
            }
        }
    }
}
