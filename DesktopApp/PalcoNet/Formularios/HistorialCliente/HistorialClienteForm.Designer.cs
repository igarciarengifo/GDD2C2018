namespace PalcoNet.Formularios.HistorialCliente
{
    partial class HistorialClienteForm
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
            this.label1 = new System.Windows.Forms.Label();
            this.lbl_total_paginas = new System.Windows.Forms.Label();
            this.label2 = new System.Windows.Forms.Label();
            this.lbl_Pagina = new System.Windows.Forms.Label();
            this.btnPrevio = new System.Windows.Forms.Button();
            this.btnSiguiente = new System.Windows.Forms.Button();
            this.dgv_vista = new System.Windows.Forms.DataGridView();
            this.btnPrimera = new System.Windows.Forms.Button();
            this.btnUltima = new System.Windows.Forms.Button();
            this.btnSalir = new System.Windows.Forms.Button();
            ((System.ComponentModel.ISupportInitialize)(this.dgv_vista)).BeginInit();
            this.SuspendLayout();
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.Font = new System.Drawing.Font("Microsoft Sans Serif", 12F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label1.Location = new System.Drawing.Point(262, 38);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(213, 25);
            this.label1.TabIndex = 0;
            this.label1.Text = "Historial de Compras";
            // 
            // lbl_total_paginas
            // 
            this.lbl_total_paginas.Anchor = ((System.Windows.Forms.AnchorStyles)(((System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Left) 
            | System.Windows.Forms.AnchorStyles.Right)));
            this.lbl_total_paginas.AutoSize = true;
            this.lbl_total_paginas.Location = new System.Drawing.Point(438, 412);
            this.lbl_total_paginas.Name = "lbl_total_paginas";
            this.lbl_total_paginas.Size = new System.Drawing.Size(16, 17);
            this.lbl_total_paginas.TabIndex = 11;
            this.lbl_total_paginas.Text = "0";
            // 
            // label2
            // 
            this.label2.Anchor = ((System.Windows.Forms.AnchorStyles)(((System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Left) 
            | System.Windows.Forms.AnchorStyles.Right)));
            this.label2.AutoSize = true;
            this.label2.Location = new System.Drawing.Point(405, 413);
            this.label2.Name = "label2";
            this.label2.Size = new System.Drawing.Size(12, 17);
            this.label2.TabIndex = 10;
            this.label2.Text = "/";
            // 
            // lbl_Pagina
            // 
            this.lbl_Pagina.Anchor = ((System.Windows.Forms.AnchorStyles)(((System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Left) 
            | System.Windows.Forms.AnchorStyles.Right)));
            this.lbl_Pagina.AutoSize = true;
            this.lbl_Pagina.Location = new System.Drawing.Point(363, 412);
            this.lbl_Pagina.Name = "lbl_Pagina";
            this.lbl_Pagina.Size = new System.Drawing.Size(16, 17);
            this.lbl_Pagina.TabIndex = 9;
            this.lbl_Pagina.Text = "0";
            // 
            // btnPrevio
            // 
            this.btnPrevio.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Left)));
            this.btnPrevio.Location = new System.Drawing.Point(50, 406);
            this.btnPrevio.Name = "btnPrevio";
            this.btnPrevio.Size = new System.Drawing.Size(113, 29);
            this.btnPrevio.TabIndex = 8;
            this.btnPrevio.Text = "Anterior";
            this.btnPrevio.UseVisualStyleBackColor = true;
            this.btnPrevio.Click += new System.EventHandler(this.btnPrevio_Click);
            // 
            // btnSiguiente
            // 
            this.btnSiguiente.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Right)));
            this.btnSiguiente.Location = new System.Drawing.Point(660, 406);
            this.btnSiguiente.Name = "btnSiguiente";
            this.btnSiguiente.Size = new System.Drawing.Size(123, 29);
            this.btnSiguiente.TabIndex = 7;
            this.btnSiguiente.Text = "Siguiente";
            this.btnSiguiente.UseVisualStyleBackColor = true;
            this.btnSiguiente.Click += new System.EventHandler(this.btnSiguiente_Click);
            // 
            // dgv_vista
            // 
            this.dgv_vista.AllowUserToAddRows = false;
            this.dgv_vista.AllowUserToDeleteRows = false;
            this.dgv_vista.Anchor = ((System.Windows.Forms.AnchorStyles)(((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Left) 
            | System.Windows.Forms.AnchorStyles.Right)));
            this.dgv_vista.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize;
            this.dgv_vista.Location = new System.Drawing.Point(50, 78);
            this.dgv_vista.Name = "dgv_vista";
            this.dgv_vista.ReadOnly = true;
            this.dgv_vista.RowTemplate.Height = 24;
            this.dgv_vista.Size = new System.Drawing.Size(733, 322);
            this.dgv_vista.TabIndex = 6;
            // 
            // btnPrimera
            // 
            this.btnPrimera.Location = new System.Drawing.Point(169, 406);
            this.btnPrimera.Name = "btnPrimera";
            this.btnPrimera.Size = new System.Drawing.Size(101, 29);
            this.btnPrimera.TabIndex = 12;
            this.btnPrimera.Text = "Primera";
            this.btnPrimera.UseVisualStyleBackColor = true;
            this.btnPrimera.Click += new System.EventHandler(this.btnPrimera_Click);
            // 
            // btnUltima
            // 
            this.btnUltima.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Right)));
            this.btnUltima.Location = new System.Drawing.Point(548, 406);
            this.btnUltima.Name = "btnUltima";
            this.btnUltima.Size = new System.Drawing.Size(106, 29);
            this.btnUltima.TabIndex = 13;
            this.btnUltima.Text = "Ultima";
            this.btnUltima.UseVisualStyleBackColor = true;
            this.btnUltima.Click += new System.EventHandler(this.btnUltima_Click);
            // 
            // btnSalir
            // 
            this.btnSalir.Location = new System.Drawing.Point(663, 457);
            this.btnSalir.Name = "btnSalir";
            this.btnSalir.Size = new System.Drawing.Size(120, 32);
            this.btnSalir.TabIndex = 14;
            this.btnSalir.Text = "Salir";
            this.btnSalir.UseVisualStyleBackColor = true;
            this.btnSalir.Click += new System.EventHandler(this.btnSalir_Click);
            // 
            // HistorialClienteForm
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(8F, 16F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(842, 512);
            this.Controls.Add(this.btnSalir);
            this.Controls.Add(this.btnUltima);
            this.Controls.Add(this.btnPrimera);
            this.Controls.Add(this.lbl_total_paginas);
            this.Controls.Add(this.label2);
            this.Controls.Add(this.lbl_Pagina);
            this.Controls.Add(this.btnPrevio);
            this.Controls.Add(this.btnSiguiente);
            this.Controls.Add(this.dgv_vista);
            this.Controls.Add(this.label1);
            this.Name = "HistorialClienteForm";
            this.Text = "Historial de Cliente";
            ((System.ComponentModel.ISupportInitialize)(this.dgv_vista)).EndInit();
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.Label label1;
        private System.Windows.Forms.Label lbl_total_paginas;
        private System.Windows.Forms.Label label2;
        private System.Windows.Forms.Label lbl_Pagina;
        private System.Windows.Forms.Button btnPrevio;
        private System.Windows.Forms.Button btnSiguiente;
        private System.Windows.Forms.DataGridView dgv_vista;
        private System.Windows.Forms.Button btnPrimera;
        private System.Windows.Forms.Button btnUltima;
        private System.Windows.Forms.Button btnSalir;
    }
}