﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace PalcoNet.Entidades {
    public class Grado {
        public int id_grado { get; set; }
        public string descripcion { get; set; }
        public decimal comision { get; set; }
        public bool estado { get; set; }
    }
}
