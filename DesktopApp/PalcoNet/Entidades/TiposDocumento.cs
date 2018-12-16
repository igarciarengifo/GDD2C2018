using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace PalcoNet.Entidades
{
    public class TiposDocumento
    {
        List<string> listTiposDocumentos = new List<string>();

        public TiposDocumento()
        {
            listTiposDocumentos.Add("DNI");
            listTiposDocumentos.Add("LE");
            listTiposDocumentos.Add("Pasaporte");
            listTiposDocumentos.Add("Otros");
          
        }

        public List<string> getAll(){
            
          return listTiposDocumentos;
        }
    }
}
