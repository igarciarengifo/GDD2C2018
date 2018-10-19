using PalcoNet.Entidades;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace PalcoNet.Managers
{
    public class Cliente_Manager
    {

        public string altaClienteYUsuario(string user, string pass, Cliente nuevaPersona)
        {
           return SQLManager.ejecutarEscalarQuery<string> ("LOOPP.SP_NuevoCliente",
                                                 SQLArgumentosManager.nuevoParametro("@nombre",nuevaPersona.nombre)
                                                 .add("@apellido",nuevaPersona.apellido)
                                                 .add("@tipo_doc",nuevaPersona.tipo_documento)
                                                 .add("@documento", nuevaPersona.nro_documento)
                                                 .add("@cuil", nuevaPersona.cuil)
                                                 .add("@fecha_nac", nuevaPersona.fecha_nacimiento)
                                                 .add("@mail", nuevaPersona.mail)
                                                 .add("@telefono", nuevaPersona.telefono)
                                                 .add("@calle", nuevaPersona.direccion_calle)
                                                 .add("@nroCalle", nuevaPersona.direccion_nro)
                                                 .add("@piso", nuevaPersona.direccion_piso)
                                                 .add("@depto", nuevaPersona.direccion_depto)
                                                 .add("@localidad", nuevaPersona.direccion_localidad)
                                                 .add("@cod_postal", nuevaPersona.codigo_postal)
                                                 .add("@user", user)
                                                 .add("@pass", pass));

        }
    }
}
