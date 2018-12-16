using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace PalcoNet.Entidades
{
    public class Usuario
    {
        public int id_usuario;
        public String username { get; set; }
        public String password;
        public int loginFallidos;
        public bool habilitado  { get; set; }
    }
}
