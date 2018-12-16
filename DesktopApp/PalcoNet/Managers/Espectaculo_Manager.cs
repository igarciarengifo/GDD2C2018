﻿using PalcoNet.Entidades;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace PalcoNet.Managers {
    class Espectaculo_Manager {

        public List<Espectaculo> getEspectaculosPorEmpresa(int id_empresa) {
            DataTable resultTable = SQLManager.ejecutarDataTableStoreProcedure("LOOPP.SP_AllEspectaculosPorIdEmpresa",
                                        SQLArgumentosManager.nuevoParametro("@idEmpresa", id_empresa));

            List<Espectaculo> espectaculos = new List<Espectaculo>();

            if (resultTable != null && resultTable.Rows != null) {

                foreach (DataRow row in resultTable.Rows) {
                    Espectaculo especItem = new Espectaculo();
                    especItem.id_espectaculo = int.Parse(row["id_espectaculo"].ToString());
                    especItem.descripcion = row["descripcion"].ToString();
                    espectaculos.Add(especItem);
                }
            }

            return espectaculos;
        }

        public void nuevaPublicacion(int usuarioEmpresa, Double precioBase, string descripcion, string direccion, int id_grado_publicacion, int id_estadoPublicacion, int id_rubro, List<String> horariosSeleccionados, List<String> descripcionesUbicaciones, List<DateTime> fechasSeleccionadas)
        {
            DateTime fecha_publicacion = Convert.ToDateTime(ConfigurationManager.AppSettings["FechaSistema"]);
            DateTime fecha_vencimiento = fecha_publicacion.AddDays(7);
            foreach (DateTime fechaSeleccionada in fechasSeleccionadas)
            {
                foreach (String horarioSeleccionado in horariosSeleccionados)
                {
                    string resultadoEspectaculo = SQLManager.ejecutarEscalarQuery<string>("LOOPP.SP_NuevaPublicacion",
                        SQLArgumentosManager.nuevoParametro("@descripcion", descripcion).
                        add("@direccion", direccion)
                        .add("@id_grado_publicacion", id_grado_publicacion)
                        .add("@id_estado", id_estadoPublicacion)
                        .add("@rubro", id_rubro)
                        .add("@id_usuario", usuarioEmpresa)
                        .add("@fecha_publicacion", fecha_publicacion)
                        .add("@precio_base", precioBase)
                        .add("@fechaEspec", fechaSeleccionada)
                        .add("@horaEspec", horarioSeleccionado)
                        .add("@fechaVenc", fecha_vencimiento));

                    int idNuevoEspectaculo = Int32.Parse(resultadoEspectaculo);
                    if (idNuevoEspectaculo != -1)
                    {
                        
                        foreach (String descripcionUbicacionConID in descripcionesUbicaciones)
                        {

                            int id_ubicacion = Int32.Parse((descripcionUbicacionConID.Split('-').ElementAt(0)));
                            SQLManager.ejecutarNonQuery("LOOPP.SP_NuevaUbicac_X_Espectaculo",
                                SQLArgumentosManager.nuevoParametro("@id_espectaculo", idNuevoEspectaculo)
                                .add("@id_ubicacion", id_ubicacion)
                                .add("@id_grado_publicacion", id_grado_publicacion)
                                .add("@precio_base", precioBase));
                        }
                    }
                    else {
                        throw new Exception("Error al crear la publicacion. Intente nuevamente.");
                    }
                    
                }
            }
        }

        public List<Espectaculo> getPublicacionConId(int id_usuario)
        {
            DataTable resultTable = SQLManager.ejecutarDataTableStoreProcedure("LOOPP.SP_AllEspectaculosPorIdUsuario",
                                        SQLArgumentosManager.nuevoParametro("@idUsuario", id_usuario));

            List<Espectaculo> espectaculos = new List<Espectaculo>();

            if (resultTable != null && resultTable.Rows != null)
            {

                foreach (DataRow row in resultTable.Rows)
                {
                    Espectaculo especItem = this.BuildEspectaculo(row);
                    espectaculos.Add(especItem);
                }
            }
            return espectaculos;
        }

        public List<Espectaculo> getEspectaculosActivos() {
            DataTable resultTable = SQLManager.ejecutarDataTableStoreProcedure("LOOPP.SP_GetAllEspectaculos");
            List<Espectaculo> espectaculos = new List<Espectaculo>();

            if (resultTable != null && resultTable.Rows != null) {

                foreach (DataRow row in resultTable.Rows) {
                    Espectaculo especItem = new Espectaculo();
                    especItem.id_espectaculo = int.Parse(row["id_espectaculo"].ToString());
                    especItem.descripcion = row["descripcion"].ToString();
                    espectaculos.Add(especItem);
                }
            }

            return espectaculos;
        }

      /*  public List<Espectaculo> getEspectaculosActivos(int idEspec, string idList, DateTime fecDesde, DateTime fecHasta) {
            DataTable resultTable = SQLManager.ejecutarDataTableStoreProcedure("LOOPP.SP_FiltrarEspectaculos",
                                            SQLArgumentosManager.nuevoParametro("@idEspectaculo", idEspec)
                                                    .add("@idList", idList)
                                                    .add("@desde", fecDesde)
                                                    .add("@hasta", fecHasta));
            List<Espectaculo> espectaculos = new List<Espectaculo>();

            if (resultTable != null && resultTable.Rows != null) {

                foreach (DataRow row in resultTable.Rows) {
                    Espectaculo especItem = BuildEspecatculo(row);

                    espectaculos.Add(especItem);
                }
            }

            return espectaculos;

        }*/

        private Espectaculo BuildEspectaculo(DataRow row)
        {
            Espectaculo nuevoEspectaculo = new Espectaculo();
            nuevoEspectaculo.id_espectaculo = Convert.ToInt32(row["id_espectaculo"]);
            nuevoEspectaculo.descripcion = Convert.ToString(row["descripcion"]);
            nuevoEspectaculo.direccion = Convert.ToString(row["direccion"]);
            nuevoEspectaculo.fecha_publicacion = Convert.ToDateTime(row["fecha_publicacion"]);
            nuevoEspectaculo.id_estado_publicacion = Convert.ToInt32(row["id_estado_publicacion"]);
            nuevoEspectaculo.id_grado_publicacion = Convert.ToInt32(row["id_grado_publicacion"]);
            nuevoEspectaculo.id_usuario_responsable = Convert.ToInt32(row["id_usuario_responsable"]);
            nuevoEspectaculo.id_rubro = Convert.ToInt32(row["id_rubro"]);
            nuevoEspectaculo.precio_base = Convert.ToDouble(row["precio_base"]);
            return nuevoEspectaculo;
        }

        internal string getDescEstadoDePublicacion(int id_estado_publicacion)
        {
            return SQLManager.ejecutarEscalarQuery<string>("LOOPP.SP_GetDescripcionEstadoPublicacion",
                        SQLArgumentosManager.nuevoParametro("@idEstado", id_estado_publicacion));
        }

        internal List<string> getHorariosDeEspectaculo(int id_espectaculo)
        {
            DataTable resultTable = SQLManager.ejecutarDataTableStoreProcedure("LOOPP.SP_GetHorariosEspectaculo",
                                         SQLArgumentosManager.nuevoParametro("@id_Espectaculo", id_espectaculo));

            List<String> horarios = new List<String>();

            if (resultTable != null && resultTable.Rows != null)
            {

                foreach (DataRow row in resultTable.Rows)
                {

                    String hora = (row["hora_espectaculo"].ToString()).ToString();

                    horarios.Add(hora);
                }
            }

            return horarios;

        }

        public DataTable getEspectaculosFiltro(int idEspec, string idList, DateTime fecDesde, DateTime fecHasta)
        {
            DataTable resultTable = SQLManager.ejecutarDataTableStoreProcedure("LOOPP.SP_FiltrarEspectaculos",
                                            SQLArgumentosManager.nuevoParametro("@idEspectaculo", idEspec)
                                                    .add("@idList", idList)
                                                    .add("@desde", fecDesde)
                                                    .add("@hasta", fecHasta));
            return resultTable;
        }

    }
}
