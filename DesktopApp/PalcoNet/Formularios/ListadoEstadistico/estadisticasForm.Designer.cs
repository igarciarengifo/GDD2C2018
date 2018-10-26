namespace PalcoNet.Formularios.ListadoEstadistico
{
    partial class estadisticasForm
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
            this.label1 = new System.Windows.Forms.Label();
            this.label2 = new System.Windows.Forms.Label();
            this.label3 = new System.Windows.Forms.Label();
            this.anioConsultaBox = new System.Windows.Forms.ComboBox();
            this.trimestreBox = new System.Windows.Forms.NumericUpDown();
            this.dataGridEstadisticas = new System.Windows.Forms.DataGridView();
            this.label4 = new System.Windows.Forms.Label();
            this.empresasLinkLabel = new System.Windows.Forms.LinkLabel();
            this.puntosLinkLabel = new System.Windows.Forms.LinkLabel();
            this.comprasLinkLabel = new System.Windows.Forms.LinkLabel();
            this.cancelBtn = new System.Windows.Forms.Button();
            this.panel1.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.trimestreBox)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.dataGridEstadisticas)).BeginInit();
            this.SuspendLayout();
            // 
            // panel1
            // 
            this.panel1.BackColor = System.Drawing.SystemColors.ActiveCaption;
            this.panel1.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D;
            this.panel1.Controls.Add(this.trimestreBox);
            this.panel1.Controls.Add(this.anioConsultaBox);
            this.panel1.Controls.Add(this.label3);
            this.panel1.Controls.Add(this.label2);
            this.panel1.Controls.Add(this.label1);
            this.panel1.Location = new System.Drawing.Point(35, 13);
            this.panel1.Name = "panel1";
            this.panel1.Size = new System.Drawing.Size(317, 115);
            this.panel1.TabIndex = 0;
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.Font = new System.Drawing.Font("Microsoft Sans Serif", 8.25F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label1.Location = new System.Drawing.Point(14, 15);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(196, 13);
            this.label1.TabIndex = 0;
            this.label1.Text = "Ingrese los siguientes parámetros";
            // 
            // label2
            // 
            this.label2.AutoSize = true;
            this.label2.Location = new System.Drawing.Point(17, 50);
            this.label2.Name = "label2";
            this.label2.Size = new System.Drawing.Size(84, 13);
            this.label2.TabIndex = 1;
            this.label2.Text = "Año de consulta";
            // 
            // label3
            // 
            this.label3.AutoSize = true;
            this.label3.Location = new System.Drawing.Point(17, 82);
            this.label3.Name = "label3";
            this.label3.Size = new System.Drawing.Size(108, 13);
            this.label3.TabIndex = 2;
            this.label3.Text = "Trimestre de consulta";
            // 
            // anioConsultaBox
            // 
            this.anioConsultaBox.FormattingEnabled = true;
            this.anioConsultaBox.Location = new System.Drawing.Point(163, 41);
            this.anioConsultaBox.Name = "anioConsultaBox";
            this.anioConsultaBox.Size = new System.Drawing.Size(121, 21);
            this.anioConsultaBox.TabIndex = 3;
            // 
            // trimestreBox
            // 
            this.trimestreBox.Location = new System.Drawing.Point(163, 74);
            this.trimestreBox.Maximum = new decimal(new int[] {
            4,
            0,
            0,
            0});
            this.trimestreBox.Minimum = new decimal(new int[] {
            1,
            0,
            0,
            0});
            this.trimestreBox.Name = "trimestreBox";
            this.trimestreBox.Size = new System.Drawing.Size(120, 20);
            this.trimestreBox.TabIndex = 4;
            this.trimestreBox.Value = new decimal(new int[] {
            1,
            0,
            0,
            0});
            // 
            // dataGridEstadisticas
            // 
            this.dataGridEstadisticas.AllowUserToAddRows = false;
            this.dataGridEstadisticas.AllowUserToDeleteRows = false;
            this.dataGridEstadisticas.AllowUserToOrderColumns = true;
            this.dataGridEstadisticas.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize;
            this.dataGridEstadisticas.Location = new System.Drawing.Point(391, 13);
            this.dataGridEstadisticas.Name = "dataGridEstadisticas";
            this.dataGridEstadisticas.ReadOnly = true;
            this.dataGridEstadisticas.Size = new System.Drawing.Size(389, 443);
            this.dataGridEstadisticas.TabIndex = 1;
            // 
            // label4
            // 
            this.label4.AutoSize = true;
            this.label4.Font = new System.Drawing.Font("Microsoft Sans Serif", 8.25F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label4.Location = new System.Drawing.Point(54, 159);
            this.label4.Name = "label4";
            this.label4.Size = new System.Drawing.Size(187, 13);
            this.label4.TabIndex = 2;
            this.label4.Text = "Click sobre el listado solicitado:";
            // 
            // empresasLinkLabel
            // 
            this.empresasLinkLabel.AutoSize = true;
            this.empresasLinkLabel.Location = new System.Drawing.Point(91, 192);
            this.empresasLinkLabel.Name = "empresasLinkLabel";
            this.empresasLinkLabel.Size = new System.Drawing.Size(281, 13);
            this.empresasLinkLabel.TabIndex = 3;
            this.empresasLinkLabel.TabStop = true;
            this.empresasLinkLabel.Text = "Empresas con mayor cantidad de localidades no vendidas";
            // 
            // puntosLinkLabel
            // 
            this.puntosLinkLabel.AutoSize = true;
            this.puntosLinkLabel.Location = new System.Drawing.Point(91, 227);
            this.puntosLinkLabel.Name = "puntosLinkLabel";
            this.puntosLinkLabel.Size = new System.Drawing.Size(188, 13);
            this.puntosLinkLabel.TabIndex = 4;
            this.puntosLinkLabel.TabStop = true;
            this.puntosLinkLabel.Text = "Clientes con mayores puntos vencidos";
            // 
            // comprasLinkLabel
            // 
            this.comprasLinkLabel.AutoSize = true;
            this.comprasLinkLabel.Location = new System.Drawing.Point(91, 266);
            this.comprasLinkLabel.Name = "comprasLinkLabel";
            this.comprasLinkLabel.Size = new System.Drawing.Size(198, 13);
            this.comprasLinkLabel.TabIndex = 5;
            this.comprasLinkLabel.TabStop = true;
            this.comprasLinkLabel.Text = "Clientes con mayor cantidad de compras";
            // 
            // cancelBtn
            // 
            this.cancelBtn.Location = new System.Drawing.Point(140, 403);
            this.cancelBtn.Name = "cancelBtn";
            this.cancelBtn.Size = new System.Drawing.Size(75, 23);
            this.cancelBtn.TabIndex = 6;
            this.cancelBtn.Text = "Cancelar";
            this.cancelBtn.UseVisualStyleBackColor = true;
            // 
            // estadisticasForm
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(792, 466);
            this.Controls.Add(this.cancelBtn);
            this.Controls.Add(this.comprasLinkLabel);
            this.Controls.Add(this.puntosLinkLabel);
            this.Controls.Add(this.empresasLinkLabel);
            this.Controls.Add(this.label4);
            this.Controls.Add(this.dataGridEstadisticas);
            this.Controls.Add(this.panel1);
            this.Name = "estadisticasForm";
            this.Text = "Estadísticas - PalcoNet";
            this.panel1.ResumeLayout(false);
            this.panel1.PerformLayout();
            ((System.ComponentModel.ISupportInitialize)(this.trimestreBox)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.dataGridEstadisticas)).EndInit();
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.Panel panel1;
        private System.Windows.Forms.NumericUpDown trimestreBox;
        private System.Windows.Forms.ComboBox anioConsultaBox;
        private System.Windows.Forms.Label label3;
        private System.Windows.Forms.Label label2;
        private System.Windows.Forms.Label label1;
        private System.Windows.Forms.DataGridView dataGridEstadisticas;
        private System.Windows.Forms.Label label4;
        private System.Windows.Forms.LinkLabel empresasLinkLabel;
        private System.Windows.Forms.LinkLabel puntosLinkLabel;
        private System.Windows.Forms.LinkLabel comprasLinkLabel;
        private System.Windows.Forms.Button cancelBtn;
    }
}