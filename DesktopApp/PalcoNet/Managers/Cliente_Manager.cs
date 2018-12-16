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

        public DataTable buscarClientes(Cliente clienteABuscar)
        {
            DataTable resultTable = SQLManager.ejecutarDataTableStoreProcedure("LOOPP.SP_FiltrarClientes",
                                            SQLArgumentosManager.nuevoParametro("@nombre", clienteABuscar.nombre)
                                            .add("@apellido", clienteABuscar.apellido)
                                            .add("@email", clienteABuscar.mail)
                                            .add("@nroDoc", clienteABuscar.nro_documento));

            //List<Cliente> clientesEncontrados = new List<Cliente>();

            //if (resultTable != null && resultTable.Rows != null)
            //{
            //    foreach (DataRow row in resultTable.Rows)
            //    {
            //        Cliente clienteEncontrado = this.BuildCliente(row);
            //        clientesEncontrados.Add(clienteEncontrado);
            //    }
            //}

            return resultTable;
        }

        private Cliente BuildCliente(DataRow row)
        {
            Cliente cliente = new Cliente();
            cliente.id_cliente = int.Parse(row["id_cliente"].ToString());
            cliente.nombre = row["nombre"].ToString();
            cliente.apellido = row["apellido"].ToString();
            cliente.id_usuario = Int32.Parse(row["id_usuario"].ToString());
            cliente.tipo_documento = row["tipo_documento"].ToString();
            cliente.nro_documento = Int32.Parse(row["nro_documento"].ToString());
            cliente.mail = row["mail"].ToString();
            cliente.cuil = row["cuil"].ToString();
            cliente.fecha_nacimiento = (DateTime)row["fecha_nacimiento"];
            cliente.telefono = row["telefono"].ToString();
            cliente.direccion_calle = row["direccion_calle"].ToString();
            cliente.direccion_nro = int.Parse(row["direccion_nro"].ToString());
            if (row["direccion_piso"] != DBNull.Value)
            {
                cliente.direccion_piso = int.Parse(row["direccion_piso"].ToString());
            }
            
            cliente.direccion_depto = row["direccion_depto"].ToString();
            cliente.direccion_piso = int.Parse(row["direccion_piso"].ToString());
            cliente.direccion_depto = row["direccion_depto"].ToString();
            cliente.direccion_localidad = row["direccion_localidad"].ToString();
            cliente.codigo_postal = row["codigo_postal"].ToString();
            cliente.estado = row["estado"].ToString();
            cliente.baja_logica = (Boolean)row["baja_logica"];
            return cliente;
        }

        internal string modificarCliente(Cliente clienteModificacion)
        {
            return SQLManager.ejecutarEscalarQuery<string>("LOOPP.SP_ModificarCliente",
                                                SQLArgumentosManager.nuevoParametro("@nombre", clienteModificacion.nombre)
                                                .add("@apellido", clienteModificacion.apellido)
                                                .add("@tipo_doc", clienteModificacion.tipo_documento)
                                                .add("@documento", clienteModificacion.nro_documento)
                                                .add("@cuil", clienteModificacion.cuil)
                                                .add("@fecha_nac", clienteModificacion.fecha_nacimiento)
                                                .add("@mail", clienteModificacion.mail)
                                                .add("@telefono", clienteModificacion.telefono)
                                                .add("@calle", clienteModificacion.direccion_calle)
                                                .add("@nroCalle", clienteModificacion.direccion_nro)
                                                .add("@piso", clienteModificacion.direccion_piso)
                                                .add("@depto", clienteModificacion.direccion_depto)
                                                .add("@localidad", clienteModificacion.direccion_localidad)
                                                .add("@cod_postal", clienteModificacion.codigo_postal)
                                                .add("@baja_logica", clienteModificacion.baja_logica)
                                                .add("@idCliente", clienteModificacion.id_cliente));
                                                

        }

        internal Cliente getClientePorId(int idCliente)
        {
            DataTable resultTable = SQLManager.ejecutarDataTableStoreProcedure("LOOPP.SP_GetClientePorId", SQLArgumentosManager.nuevoParametro("@idCliente", idCliente));
            List<Cliente> lista_clientes = new List<Cliente>();

            if (resultTable != null && resultTable.Rows != null)
            {

                foreach (DataRow row in resultTable.Rows)
                {
                    Cliente cliente = BuildCliente(row);
                    lista_clientes.Add(cliente);
                }
            }

            return lista_clientes.ElementAt(0);
        }
    }
}
