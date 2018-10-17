using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace PalcoNet.Entidades
{
    public class DatosSesion
    {
        public static int id_usuario { get; set; }
        public static string username { get; set; }
        public static string password { get; set; } //encriptada
        public static int id_rol { get; set; }
        public static List<Funcionalidad> funcionalidades { get; set; }
        public static bool sesion_iniciada = false;

        public static void iniciarSesion(int iduser, string usuario, string pass, int idRol, List<Funcionalidad> listaF)
        {
            id_usuario = iduser;
            password = pass;
            id_rol = idRol;
            funcionalidades = listaF;
            sesion_iniciada = true;
            username = usuario;
        }
    }
}
