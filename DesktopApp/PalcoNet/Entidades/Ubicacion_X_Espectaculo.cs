using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace PalcoNet.Entidades
{
    public class Ubicacion_X_Espectaculo
    {
        public int id_espectaculo, id_ubicacion;
        public Double precio;
        public DateTime fecha_espectaculo, fecha_venc_espectaculo;
        public String hora_espectaculo;
        public Boolean disponible;
    }
}
