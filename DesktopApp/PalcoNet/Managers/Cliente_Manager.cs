using PalcoNet.Entidades;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace PalcoNet.Managers
{
    public class Cliente_Manager
    {

        public ResultadoAltaCliente altaClienteYUsuario(string user, string pass, Cliente nuevaPersona, List<Forma_Pago_Cliente> nuevasFormasPago)
        {
            DataTable resultTable = SQLManager.ejecutarDataTableStoreProcedure("LOOPP.SP_NuevoCliente",
                                                 SQLArgumentosManager.nuevoParametro("@nombre", nuevaPersona.nombre)
                                                 .add("@apellido", nuevaPersona.apellido)
                                                 .add("@tipo_doc", nuevaPersona.tipo_documento)
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

            ResultadoAltaCliente resultadoAlta = new ResultadoAltaCliente();

            if (resultTable != null && resultTable.Rows != null)
            {
                foreach (DataRow row in resultTable.Rows)
                {

                    resultadoAlta.resultadoCliente = row["resultadoCliente"].ToString();
                    resultadoAlta.id_usuario = Int32.Parse(row["id_usuario"].ToString());
                    resultadoAlta.id_cliente = Int32.Parse(row["id_cliente"].ToString());
                    resultadoAlta.username = row["username"].ToString();
                    resultadoAlta.password = row["password"].ToString();
                }
            }

            if (resultadoAlta.resultadoCliente.Equals("OK"))
            {
                foreach (Forma_Pago_Cliente nuevaFormaPago in nuevasFormasPago)
                {
                    nuevaFormaPago.id_cliente = resultadoAlta.id_cliente;
                    string resultadoTarjeta = this.altaDeMedioDePago(nuevaFormaPago);
                    if (!(resultadoTarjeta.Equals("OK")))
                    {
                        resultadoAlta.resultadoTarjeta = resultadoTarjeta;
                        MessageBox.Show(resultadoAlta.resultadoTarjeta+" con numero de tarjeta " + nuevaFormaPago.nro_tarjeta.ToString());
                    }
                }
            }

            return resultadoAlta;


        }


        public string altaDeMedioDePago(Forma_Pago_Cliente nuevaFormaPago)
        {
            return SQLManager.ejecutarEscalarQuery<string>("LOOPP.SP_InsertarMedioPago",
                                             SQLArgumentosManager.nuevoParametro("@idCliente", nuevaFormaPago.id_cliente)
                                             .add("@idFormaPago", nuevaFormaPago.id_forma_pago)
                                             .add("@nro", nuevaFormaPago.nro_tarjeta));


        }

        public List<Forma_Pago_Cliente> getMediosDePagoDeUsuario(int id_cliente)
        {
            List<Forma_Pago_Cliente> formasPagosActuales = new List<Forma_Pago_Cliente>();
            DataTable resultTable = SQLManager.ejecutarDataTableStoreProcedure("LOOPP.SP_GetMedioPagoXCliente",
                                            SQLArgumentosManager.nuevoParametro("@idCliente", id_cliente));
            if (resultTable != null && resultTable.Rows != null)
            {
                foreach (DataRow row in resultTable.Rows)
                {
                    Forma_Pago_Cliente forma_pago_cliente = new Forma_Pago_Cliente();
                    forma_pago_cliente.id_cliente = Int32.Parse(row["id_cliente"].ToString());
                    forma_pago_cliente.id_forma_pago = Int32.Parse(row["id_forma_pago"].ToString());
                    forma_pago_cliente.id_forma_pago_cliente = Int32.Parse(row["id_forma_pago_cliente"].ToString());
                    forma_pago_cliente.nro_tarjeta = Int64.Parse(row["nro_tarjeta"].ToString());
                    formasPagosActuales.Add(forma_pago_cliente);
                }
            }
            return formasPagosActuales;
        }


        public DataTable buscarClientes(Cliente clienteABuscar)
        {
            DataTable resultTable = SQLManager.ejecutarDataTableStoreProcedure("LOOPP.SP_FiltrarClientes",
                                            SQLArgumentosManager.nuevoParametro("@nombre", clienteABuscar.nombre)
                                            .add("@apellido", clienteABuscar.apellido)
                                            .add("@email", clienteABuscar.mail)
                                            .add("@nroDoc", clienteABuscar.nro_documento));

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
            
            cliente.direccion_localidad = row["direccion_localidad"].ToString();
            cliente.codigo_postal = row["codigo_postal"].ToString();
            cliente.estado = row["estado"].ToString();
            cliente.baja_logica = (Boolean)row["baja_logica"];
            return cliente;
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

        internal int getPuntosClienteConIdUsuario(int idUsuario)
        {
            return SQLManager.ejecutarEscalarQuery<int>("LOOPP.SP_GetPuntosClienteConIdUsuario",
                SQLArgumentosManager.nuevoParametro("@idUsuario", idUsuario)
                                    .add("@fechaActual", DatosSesion.getFechaSistema()));

        }

        public DataTable getHistorialCliente(int id_usuario) {
            DataTable resultTable = SQLManager.ejecutarDataTableStoreProcedure("LOOPP.SP_HistorialComprasCliente",
                                                //SQLArgumentosManager.nuevoParametro("@idUsuario", 2)));
                                            SQLArgumentosManager.nuevoParametro("@idUsuario", id_usuario));
            return resultTable;

        }

        internal DataTable getCanjesDeUsuario(int id_usuario)
        {
            DataTable resultTable = SQLManager.ejecutarDataTableStoreProcedure("LOOPP.SP_GetHistorialCanje",
                                            SQLArgumentosManager.nuevoParametro("@idUsuario", id_usuario));
            return resultTable;

        }

        internal string modificarCliente(Boolean estaInhabilitado, Cliente clienteModificacion, List<Forma_Pago_Cliente> nuevasFormasDePago, List<Forma_Pago_Cliente> formasPagoModificadas)
        {
            string resultado = SQLManager.ejecutarEscalarQuery<string>("LOOPP.SP_ModificarCliente",
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
                                                .add("@idCliente", clienteModificacion.id_cliente)
                                                .add("@estaInhabilitado", estaInhabilitado));
            
            foreach (Forma_Pago_Cliente formaPagoActual in nuevasFormasDePago) {
                if (!(formasPagoModificadas.Any(formaPagoModificada => formaPagoModificada.nro_tarjeta==formaPagoActual.nro_tarjeta && formaPagoModificada.id_forma_pago==formaPagoActual.id_forma_pago))) {
                    string resultadoBajaTarjeta = this.eliminarFormaPagoCliente(formaPagoActual);
                    if (!(resultadoBajaTarjeta.Equals("OK"))) {
                        MessageBox.Show(resultadoBajaTarjeta + "\nTarjeta N°: "+formaPagoActual.nro_tarjeta.ToString());
                    }
                }
            }
            foreach (Forma_Pago_Cliente formaPagoModificada in formasPagoModificadas) {
                if (!(nuevasFormasDePago.Any(nuevaFormaPago => nuevaFormaPago.nro_tarjeta==formaPagoModificada.nro_tarjeta && nuevaFormaPago.id_forma_pago==formaPagoModificada.id_forma_pago)))
                {
                    formaPagoModificada.id_cliente = clienteModificacion.id_cliente;
                    string resultadoAltaTarjeta = this.altaDeMedioDePago(formaPagoModificada);
                    if (!(resultadoAltaTarjeta.Equals("OK")))
                    {
                        MessageBox.Show(resultadoAltaTarjeta + "\nTarjeta N°: " + formaPagoModificada.nro_tarjeta.ToString());
                    }
                }
            }
            return resultado;
        }

        private string eliminarFormaPagoCliente(Forma_Pago_Cliente formaPagoActual)
        {
            return SQLManager.ejecutarEscalarQuery<string>("LOOPP.SP_EliminarMedioPagoCliente",
                                            SQLArgumentosManager.nuevoParametro("@idFormaPagoCliente", formaPagoActual.id_forma_pago_cliente));

        }
    }
}
