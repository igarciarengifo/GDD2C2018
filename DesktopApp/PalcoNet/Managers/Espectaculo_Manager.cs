using PalcoNet.Entidades;
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

        public List<Espectaculo> getEspectaculosActivos()
        {
            DataTable resultTable = SQLManager.ejecutarDataTableStoreProcedure("LOOPP.SP_GetAllEspectaculos");
            List<Espectaculo> espectaculos = new List<Espectaculo>();
            if (resultTable != null && resultTable.Rows != null)
            {
                foreach (DataRow row in resultTable.Rows)
                {
                    Espectaculo especItem = new Espectaculo();
                    especItem.id_espectaculo = int.Parse(row["id_espectaculo"].ToString());
                    especItem.descripcion = row["descripcion"].ToString();
                    espectaculos.Add(especItem);
                }
            }
            return espectaculos;
        }

        public DataTable getPublicacionFiltradaConId(int id_publicacion)
        {
            DataTable resultTable = SQLManager.ejecutarDataTableStoreProcedure("LOOPP.SP_GetEspectaculoFiltradoPorId",
                                        SQLArgumentosManager.nuevoParametro("@idEspectaculo", id_publicacion));



            return resultTable;
        }

        public DataTable getEspectaculosFiltro(int idEspec, string idList, string fecDesde, string fecHasta)
        {
            DataTable resultTable = SQLManager.ejecutarDataTableStoreProcedure("LOOPP.SP_FiltrarEspectaculos",
                                            SQLArgumentosManager.nuevoParametro("@idEspectaculo", idEspec)
                                                    .add("@idList", idList)
                                                    .add("@desde", fecDesde)
                                                    .add("@hasta", fecHasta));
            return resultTable;
        }


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

        internal DataTable getEspectaculosPorUsuario(int idUsuario)
        {
            DataTable resultTable = SQLManager.ejecutarDataTableStoreProcedure("LOOPP.SP_AllEspectaculosPorIdUsuario",
                                            SQLArgumentosManager.nuevoParametro("@idUsuario", idUsuario));
                                            
            return resultTable;
        }

        internal Espectaculo getEspectaculoPorID(int idEspectaculo)
        {
            DataTable resultTable = SQLManager.ejecutarDataTableStoreProcedure("LOOPP.SP_GetEspectaculoPorId", 
                                        SQLArgumentosManager.nuevoParametro("@idEspectaculo", idEspectaculo));
            List<Espectaculo> espectaculos = new List<Espectaculo>();
            if (resultTable != null && resultTable.Rows != null)
            {
                foreach (DataRow row in resultTable.Rows)
                {
                    Espectaculo espectaculo = BuildEspectaculo(row);
                    espectaculos.Add(espectaculo);
                }
            }
            return espectaculos.ElementAt(0);
        }

        internal void modificarEspectaculo(Espectaculo publicacionModificada, Espectaculo publicacionSeleccionada, List<Ubicacion> ubicacionesActuales, List<string> descripcionUbicaciones)
        {
            string resultadoEspectaculo = SQLManager.ejecutarEscalarQuery<string>("LOOPP.SP_ModificarPublicacion",
                SQLArgumentosManager.nuevoParametro("@descripcion", publicacionModificada.descripcion).
                add("@direccion", publicacionModificada.direccion)
                .add("@id_grado_publicacion", publicacionModificada.id_grado_publicacion)
                .add("@id_estado", publicacionModificada.id_estado_publicacion)
                .add("@rubro", publicacionModificada.id_rubro)
                .add("@precio_base", publicacionModificada.precio_base)
                .add("@fechaEspec", publicacionModificada.fecha_espectaculo)
                .add("@horaEspec", publicacionModificada.hora_espectaculo)
                .add("@id_espectaculo", publicacionModificada.id_espectaculo));
            if (resultadoEspectaculo.Equals("OK")) {
                foreach (String descripcionUbicacionConID in descripcionUbicaciones)
                {

                    int id_ubicacion_nuevo = Int32.Parse((descripcionUbicacionConID.Split('-').ElementAt(0)));
                    if (!(ubicacionesActuales.Any(ubicacion => ubicacion.id_ubicacion == id_ubicacion_nuevo))) {
                        SQLManager.ejecutarNonQuery("LOOPP.SP_NuevaUbicac_X_Espectaculo",
                        SQLArgumentosManager.nuevoParametro("@id_espectaculo", publicacionModificada.id_espectaculo)
                        .add("@id_ubicacion", id_ubicacion_nuevo)
                        .add("@id_grado_publicacion", publicacionModificada.id_grado_publicacion)
                        .add("@precio_base", publicacionModificada.precio_base));
                    }
                    
                }
                foreach (Ubicacion ubicacionActual in ubicacionesActuales)
                {
                    if (!(descripcionUbicaciones.Any(descripcionUbi => ubicacionActual.id_ubicacion == Int32.Parse((descripcionUbi.Split('-').ElementAt(0))))))
                    {
                        SQLManager.ejecutarNonQuery("LOOPP.SP_EliminarUbicacion_X_Esp",
                        SQLArgumentosManager.nuevoParametro("@id_espectaculo", publicacionModificada.id_espectaculo)
                        .add("@id_ubicacion", ubicacionActual.id_ubicacion));
                    }
                }
            }
        }
    }
}
