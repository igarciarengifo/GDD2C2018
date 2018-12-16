﻿using PalcoNet.Entidades;
using PalcoNet.Formularios.GenerarPublicacion;
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

namespace PalcoNet.Formularios.EditarPublicacion
{
    public partial class EditarPublicacionForm : Form
    {
        DataTable publicacionesEncontradas;
        Espectaculo_Manager publicacionMng = new Espectaculo_Manager();
        public EditarPublicacionForm()
        {
            InitializeComponent();
            modificarPubli.Enabled = false;
        }

        private void button1_Click(object sender, EventArgs e)
        {
            try
            {
                if (String.IsNullOrEmpty(codPublicBox.Text))
                {
                    publicacionesEncontradas = publicacionMng.getEspectaculosPorUsuario(DatosSesion.id_usuario);
                }
                else
                {
                    publicacionesEncontradas = publicacionMng.getPublicacionConId(Convert.ToInt32(codPublicBox.Text));
                }

                if (publicacionesEncontradas.Rows.Count == 0)
                {
                    modificarPubli.Enabled = false;
                    throw new Exception("No existe espectaculo solicitado");
                }
                else {
                    publicacionGridView.DataSource = publicacionesEncontradas;
                    modificarPubli.Enabled = true;
                }
            }
            catch (Exception exc) {
                MessageBox.Show(exc.Message);
            }
            
            
        }

        private void modificarPubli_Click(object sender, EventArgs e)
        {
            try
            {
                if (publicacionGridView.DataSource != null && publicacionGridView.SelectedRows.Count > 0)
                {
                    foreach (DataGridViewRow row in publicacionGridView.SelectedRows)
                    {
                        Espectaculo publicacionSeleccionada = (Espectaculo)row.DataBoundItem;
                        if (this.getEstadoDePublicacion(publicacionSeleccionada.id_estado_publicacion) != "Borrador")
                        {
                            throw new Exception("La publicacion no se encuentra en un estado correcto. Debe ser BORRADOR ");
                        }
                        AltaEditPublicacionForm editForm = new AltaEditPublicacionForm(publicacionSeleccionada);
                        editForm.ShowDialog();
                        this.Dispose();
                        this.Close();
                    }
                }
            }
            catch (Exception exc) {
                MessageBox.Show(exc.Message);
            }
            
        }

        private string getEstadoDePublicacion(int id_estado_publicacion)
        {
            return publicacionMng.getDescEstadoDePublicacion(id_estado_publicacion);
        }

        private void cancelarBtn_Click(object sender, EventArgs e)
        {
            this.Dispose();
            this.Close();
        }
    }
}
