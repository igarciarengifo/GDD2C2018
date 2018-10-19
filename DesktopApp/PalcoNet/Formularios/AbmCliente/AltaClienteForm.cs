using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace PalcoNet.Formularios.AbmCliente
{
    public partial class AltaClienteForm : Form
    {
        string user, pass;

        public AltaClienteForm(string username, string passw)
        {
            InitializeComponent();
            user = username;
            pass = passw;
        }

        internal string getResultado()
        {
            throw new NotImplementedException();
        }

        private void label3_Click(object sender, EventArgs e)
        {

        }
    }
}
