using PalcoNet.Entidades;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace PalcoNet.Managers
{
    class Login_Manager
    {
        Usuario_Manager usuario_Mgr = new Usuario_Manager();
        public int iniciarLogin(string user, string passHash)
        {
            int id_usuario =0;
            Usuario usuarioLogin = usuario_Mgr.getUsuario(user);
            if (usuarioLogin != null)
            {
                if (!(usuarioLogin.habilitado))
                {
                    throw new System.ArgumentException("Usuario inhabilitado. Contacte con su Administrador para desbloquear la cuenta");
                }
                
                if (usuarioLogin.password.Equals(passHash))
                {
                    id_usuario = usuarioLogin.id_usuario;
                    Boolean esUsuarioInconsistente = usuario_Mgr.hasInvalidData(id_usuario);
                    if (esUsuarioInconsistente) {
                        throw new Exception("El usuario tiene datos personales inconsistentes. Contacte con el administrador para realizar los cambios.");
                    }
                    usuario_Mgr.reiniciarIntentos(usuarioLogin.id_usuario);
                }
                else {
                    usuario_Mgr.agregarIntentoFallido(usuarioLogin.id_usuario);
                    if ((usuarioLogin.loginFallidos + 1)>= 3)
                    {
                        if (this.bloquearUsuario(usuarioLogin.id_usuario) > 0)
                        {
                            throw new System.ArgumentException("Se superaron los intentos para iniciar sesion. Usuario bloqueado. Contacte con su Administrador para desbloquear la cuenta");
                        }
                    }
                    else {
                        throw new System.ArgumentException("Contraseña incorrecta. Reingrese contraseña");
                    }
                }
            }
            else {
                throw new System.ArgumentException("No existe username ingresado. Genere uno nuevo");
            }

            return id_usuario;
        }

        private int bloquearUsuario(int id_usuario)
        {
            return (SQLManager.ejecutarNonQuery("LOOPP.SP_BloquearUsuario",
                                SQLArgumentosManager.nuevoParametro("@id_usuario", id_usuario)));
        }

        public Boolean esPrimerLogueo(int id_usuario)
        {
            return usuario_Mgr.esPrimerLogueo(id_usuario);
        }
    }
}
