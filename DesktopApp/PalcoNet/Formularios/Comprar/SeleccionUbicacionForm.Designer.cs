namespace PalcoNet.Formularios.Comprar
{
    partial class SeleccionUbicacionForm
    {
        /// <summary>
        /// Required designer variable.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary>
        /// Clean up any resources being used.
        /// </summary>
        /// <param name="disposing">true if managed resources should be disposed; otherwise, false.</param>
        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Windows Form Designer generated code

        /// <summary>
        /// Required method for Designer support - do not modify
        /// the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            this.panel1 = new System.Windows.Forms.Panel();
            this.lblDescripcion = new System.Windows.Forms.Label();
            this.cmbUbicacion = new System.Windows.Forms.ComboBox();
            this.label3 = new System.Windows.Forms.Label();
            this.btnAgregar = new System.Windows.Forms.Button();
            this.cmbTipoUbicacion = new System.Windows.Forms.ComboBox();
            this.label2 = new System.Windows.Forms.Label();
            this.label1 = new System.Windows.Forms.Label();
            this.listSeleccionados = new System.Windows.Forms.ListBox();
            this.btnComprar = new System.Windows.Forms.Button();
            this.btnCancelar = new System.Windows.Forms.Button();
            this.panel2 = new System.Windows.Forms.Panel();
            this.label4 = new System.Windows.Forms.Label();
            this.cmbMedioPago = new System.Windows.Forms.ComboBox();
            this.label5 = new System.Windows.Forms.Label();
            this.panelMP = new System.Windows.Forms.Panel();
            this.label19 = new System.Windows.Forms.Label();
            this.nroTarjetaBox = new System.Windows.Forms.TextBox();
            this.btnNuevoMP = new System.Windows.Forms.Button();
            this.label6 = new System.Windows.Forms.Label();
            this.cmbTipoMP = new System.Windows.Forms.ComboBox();
            this.label7 = new System.Windows.Forms.Label();
            this.panel1.SuspendLayout();
            this.panel2.SuspendLayout();
            this.panelMP.SuspendLayout();
            this.SuspendLayout();
            // 
            // panel1
            // 
            this.panel1.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D;
            this.panel1.Controls.Add(this.lblDescripcion);
            this.panel1.Controls.Add(this.cmbUbicacion);
            this.panel1.Controls.Add(this.label3);
            this.panel1.Controls.Add(this.btnAgregar);
            this.panel1.Controls.Add(this.cmbTipoUbicacion);
            this.panel1.Controls.Add(this.label2);
            this.panel1.Controls.Add(this.label1);
            this.panel1.Location = new System.Drawing.Point(25, 25);
            this.panel1.Name = "panel1";
            this.panel1.Size = new System.Drawing.Size(711, 149);
            this.panel1.TabIndex = 0;
            // 
            // lblDescripcion
            // 
            this.lblDescripcion.AutoSize = true;
            this.lblDescripcion.Font = new System.Drawing.Font("Microsoft Sans Serif", 10.2F, ((System.Drawing.FontStyle)((System.Drawing.FontStyle.Bold | System.Drawing.FontStyle.Italic))), System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.lblDescripcion.Location = new System.Drawing.Point(166, 17);
            this.lblDescripcion.Name = "lblDescripcion";
            this.lblDescripcion.Size = new System.Drawing.Size(59, 20);
            this.lblDescripcion.TabIndex = 7;
            this.lblDescripcion.Text = "label8";
            // 
            // cmbUbicacion
            // 
            this.cmbUbicacion.FormattingEnabled = true;
            this.cmbUbicacion.Location = new System.Drawing.Point(170, 101);
            this.cmbUbicacion.Name = "cmbUbicacion";
            this.cmbUbicacion.Size = new System.Drawing.Size(348, 24);
            this.cmbUbicacion.TabIndex = 6;
            // 
            // label3
            // 
            this.label3.AutoSize = true;
            this.label3.Font = new System.Drawing.Font("Microsoft Sans Serif", 10.2F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label3.Location = new System.Drawing.Point(15, 101);
            this.label3.Name = "label3";
            this.label3.Size = new System.Drawing.Size(94, 20);
            this.label3.TabIndex = 5;
            this.label3.Text = "Ubicación*:";
            // 
            // btnAgregar
            // 
            this.btnAgregar.Location = new System.Drawing.Point(545, 92);
            this.btnAgregar.Name = "btnAgregar";
            this.btnAgregar.Size = new System.Drawing.Size(157, 40);
            this.btnAgregar.TabIndex = 4;
            this.btnAgregar.Text = "Agregar";
            this.btnAgregar.UseVisualStyleBackColor = true;
            this.btnAgregar.Click += new System.EventHandler(this.btnAgregar_Click);
            // 
            // cmbTipoUbicacion
            // 
            this.cmbTipoUbicacion.FormattingEnabled = true;
            this.cmbTipoUbicacion.Location = new System.Drawing.Point(170, 60);
            this.cmbTipoUbicacion.Name = "cmbTipoUbicacion";
            this.cmbTipoUbicacion.Size = new System.Drawing.Size(348, 24);
            this.cmbTipoUbicacion.TabIndex = 4;
            this.cmbTipoUbicacion.SelectedIndexChanged += new System.EventHandler(this.cmbTipoUbicacion_SelectedIndexChanged);
            // 
            // label2
            // 
            this.label2.AutoSize = true;
            this.label2.Font = new System.Drawing.Font("Microsoft Sans Serif", 10.2F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label2.Location = new System.Drawing.Point(15, 60);
            this.label2.Name = "label2";
            this.label2.Size = new System.Drawing.Size(131, 20);
            this.label2.TabIndex = 2;
            this.label2.Text = "Tipo Ubicación*:";
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.Font = new System.Drawing.Font("Microsoft Sans Serif", 10.2F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label1.Location = new System.Drawing.Point(15, 17);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(106, 20);
            this.label1.TabIndex = 0;
            this.label1.Text = "Espectáculo:";
            // 
            // listSeleccionados
            // 
            this.listSeleccionados.FormattingEnabled = true;
            this.listSeleccionados.ItemHeight = 16;
            this.listSeleccionados.Location = new System.Drawing.Point(25, 180);
            this.listSeleccionados.Name = "listSeleccionados";
            this.listSeleccionados.Size = new System.Drawing.Size(711, 132);
            this.listSeleccionados.TabIndex = 1;
            // 
            // btnComprar
            // 
            this.btnComprar.Font = new System.Drawing.Font("Microsoft Sans Serif", 7.8F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.btnComprar.Location = new System.Drawing.Point(579, 591);
            this.btnComprar.Name = "btnComprar";
            this.btnComprar.Size = new System.Drawing.Size(157, 40);
            this.btnComprar.TabIndex = 2;
            this.btnComprar.Text = "Comprar";
            this.btnComprar.UseVisualStyleBackColor = true;
            this.btnComprar.Click += new System.EventHandler(this.btnComprar_Click);
            // 
            // btnCancelar
            // 
            this.btnCancelar.Font = new System.Drawing.Font("Microsoft Sans Serif", 7.8F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.btnCancelar.Location = new System.Drawing.Point(416, 591);
            this.btnCancelar.Name = "btnCancelar";
            this.btnCancelar.Size = new System.Drawing.Size(157, 40);
            this.btnCancelar.TabIndex = 3;
            this.btnCancelar.Text = "Cancelar";
            this.btnCancelar.UseVisualStyleBackColor = true;
            this.btnCancelar.Click += new System.EventHandler(this.btnCancelar_Click);
            // 
            // panel2
            // 
            this.panel2.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D;
            this.panel2.Controls.Add(this.label4);
            this.panel2.Controls.Add(this.cmbMedioPago);
            this.panel2.Controls.Add(this.label5);
            this.panel2.Location = new System.Drawing.Point(25, 318);
            this.panel2.Name = "panel2";
            this.panel2.Size = new System.Drawing.Size(711, 104);
            this.panel2.TabIndex = 4;
            // 
            // label4
            // 
            this.label4.AutoSize = true;
            this.label4.Font = new System.Drawing.Font("Microsoft Sans Serif", 9F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label4.Location = new System.Drawing.Point(7, 12);
            this.label4.Name = "label4";
            this.label4.Size = new System.Drawing.Size(204, 18);
            this.label4.TabIndex = 5;
            this.label4.Text = "Datos de Pago del Cliente";
            // 
            // cmbMedioPago
            // 
            this.cmbMedioPago.FormattingEnabled = true;
            this.cmbMedioPago.Location = new System.Drawing.Point(151, 51);
            this.cmbMedioPago.Name = "cmbMedioPago";
            this.cmbMedioPago.Size = new System.Drawing.Size(348, 24);
            this.cmbMedioPago.TabIndex = 4;
            // 
            // label5
            // 
            this.label5.AutoSize = true;
            this.label5.Font = new System.Drawing.Font("Microsoft Sans Serif", 10.2F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label5.Location = new System.Drawing.Point(6, 51);
            this.label5.Name = "label5";
            this.label5.Size = new System.Drawing.Size(131, 20);
            this.label5.TabIndex = 2;
            this.label5.Text = "Medio de Pago*:";
            // 
            // panelMP
            // 
            this.panelMP.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D;
            this.panelMP.Controls.Add(this.label19);
            this.panelMP.Controls.Add(this.nroTarjetaBox);
            this.panelMP.Controls.Add(this.btnNuevoMP);
            this.panelMP.Controls.Add(this.label6);
            this.panelMP.Controls.Add(this.cmbTipoMP);
            this.panelMP.Controls.Add(this.label7);
            this.panelMP.Location = new System.Drawing.Point(25, 428);
            this.panelMP.Name = "panelMP";
            this.panelMP.Size = new System.Drawing.Size(711, 157);
            this.panelMP.TabIndex = 5;
            // 
            // label19
            // 
            this.label19.AutoSize = true;
            this.label19.Font = new System.Drawing.Font("Microsoft Sans Serif", 10.2F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label19.Location = new System.Drawing.Point(8, 96);
            this.label19.Margin = new System.Windows.Forms.Padding(4, 0, 4, 0);
            this.label19.Name = "label19";
            this.label19.Size = new System.Drawing.Size(102, 20);
            this.label19.TabIndex = 8;
            this.label19.Text = "Nro. Tarjeta:";
            // 
            // nroTarjetaBox
            // 
            this.nroTarjetaBox.Location = new System.Drawing.Point(151, 96);
            this.nroTarjetaBox.Margin = new System.Windows.Forms.Padding(4);
            this.nroTarjetaBox.Name = "nroTarjetaBox";
            this.nroTarjetaBox.Size = new System.Drawing.Size(249, 22);
            this.nroTarjetaBox.TabIndex = 7;
            // 
            // btnNuevoMP
            // 
            this.btnNuevoMP.Location = new System.Drawing.Point(477, 76);
            this.btnNuevoMP.Name = "btnNuevoMP";
            this.btnNuevoMP.Size = new System.Drawing.Size(198, 40);
            this.btnNuevoMP.TabIndex = 6;
            this.btnNuevoMP.Text = "Nuevo Medio de Pago";
            this.btnNuevoMP.UseVisualStyleBackColor = true;
            this.btnNuevoMP.Click += new System.EventHandler(this.btnNuevoMP_Click);
            // 
            // label6
            // 
            this.label6.AutoSize = true;
            this.label6.Font = new System.Drawing.Font("Microsoft Sans Serif", 9F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label6.Location = new System.Drawing.Point(7, 12);
            this.label6.Name = "label6";
            this.label6.Size = new System.Drawing.Size(174, 18);
            this.label6.TabIndex = 5;
            this.label6.Text = "Nuevo Medio de Pago";
            // 
            // cmbTipoMP
            // 
            this.cmbTipoMP.FormattingEnabled = true;
            this.cmbTipoMP.Location = new System.Drawing.Point(151, 51);
            this.cmbTipoMP.Name = "cmbTipoMP";
            this.cmbTipoMP.Size = new System.Drawing.Size(249, 24);
            this.cmbTipoMP.TabIndex = 4;
            // 
            // label7
            // 
            this.label7.AutoSize = true;
            this.label7.Font = new System.Drawing.Font("Microsoft Sans Serif", 10.2F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label7.Location = new System.Drawing.Point(6, 51);
            this.label7.Name = "label7";
            this.label7.Size = new System.Drawing.Size(125, 20);
            this.label7.TabIndex = 2;
            this.label7.Text = "Medio de Pago:";
            // 
            // SeleccionUbicacionForm
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(8F, 16F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(774, 643);
            this.Controls.Add(this.panelMP);
            this.Controls.Add(this.panel2);
            this.Controls.Add(this.btnCancelar);
            this.Controls.Add(this.btnComprar);
            this.Controls.Add(this.listSeleccionados);
            this.Controls.Add(this.panel1);
            this.Name = "SeleccionUbicacionForm";
            this.Text = "Seleccion de Ubicaciones";
            this.panel1.ResumeLayout(false);
            this.panel1.PerformLayout();
            this.panel2.ResumeLayout(false);
            this.panel2.PerformLayout();
            this.panelMP.ResumeLayout(false);
            this.panelMP.PerformLayout();
            this.ResumeLayout(false);

        }

        #endregion

        private System.Windows.Forms.Panel panel1;
        private System.Windows.Forms.Label label1;
        private System.Windows.Forms.Label label2;
        private System.Windows.Forms.ComboBox cmbTipoUbicacion;
        private System.Windows.Forms.ListBox listSeleccionados;
        private System.Windows.Forms.Button btnComprar;
        private System.Windows.Forms.Button btnCancelar;
        private System.Windows.Forms.Button btnAgregar;
        private System.Windows.Forms.Panel panel2;
        private System.Windows.Forms.ComboBox cmbMedioPago;
        private System.Windows.Forms.Label label5;
        private System.Windows.Forms.Label label4;
        private System.Windows.Forms.Panel panelMP;
        private System.Windows.Forms.Button btnNuevoMP;
        private System.Windows.Forms.Label label6;
        private System.Windows.Forms.ComboBox cmbTipoMP;
        private System.Windows.Forms.Label label7;
        private System.Windows.Forms.ComboBox cmbUbicacion;
        private System.Windows.Forms.Label label3;
        private System.Windows.Forms.Label lblDescripcion;
        private System.Windows.Forms.Label label19;
        private System.Windows.Forms.TextBox nroTarjetaBox;
    }
}