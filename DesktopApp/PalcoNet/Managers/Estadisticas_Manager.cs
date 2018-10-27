using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace PalcoNet.Managers
{
    class Estadisticas_Manager
    {
        public DataTable getTopEmpresasLocalidadesNoVendidas(int anioConsulta, int trimestreConsulta)
        {
            return SQLManager.ejecutarDataTableStoreProcedure("LOOPP.SP_TopEmpresasLocalidadesNoVendidas", 
                                    SQLArgumentosManager.nuevoParametro("@anio", anioConsulta)
                                    .add("@trimestre", trimestreConsulta));
        }

        public DataTable getTopClientesPuntosVencidos(int anioConsulta, int trimestreConsulta)
        {
            return SQLManager.ejecutarDataTableStoreProcedure("LOOPP.SP_TopClientesMasPuntosVencidos",
                                    SQLArgumentosManager.nuevoParametro("@anio", anioConsulta)
                                    .add("@trimestre", trimestreConsulta));
        }

        public DataTable getTopClientesConMasCompras(int anioConsulta, int trimestreConsulta)
        {
            return SQLManager.ejecutarDataTableStoreProcedure("LOOPP.SP_TopClientesMasCompras",
                                    SQLArgumentosManager.nuevoParametro("@anio", anioConsulta)
                                    .add("@trimestre", trimestreConsulta));
        }

        public int getMenorAnioActividad()
        {
            return SQLManager.ejecutarEscalarQuery<int>("LOOPP.SP_GetMenorAnioActividad");
            
        }

        public int getMayorAnioActividad()
        {
            return SQLManager.ejecutarEscalarQuery<int>("LOOPP.SP_GetMayorAnioActividad");
        }
    }
}
