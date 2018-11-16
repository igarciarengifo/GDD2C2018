namespace PalcoNet.Formularios.AbmEmpresaEspectaculo
{
    partial class ConsultaEmpresasForm
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
            this.razonBox = new System.Windows.Forms.TextBox();
            this.emailBox = new System.Windows.Forms.TextBox();
            this.cuitBox = new System.Windows.Forms.TextBox();
            this.label4 = new System.Windows.Forms.Label();
            this.label3 = new System.Windows.Forms.Label();
            this.label2 = new System.Windows.Forms.Label();
            this.label1 = new System.Windows.Forms.Label();
            this.filtrarBtn = new System.Windows.Forms.Button();
            this.dataEmpresas = new System.Windows.Forms.DataGridView();
            this.button5 = new System.Windows.Forms.Button();
            this.updateBox = new System.Windows.Forms.Button();
            this.newEmpresaBtn = new System.Windows.Forms.Button();
            this.panel1.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.dataEmpresas)).BeginInit();
            this.SuspendLayout();
            // 
            // panel1
            // 
            this.panel1.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D;
            this.panel1.Controls.Add(this.razonBox);
            this.panel1.Controls.Add(this.emailBox);
            this.panel1.Controls.Add(this.cuitBox);
            this.panel1.Controls.Add(this.label4);
            this.panel1.Controls.Add(this.label3);
            this.panel1.Controls.Add(this.label2);
            this.panel1.Controls.Add(this.label1);
            this.panel1.Location = new System.Drawing.Point(62, 45);
            this.panel1.Name = "panel1";
            this.panel1.Size = new System.Drawing.Size(711, 128);
            this.panel1.TabIndex = 0;
            // 
            // razonBox
            // 
            this.razonBox.Location = new System.Drawing.Point(454, 40);
            this.razonBox.Name = "razonBox";
            this.razonBox.Size = new System.Drawing.Size(237, 20);
            this.razonBox.TabIndex = 6;
            // 
            // emailBox
            // 
            this.emailBox.Location = new System.Drawing.Point(112, 76);
            this.emailBox.Name = "emailBox";
            this.emailBox.Size = new System.Drawing.Size(226, 20);
            this.emailBox.TabIndex = 5;
            // 
            // cuitBox
            // 
            this.cuitBox.Location = new System.Drawing.Point(112, 43);
            this.cuitBox.Name = "cuitBox";
            this.cuitBox.Size = new System.Drawing.Size(226, 20);
            this.cuitBox.TabIndex = 4;
            // 
            // label4
            // 
            this.label4.AutoSize = true;
            this.label4.Location = new System.Drawing.Point(53, 76);
            this.label4.Name = "label4";
            this.label4.Size = new System.Drawing.Size(35, 13);
            this.label4.TabIndex = 3;
            this.label4.Text = "E-mail";
            // 
            // label3
            // 
            this.label3.AutoSize = true;
            this.label3.Location = new System.Drawing.Point(380, 43);
            this.label3.Name = "label3";
            this.label3.Size = new System.Drawing.Size(68, 13);
            this.label3.TabIndex = 2;
            this.label3.Text = "Razón social";
            // 
            // label2
            // 
            this.label2.AutoSize = true;
            this.label2.Location = new System.Drawing.Point(50, 43);
            this.label2.Name = "label2";
            this.label2.Size = new System.Drawing.Size(32, 13);
            this.label2.TabIndex = 1;
            this.label2.Text = "CUIT";
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.Font = new System.Drawing.Font("Calibri", 10F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label1.Location = new System.Drawing.Point(3, 0);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(105, 17);
            this.label1.TabIndex = 0;
            this.label1.Text = "Filtrar búsqueda";
            // 
            // filtrarBtn
            // 
            this.filtrarBtn.Location = new System.Drawing.Point(680, 179);
            this.filtrarBtn.Name = "filtrarBtn";
            this.filtrarBtn.Size = new System.Drawing.Size(93, 28);
            this.filtrarBtn.TabIndex = 7;
            this.filtrarBtn.Text = "Filtrar";
            this.filtrarBtn.UseVisualStyleBackColor = true;
            this.filtrarBtn.Click += new System.EventHandler(this.filtrarBtn_Click);
            // 
            // dataEmpresas
            // 
            this.dataEmpresas.AllowUserToAddRows = false;
            this.dataEmpresas.AllowUserToDeleteRows = false;
            this.dataEmpresas.AllowUserToOrderColumns = true;
            this.dataEmpresas.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize;
            this.dataEmpresas.Location = new System.Drawing.Point(68, 231);
            this.dataEmpresas.Name = "dataEmpresas";
            this.dataEmpresas.ReadOnly = true;
            this.dataEmpresas.Size = new System.Drawing.Size(705, 150);
            this.dataEmpresas.TabIndex = 8;
            // 
            // button5
            // 
            this.button5.Location = new System.Drawing.Point(680, 428);
            this.button5.Name = "button5";
            this.button5.Size = new System.Drawing.Size(93, 28);
            this.button5.TabIndex = 12;
            this.button5.Text = "Salir";
            this.button5.UseVisualStyleBackColor = true;
            this.button5.Click += new System.EventHandler(this.button5_Click);
            // 
            // updateBox
            // 
            this.updateBox.Location = new System.Drawing.Point(360, 428);
            this.updateBox.Name = "updateBox";
            this.updateBox.Size = new System.Drawing.Size(93, 28);
            this.updateBox.TabIndex = 13;
            this.updateBox.Text = "Modificar";
            this.updateBox.UseVisualStyleBackColor = true;
            this.updateBox.Click += new System.EventHandler(this.updateBox_Click);
            // 
            // newEmpresaBtn
            // 
            this.newEmpresaBtn.Location = new System.Drawing.Point(68, 428);
            this.newEmpresaBtn.Name = "newEmpresaBtn";
            this.newEmpresaBtn.Size = new System.Drawing.Size(93, 28);
            this.newEmpresaBtn.TabIndex = 14;
            this.newEmpresaBtn.Text = "Nuevo Empresa";
            this.newEmpresaBtn.UseVisualStyleBackColor = true;
            this.newEmpresaBtn.Click += new System.EventHandler(this.newEmpresaBtn_Click);
            // 
            // ConsultaEmpresasForm
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(813, 538);
            this.Controls.Add(this.newEmpresaBtn);
            this.Controls.Add(this.updateBox);
            this.Controls.Add(this.button5);
            this.Controls.Add(this.dataEmpresas);
            this.Controls.Add(this.filtrarBtn);
            this.Controls.Add(this.panel1);
            this.Name = "ConsultaEmpresasForm";
            this.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen;
            this.Text = "Consultar por empresa";
            this.panel1.ResumeLayout(false);
            this.panel1.PerformLayout();
            ((System.ComponentModel.ISupportInitialize)(this.dataEmpresas)).EndInit();
            this.ResumeLayout(false);

        }

        #endregion

        private System.Windows.Forms.Panel panel1;
        private System.Windows.Forms.TextBox razonBox;
        private System.Windows.Forms.TextBox emailBox;
        private System.Windows.Forms.TextBox cuitBox;
        private System.Windows.Forms.Label label4;
        private System.Windows.Forms.Label label3;
        private System.Windows.Forms.Label label2;
        private System.Windows.Forms.Label label1;
        private System.Windows.Forms.Button filtrarBtn;
        private System.Windows.Forms.DataGridView dataEmpresas;
        private System.Windows.Forms.Button button5;
        private System.Windows.Forms.Button updateBox;
        private System.Windows.Forms.Button newEmpresaBtn;
    }
}