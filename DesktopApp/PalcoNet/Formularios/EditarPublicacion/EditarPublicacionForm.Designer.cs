namespace PalcoNet.Formularios.EditarPublicacion
{
    partial class EditarPublicacionForm
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
            this.codPublicBox = new System.Windows.Forms.TextBox();
            this.button1 = new System.Windows.Forms.Button();
            this.publicacionGridView = new System.Windows.Forms.DataGridView();
            this.modificarPubli = new System.Windows.Forms.Button();
            this.cancelarBtn = new System.Windows.Forms.Button();
            this.panel1.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.publicacionGridView)).BeginInit();
            this.SuspendLayout();
            // 
            // panel1
            // 
            this.panel1.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D;
            this.panel1.Controls.Add(this.codPublicBox);
            this.panel1.Controls.Add(this.label1);
            this.panel1.Location = new System.Drawing.Point(90, 38);
            this.panel1.Name = "panel1";
            this.panel1.Size = new System.Drawing.Size(371, 66);
            this.panel1.TabIndex = 0;
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.Location = new System.Drawing.Point(18, 22);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(149, 13);
            this.label1.TabIndex = 0;
            this.label1.Text = "Ingrese código de publicación";
            // 
            // codPublicBox
            // 
            this.codPublicBox.Location = new System.Drawing.Point(205, 22);
            this.codPublicBox.Name = "codPublicBox";
            this.codPublicBox.Size = new System.Drawing.Size(114, 20);
            this.codPublicBox.TabIndex = 1;
            // 
            // button1
            // 
            this.button1.Location = new System.Drawing.Point(510, 62);
            this.button1.Name = "button1";
            this.button1.Size = new System.Drawing.Size(163, 23);
            this.button1.TabIndex = 1;
            this.button1.Text = "Buscar";
            this.button1.UseVisualStyleBackColor = true;
            this.button1.Click += new System.EventHandler(this.button1_Click);
            // 
            // publicacionGridView
            // 
            this.publicacionGridView.AllowUserToAddRows = false;
            this.publicacionGridView.AllowUserToDeleteRows = false;
            this.publicacionGridView.AllowUserToOrderColumns = true;
            this.publicacionGridView.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize;
            this.publicacionGridView.Location = new System.Drawing.Point(41, 138);
            this.publicacionGridView.Name = "publicacionGridView";
            this.publicacionGridView.ReadOnly = true;
            this.publicacionGridView.Size = new System.Drawing.Size(700, 150);
            this.publicacionGridView.TabIndex = 2;
            // 
            // modificarPubli
            // 
            this.modificarPubli.Location = new System.Drawing.Point(208, 326);
            this.modificarPubli.Name = "modificarPubli";
            this.modificarPubli.Size = new System.Drawing.Size(150, 23);
            this.modificarPubli.TabIndex = 3;
            this.modificarPubli.Text = "Modificar";
            this.modificarPubli.UseVisualStyleBackColor = true;
            this.modificarPubli.Click += new System.EventHandler(this.modificarPubli_Click);
            // 
            // cancelarBtn
            // 
            this.cancelarBtn.Location = new System.Drawing.Point(426, 326);
            this.cancelarBtn.Name = "cancelarBtn";
            this.cancelarBtn.Size = new System.Drawing.Size(150, 23);
            this.cancelarBtn.TabIndex = 4;
            this.cancelarBtn.Text = "Cancelar";
            this.cancelarBtn.UseVisualStyleBackColor = true;
            this.cancelarBtn.Click += new System.EventHandler(this.cancelarBtn_Click);
            // 
            // EditarPublicacionForm
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(805, 394);
            this.Controls.Add(this.cancelarBtn);
            this.Controls.Add(this.modificarPubli);
            this.Controls.Add(this.publicacionGridView);
            this.Controls.Add(this.button1);
            this.Controls.Add(this.panel1);
            this.Name = "EditarPublicacionForm";
            this.Text = "Seleccione publicacion a editar - PalcoNet";
            this.panel1.ResumeLayout(false);
            this.panel1.PerformLayout();
            ((System.ComponentModel.ISupportInitialize)(this.publicacionGridView)).EndInit();
            this.ResumeLayout(false);

        }

        #endregion

        private System.Windows.Forms.Panel panel1;
        private System.Windows.Forms.Label label1;
        private System.Windows.Forms.TextBox codPublicBox;
        private System.Windows.Forms.Button button1;
        private System.Windows.Forms.DataGridView publicacionGridView;
        private System.Windows.Forms.Button modificarPubli;
        private System.Windows.Forms.Button cancelarBtn;
    }
}