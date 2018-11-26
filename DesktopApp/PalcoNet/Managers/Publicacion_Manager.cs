using PalcoNet.Entidades;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace PalcoNet.Managers
{
    public class Publicacion_Manager
    {
        public void nuevaPublicacion(int usuarioEmpresa, Double precioBase, string descripcion, string direccion, Grado_Publicacion gradoPublicacion, Estado_Publicacion estadoPublicacion, Rubro rubro, List<String> horariosSeleccionados, List<Ubicacion> ubicaciones, List<DateTime> fechasSeleccionadas)
        {
            string resultadoEspectaculo = SQLManager.ejecutarEscalarQuery<string>("LOOPP.SP_NuevaPublicacion",
                        SQLArgumentosManager.nuevoParametro("@descripcion", descripcion).
                        add("@direccion", direccion)
                        .add("@id_grado_publicacion", gradoPublicacion.id_grado_publicacion)
                        .add("@id_estado", estadoPublicacion.id_estado_publicacion)
                        .add("@rubro", rubro.id_rubro)
                        .add("@id_usuario", usuarioEmpresa)
                        .add("@fecha_publicacion", Convert.ToDateTime(ConfigurationManager.AppSettings["FechaSistema"]))
                        .add("@precio_base", precioBase));
            if (resultadoEspectaculo != "error")
            {
                int idNuevoEspectaculo = Convert.ToInt32(resultadoEspectaculo);
                foreach (DateTime fechaSeleccionada in fechasSeleccionadas)
                {
                    foreach (String horarioSeleccionado in horariosSeleccionados)
                    {
                        foreach (Ubicacion ubicacion in ubicaciones)
                        {
                            SQLManager.ejecutarNonQuery("LOOPP.SP_NuevaUbicac_X_Espectaculo",
                                SQLArgumentosManager.nuevoParametro("@id_espectaculo", idNuevoEspectaculo)
                                .add("@id_ubicacion", ubicacion.id_ubicacion)
                                .add("@fecha_espectaculo", fechaSeleccionada)
                                .add("@hora_espectaculo", horarioSeleccionado));
                        }
                    }
                }
            }
            else {
                throw new Exception("Error al generarse la publicacion del espectaculo");
            }
            
        }

        internal List<Publicacion> getAllPublicaciones()
        {
            throw new NotImplementedException();
        }

        internal List<Publicacion> getPublicacionConId(int p)
        {
            throw new NotImplementedException();
        }
    }
}
