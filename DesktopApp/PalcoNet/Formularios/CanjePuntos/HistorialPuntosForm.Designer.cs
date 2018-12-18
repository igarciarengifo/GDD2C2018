namespace PalcoNet.Formularios.CanjePuntos
{
    partial class HistorialPuntosForm
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
            this.historialGrid = new System.Windows.Forms.DataGridView();
            this.volverBtn = new System.Windows.Forms.Button();
            ((System.ComponentModel.ISupportInitialize)(this.historialGrid)).BeginInit();
            this.SuspendLayout();
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.Font = new System.Drawing.Font("Microsoft Sans Serif", 10F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label1.Location = new System.Drawing.Point(253, 22);
            this.label1.Name = "label1";
            this.label1.RightToLeft = System.Windows.Forms.RightToLeft.Yes;
            this.label1.Size = new System.Drawing.Size(125, 17);
            this.label1.TabIndex = 0;
            this.label1.Text = "Canjes del usuario";
            // 
            // historialGrid
            // 
            this.historialGrid.AllowUserToAddRows = false;
            this.historialGrid.AllowUserToDeleteRows = false;
            this.historialGrid.AllowUserToOrderColumns = true;
            this.historialGrid.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize;
            this.historialGrid.Location = new System.Drawing.Point(26, 61);
            this.historialGrid.Name = "historialGrid";
            this.historialGrid.ReadOnly = true;
            this.historialGrid.Size = new System.Drawing.Size(572, 150);
            this.historialGrid.TabIndex = 1;
            // 
            // volverBtn
            // 
            this.volverBtn.Location = new System.Drawing.Point(269, 226);
            this.volverBtn.Name = "volverBtn";
            this.volverBtn.Size = new System.Drawing.Size(75, 23);
            this.volverBtn.TabIndex = 2;
            this.volverBtn.Text = "Volver";
            this.volverBtn.UseVisualStyleBackColor = true;
            this.volverBtn.Click += new System.EventHandler(this.volverBtn_Click);
            // 
            // HistorialPuntosForm
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(633, 261);
            this.Controls.Add(this.volverBtn);
            this.Controls.Add(this.historialGrid);
            this.Controls.Add(this.label1);
            this.Name = "HistorialPuntosForm";
            this.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen;
            this.Text = "Historial de puntos - PalcoNet FRBA";
            this.Load += new System.EventHandler(this.HistorialPuntosForm_Load);
            ((System.ComponentModel.ISupportInitialize)(this.historialGrid)).EndInit();
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.Label label1;
        private System.Windows.Forms.DataGridView historialGrid;
        private System.Windows.Forms.Button volverBtn;
    }
}