﻿namespace PalcoNet.Login
{
    partial class LoginForm
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
            this.iniciarBtn = new System.Windows.Forms.Button();
            this.salirBtn = new System.Windows.Forms.Button();
            this.label1 = new System.Windows.Forms.Label();
            this.label2 = new System.Windows.Forms.Label();
            this.label3 = new System.Windows.Forms.Label();
            this.userBox = new System.Windows.Forms.TextBox();
            this.passBox = new System.Windows.Forms.TextBox();
            this.iniciosComboBox = new System.Windows.Forms.ComboBox();
            this.SuspendLayout();
            // 
            // iniciarBtn
            // 
            this.iniciarBtn.Location = new System.Drawing.Point(76, 190);
            this.iniciarBtn.Name = "iniciarBtn";
            this.iniciarBtn.Size = new System.Drawing.Size(75, 23);
            this.iniciarBtn.TabIndex = 0;
            this.iniciarBtn.Text = "Iniciar";
            this.iniciarBtn.UseVisualStyleBackColor = true;
            this.iniciarBtn.Click += new System.EventHandler(this.iniciarBtn_Click);
            // 
            // salirBtn
            // 
            this.salirBtn.Location = new System.Drawing.Point(188, 190);
            this.salirBtn.Name = "salirBtn";
            this.salirBtn.Size = new System.Drawing.Size(75, 23);
            this.salirBtn.TabIndex = 1;
            this.salirBtn.Text = "Salir";
            this.salirBtn.UseVisualStyleBackColor = true;
            this.salirBtn.Click += new System.EventHandler(this.salirBtn_Click);
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.Location = new System.Drawing.Point(48, 44);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(67, 13);
            this.label1.TabIndex = 2;
            this.label1.Text = "Iniciar como:";
            // 
            // label2
            // 
            this.label2.AutoSize = true;
            this.label2.Location = new System.Drawing.Point(48, 80);
            this.label2.Name = "label2";
            this.label2.Size = new System.Drawing.Size(43, 13);
            this.label2.TabIndex = 3;
            this.label2.Text = "Usuario";
            // 
            // label3
            // 
            this.label3.AutoSize = true;
            this.label3.Location = new System.Drawing.Point(48, 122);
            this.label3.Name = "label3";
            this.label3.Size = new System.Drawing.Size(61, 13);
            this.label3.TabIndex = 4;
            this.label3.Text = "Contraseña";
            // 
            // userBox
            // 
            this.userBox.Location = new System.Drawing.Point(121, 80);
            this.userBox.Name = "userBox";
            this.userBox.Size = new System.Drawing.Size(176, 20);
            this.userBox.TabIndex = 5;
            // 
            // passBox
            // 
            this.passBox.Location = new System.Drawing.Point(121, 122);
            this.passBox.Name = "passBox";
            this.passBox.Size = new System.Drawing.Size(176, 20);
            this.passBox.TabIndex = 6;
            // 
            // iniciosComboBox
            // 
            this.iniciosComboBox.FormattingEnabled = true;
            this.iniciosComboBox.Location = new System.Drawing.Point(121, 44);
            this.iniciosComboBox.Name = "iniciosComboBox";
            this.iniciosComboBox.Size = new System.Drawing.Size(176, 21);
            this.iniciosComboBox.TabIndex = 7;
            // 
            // LoginForm
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(350, 243);
            this.Controls.Add(this.iniciosComboBox);
            this.Controls.Add(this.passBox);
            this.Controls.Add(this.userBox);
            this.Controls.Add(this.label3);
            this.Controls.Add(this.label2);
            this.Controls.Add(this.label1);
            this.Controls.Add(this.salirBtn);
            this.Controls.Add(this.iniciarBtn);
            this.Name = "LoginForm";
            this.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen;
            this.Text = "Inicio sesion - FRBA Espectaculos";
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.Button iniciarBtn;
        private System.Windows.Forms.Button salirBtn;
        private System.Windows.Forms.Label label1;
        private System.Windows.Forms.Label label2;
        private System.Windows.Forms.Label label3;
        private System.Windows.Forms.TextBox userBox;
        private System.Windows.Forms.TextBox passBox;
        private System.Windows.Forms.ComboBox iniciosComboBox;
    }
}