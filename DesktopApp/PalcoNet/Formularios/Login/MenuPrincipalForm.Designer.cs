﻿namespace PalcoNet.Formularios
{
    partial class MenuPrincipalForm
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
            this.components = new System.ComponentModel.Container();
            this.contextMenuStrip1 = new System.Windows.Forms.ContextMenuStrip(this.components);
            this.historialPuntosToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.canjeDePuntosToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.menuStrip1 = new System.Windows.Forms.MenuStrip();
            this.misDatosToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.modificarUsuarioToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.cerrarSesionToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.empresasToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.nuevaEmpresaToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.consultarEmpresasToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.clientesToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.nuevoClienteToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.consultarClientesToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.gradosDePublicaciónToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.nuevoToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.consultarGradosToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.rolesToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.nuevoRolToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.consultarRolesToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.panelEmpresas = new System.Windows.Forms.Panel();
            this.factComBtn = new System.Windows.Forms.Button();
            this.rendConsBtn = new System.Windows.Forms.Button();
            this.newPubBtn = new System.Windows.Forms.Button();
            this.puntosBtn = new System.Windows.Forms.Button();
            this.editPubBtn = new System.Windows.Forms.Button();
            this.editCompBtn = new System.Windows.Forms.Button();
            this.comprarBtn = new System.Windows.Forms.Button();
            this.flpCentral = new System.Windows.Forms.FlowLayoutPanel();
            this.statusStrip1 = new System.Windows.Forms.StatusStrip();
            this.toolStripStatusLabel1 = new System.Windows.Forms.ToolStripStatusLabel();
            this.toolTip1 = new System.Windows.Forms.ToolTip(this.components);
            this.flowLayoutPanel1 = new System.Windows.Forms.FlowLayoutPanel();
            this.label1 = new System.Windows.Forms.Label();
            this.contextMenuStrip1.SuspendLayout();
            this.menuStrip1.SuspendLayout();
            this.panelEmpresas.SuspendLayout();
            this.statusStrip1.SuspendLayout();
            this.flowLayoutPanel1.SuspendLayout();
            this.SuspendLayout();
            // 
            // contextMenuStrip1
            // 
            this.contextMenuStrip1.Items.AddRange(new System.Windows.Forms.ToolStripItem[] {
            this.historialPuntosToolStripMenuItem,
            this.canjeDePuntosToolStripMenuItem});
            this.contextMenuStrip1.Name = "contextMenuStrip1";
            this.contextMenuStrip1.Size = new System.Drawing.Size(161, 48);
            // 
            // historialPuntosToolStripMenuItem
            // 
            this.historialPuntosToolStripMenuItem.Name = "historialPuntosToolStripMenuItem";
            this.historialPuntosToolStripMenuItem.Size = new System.Drawing.Size(160, 22);
            this.historialPuntosToolStripMenuItem.Text = "Historial Puntos";
            this.historialPuntosToolStripMenuItem.Click += new System.EventHandler(this.historialPuntosToolStripMenuItem_Click);
            // 
            // canjeDePuntosToolStripMenuItem
            // 
            this.canjeDePuntosToolStripMenuItem.Name = "canjeDePuntosToolStripMenuItem";
            this.canjeDePuntosToolStripMenuItem.Size = new System.Drawing.Size(160, 22);
            this.canjeDePuntosToolStripMenuItem.Text = "Canje de Puntos";
            this.canjeDePuntosToolStripMenuItem.Click += new System.EventHandler(this.canjeDePuntosToolStripMenuItem_Click);
            // 
            // menuStrip1
            // 
            this.menuStrip1.BackColor = System.Drawing.SystemColors.ActiveCaption;
            this.menuStrip1.Items.AddRange(new System.Windows.Forms.ToolStripItem[] {
            this.misDatosToolStripMenuItem,
            this.empresasToolStripMenuItem,
            this.clientesToolStripMenuItem,
            this.gradosDePublicaciónToolStripMenuItem,
            this.rolesToolStripMenuItem});
            this.menuStrip1.Location = new System.Drawing.Point(0, 0);
            this.menuStrip1.Name = "menuStrip1";
            this.menuStrip1.Size = new System.Drawing.Size(1027, 24);
            this.menuStrip1.TabIndex = 2;
            this.menuStrip1.Text = "menuStrip1";
            // 
            // misDatosToolStripMenuItem
            // 
            this.misDatosToolStripMenuItem.DropDownItems.AddRange(new System.Windows.Forms.ToolStripItem[] {
            this.modificarUsuarioToolStripMenuItem,
            this.cerrarSesionToolStripMenuItem});
            this.misDatosToolStripMenuItem.Font = new System.Drawing.Font("Segoe UI", 9F, System.Drawing.FontStyle.Bold);
            this.misDatosToolStripMenuItem.Name = "misDatosToolStripMenuItem";
            this.misDatosToolStripMenuItem.Size = new System.Drawing.Size(71, 20);
            this.misDatosToolStripMenuItem.Text = "Mis datos";
            // 
            // modificarUsuarioToolStripMenuItem
            // 
            this.modificarUsuarioToolStripMenuItem.Font = new System.Drawing.Font("Segoe UI", 9F);
            this.modificarUsuarioToolStripMenuItem.Name = "modificarUsuarioToolStripMenuItem";
            this.modificarUsuarioToolStripMenuItem.Size = new System.Drawing.Size(186, 22);
            this.modificarUsuarioToolStripMenuItem.Text = "Modificar contraseña";
            this.modificarUsuarioToolStripMenuItem.Click += new System.EventHandler(this.modificarUsuarioToolStripMenuItem_Click);
            // 
            // cerrarSesionToolStripMenuItem
            // 
            this.cerrarSesionToolStripMenuItem.Font = new System.Drawing.Font("Segoe UI", 9F);
            this.cerrarSesionToolStripMenuItem.Name = "cerrarSesionToolStripMenuItem";
            this.cerrarSesionToolStripMenuItem.Size = new System.Drawing.Size(186, 22);
            this.cerrarSesionToolStripMenuItem.Text = "Cerrar sesión";
            this.cerrarSesionToolStripMenuItem.Click += new System.EventHandler(this.cerrarSesionToolStripMenuItem_Click);
            // 
            // empresasToolStripMenuItem
            // 
            this.empresasToolStripMenuItem.DropDownItems.AddRange(new System.Windows.Forms.ToolStripItem[] {
            this.nuevaEmpresaToolStripMenuItem,
            this.consultarEmpresasToolStripMenuItem});
            this.empresasToolStripMenuItem.Name = "empresasToolStripMenuItem";
            this.empresasToolStripMenuItem.Size = new System.Drawing.Size(69, 20);
            this.empresasToolStripMenuItem.Text = "Empresas";
            // 
            // nuevaEmpresaToolStripMenuItem
            // 
            this.nuevaEmpresaToolStripMenuItem.Name = "nuevaEmpresaToolStripMenuItem";
            this.nuevaEmpresaToolStripMenuItem.Size = new System.Drawing.Size(178, 22);
            this.nuevaEmpresaToolStripMenuItem.Text = "Nueva empresa";
            this.nuevaEmpresaToolStripMenuItem.Click += new System.EventHandler(this.nuevaEmpresaToolStripMenuItem_Click);
            // 
            // consultarEmpresasToolStripMenuItem
            // 
            this.consultarEmpresasToolStripMenuItem.Name = "consultarEmpresasToolStripMenuItem";
            this.consultarEmpresasToolStripMenuItem.Size = new System.Drawing.Size(178, 22);
            this.consultarEmpresasToolStripMenuItem.Text = "Consultar empresas";
            this.consultarEmpresasToolStripMenuItem.Click += new System.EventHandler(this.consultarEmpresasToolStripMenuItem_Click);
            // 
            // clientesToolStripMenuItem
            // 
            this.clientesToolStripMenuItem.DropDownItems.AddRange(new System.Windows.Forms.ToolStripItem[] {
            this.nuevoClienteToolStripMenuItem,
            this.consultarClientesToolStripMenuItem});
            this.clientesToolStripMenuItem.Name = "clientesToolStripMenuItem";
            this.clientesToolStripMenuItem.Size = new System.Drawing.Size(61, 20);
            this.clientesToolStripMenuItem.Text = "Clientes";
            // 
            // nuevoClienteToolStripMenuItem
            // 
            this.nuevoClienteToolStripMenuItem.Name = "nuevoClienteToolStripMenuItem";
            this.nuevoClienteToolStripMenuItem.Size = new System.Drawing.Size(168, 22);
            this.nuevoClienteToolStripMenuItem.Text = "Nuevo cliente";
            this.nuevoClienteToolStripMenuItem.Click += new System.EventHandler(this.nuevoClienteToolStripMenuItem_Click);
            // 
            // consultarClientesToolStripMenuItem
            // 
            this.consultarClientesToolStripMenuItem.Name = "consultarClientesToolStripMenuItem";
            this.consultarClientesToolStripMenuItem.Size = new System.Drawing.Size(168, 22);
            this.consultarClientesToolStripMenuItem.Text = "Consultar clientes";
            this.consultarClientesToolStripMenuItem.Click += new System.EventHandler(this.consultarClientesToolStripMenuItem_Click);
            // 
            // gradosDePublicaciónToolStripMenuItem
            // 
            this.gradosDePublicaciónToolStripMenuItem.DropDownItems.AddRange(new System.Windows.Forms.ToolStripItem[] {
            this.nuevoToolStripMenuItem,
            this.consultarGradosToolStripMenuItem});
            this.gradosDePublicaciónToolStripMenuItem.Name = "gradosDePublicaciónToolStripMenuItem";
            this.gradosDePublicaciónToolStripMenuItem.Size = new System.Drawing.Size(137, 20);
            this.gradosDePublicaciónToolStripMenuItem.Text = "Grados de publicación";
            // 
            // nuevoToolStripMenuItem
            // 
            this.nuevoToolStripMenuItem.Name = "nuevoToolStripMenuItem";
            this.nuevoToolStripMenuItem.Size = new System.Drawing.Size(164, 22);
            this.nuevoToolStripMenuItem.Text = "Nuevo";
            // 
            // consultarGradosToolStripMenuItem
            // 
            this.consultarGradosToolStripMenuItem.Name = "consultarGradosToolStripMenuItem";
            this.consultarGradosToolStripMenuItem.Size = new System.Drawing.Size(164, 22);
            this.consultarGradosToolStripMenuItem.Text = "Consultar grados";
            // 
            // rolesToolStripMenuItem
            // 
            this.rolesToolStripMenuItem.DropDownItems.AddRange(new System.Windows.Forms.ToolStripItem[] {
            this.nuevoRolToolStripMenuItem,
            this.consultarRolesToolStripMenuItem});
            this.rolesToolStripMenuItem.Name = "rolesToolStripMenuItem";
            this.rolesToolStripMenuItem.Size = new System.Drawing.Size(47, 20);
            this.rolesToolStripMenuItem.Text = "Roles";
            // 
            // nuevoRolToolStripMenuItem
            // 
            this.nuevoRolToolStripMenuItem.Name = "nuevoRolToolStripMenuItem";
            this.nuevoRolToolStripMenuItem.Size = new System.Drawing.Size(153, 22);
            this.nuevoRolToolStripMenuItem.Text = "Nuevo rol";
            // 
            // consultarRolesToolStripMenuItem
            // 
            this.consultarRolesToolStripMenuItem.Name = "consultarRolesToolStripMenuItem";
            this.consultarRolesToolStripMenuItem.Size = new System.Drawing.Size(153, 22);
            this.consultarRolesToolStripMenuItem.Text = "Consultar roles";
            // 
            // panelEmpresas
            // 
            this.panelEmpresas.Controls.Add(this.factComBtn);
            this.panelEmpresas.Controls.Add(this.rendConsBtn);
            this.panelEmpresas.Controls.Add(this.newPubBtn);
            this.panelEmpresas.Controls.Add(this.puntosBtn);
            this.panelEmpresas.Controls.Add(this.editPubBtn);
            this.panelEmpresas.Controls.Add(this.editCompBtn);
            this.panelEmpresas.Controls.Add(this.comprarBtn);
            this.panelEmpresas.Location = new System.Drawing.Point(201, 461);
            this.panelEmpresas.Name = "panelEmpresas";
            this.panelEmpresas.Size = new System.Drawing.Size(662, 113);
            this.panelEmpresas.TabIndex = 0;
            // 
            // factComBtn
            // 
            this.factComBtn.Location = new System.Drawing.Point(491, 0);
            this.factComBtn.Margin = new System.Windows.Forms.Padding(3, 3, 50, 3);
            this.factComBtn.Name = "factComBtn";
            this.factComBtn.Size = new System.Drawing.Size(121, 51);
            this.factComBtn.TabIndex = 3;
            this.factComBtn.Text = "Facturar comisión";
            this.factComBtn.UseVisualStyleBackColor = true;
            // 
            // rendConsBtn
            // 
            this.rendConsBtn.Location = new System.Drawing.Point(356, -3);
            this.rendConsBtn.Margin = new System.Windows.Forms.Padding(3, 3, 50, 3);
            this.rendConsBtn.Name = "rendConsBtn";
            this.rendConsBtn.Size = new System.Drawing.Size(121, 51);
            this.rendConsBtn.TabIndex = 2;
            this.rendConsBtn.Text = "Consultar Rendicion";
            this.rendConsBtn.UseVisualStyleBackColor = true;
            // 
            // newPubBtn
            // 
            this.newPubBtn.Location = new System.Drawing.Point(68, -3);
            this.newPubBtn.Margin = new System.Windows.Forms.Padding(3, 3, 50, 3);
            this.newPubBtn.Name = "newPubBtn";
            this.newPubBtn.Size = new System.Drawing.Size(115, 51);
            this.newPubBtn.TabIndex = 0;
            this.newPubBtn.Text = "Nueva Publicacion";
            this.newPubBtn.UseVisualStyleBackColor = true;
            // 
            // puntosBtn
            // 
            this.puntosBtn.ContextMenuStrip = this.contextMenuStrip1;
            this.puntosBtn.Location = new System.Drawing.Point(356, 54);
            this.puntosBtn.Margin = new System.Windows.Forms.Padding(3, 3, 50, 3);
            this.puntosBtn.Name = "puntosBtn";
            this.puntosBtn.Size = new System.Drawing.Size(121, 51);
            this.puntosBtn.TabIndex = 2;
            this.puntosBtn.Text = "Puntos";
            this.puntosBtn.UseVisualStyleBackColor = true;
            // 
            // editPubBtn
            // 
            this.editPubBtn.Location = new System.Drawing.Point(209, -3);
            this.editPubBtn.Margin = new System.Windows.Forms.Padding(3, 3, 50, 3);
            this.editPubBtn.Name = "editPubBtn";
            this.editPubBtn.Size = new System.Drawing.Size(116, 51);
            this.editPubBtn.TabIndex = 1;
            this.editPubBtn.Text = "Editar Publicacion";
            this.editPubBtn.UseVisualStyleBackColor = true;
            // 
            // editCompBtn
            // 
            this.editCompBtn.Location = new System.Drawing.Point(209, 54);
            this.editCompBtn.Margin = new System.Windows.Forms.Padding(3, 3, 50, 3);
            this.editCompBtn.Name = "editCompBtn";
            this.editCompBtn.Size = new System.Drawing.Size(116, 51);
            this.editCompBtn.TabIndex = 1;
            this.editCompBtn.Text = "Editar Compra";
            this.editCompBtn.UseVisualStyleBackColor = true;
            // 
            // comprarBtn
            // 
            this.comprarBtn.Location = new System.Drawing.Point(68, 54);
            this.comprarBtn.Margin = new System.Windows.Forms.Padding(3, 3, 50, 3);
            this.comprarBtn.Name = "comprarBtn";
            this.comprarBtn.Size = new System.Drawing.Size(115, 51);
            this.comprarBtn.TabIndex = 0;
            this.comprarBtn.Text = "Comprar";
            this.comprarBtn.UseVisualStyleBackColor = true;
            // 
            // flpCentral
            // 
            this.flpCentral.AutoScrollMargin = new System.Drawing.Size(50, 0);
            this.flpCentral.AutoSize = true;
            this.flpCentral.Location = new System.Drawing.Point(201, 214);
            this.flpCentral.Name = "flpCentral";
            this.flpCentral.Size = new System.Drawing.Size(694, 213);
            this.flpCentral.TabIndex = 4;
            // 
            // statusStrip1
            // 
            this.statusStrip1.Items.AddRange(new System.Windows.Forms.ToolStripItem[] {
            this.toolStripStatusLabel1});
            this.statusStrip1.Location = new System.Drawing.Point(0, 596);
            this.statusStrip1.Name = "statusStrip1";
            this.statusStrip1.Size = new System.Drawing.Size(1027, 22);
            this.statusStrip1.TabIndex = 5;
            this.statusStrip1.Text = "statusStrip1";
            // 
            // toolStripStatusLabel1
            // 
            this.toolStripStatusLabel1.Name = "toolStripStatusLabel1";
            this.toolStripStatusLabel1.Size = new System.Drawing.Size(118, 17);
            this.toolStripStatusLabel1.Text = "toolStripStatusLabel1";
            // 
            // flowLayoutPanel1
            // 
            this.flowLayoutPanel1.Controls.Add(this.label1);
            this.flowLayoutPanel1.Location = new System.Drawing.Point(201, 70);
            this.flowLayoutPanel1.Name = "flowLayoutPanel1";
            this.flowLayoutPanel1.Size = new System.Drawing.Size(694, 100);
            this.flowLayoutPanel1.TabIndex = 9;
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.Font = new System.Drawing.Font("Century Gothic", 30F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label1.Location = new System.Drawing.Point(30, 0);
            this.label1.Margin = new System.Windows.Forms.Padding(30, 0, 3, 0);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(643, 47);
            this.label1.TabIndex = 0;
            this.label1.Text = "Bienvenido al sistema Palco Net";
            // 
            // MenuPrincipalForm
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(1027, 618);
            this.Controls.Add(this.flowLayoutPanel1);
            this.Controls.Add(this.statusStrip1);
            this.Controls.Add(this.flpCentral);
            this.Controls.Add(this.panelEmpresas);
            this.Controls.Add(this.menuStrip1);
            this.MainMenuStrip = this.menuStrip1;
            this.Name = "MenuPrincipalForm";
            this.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen;
            this.Text = "Menú Principal - PalcoNet";
            this.WindowState = System.Windows.Forms.FormWindowState.Maximized;
            this.Load += new System.EventHandler(this.MenuPrincipalForm_Load);
            this.contextMenuStrip1.ResumeLayout(false);
            this.menuStrip1.ResumeLayout(false);
            this.menuStrip1.PerformLayout();
            this.panelEmpresas.ResumeLayout(false);
            this.statusStrip1.ResumeLayout(false);
            this.statusStrip1.PerformLayout();
            this.flowLayoutPanel1.ResumeLayout(false);
            this.flowLayoutPanel1.PerformLayout();
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.ContextMenuStrip contextMenuStrip1;
        private System.Windows.Forms.ToolStripMenuItem historialPuntosToolStripMenuItem;
        private System.Windows.Forms.ToolStripMenuItem canjeDePuntosToolStripMenuItem;
        private System.Windows.Forms.MenuStrip menuStrip1;
        private System.Windows.Forms.Panel panelEmpresas;
        private System.Windows.Forms.Button rendConsBtn;
        private System.Windows.Forms.Button editPubBtn;
        private System.Windows.Forms.Button newPubBtn;
        private System.Windows.Forms.Button puntosBtn;
        private System.Windows.Forms.Button editCompBtn;
        private System.Windows.Forms.Button comprarBtn;
        private System.Windows.Forms.FlowLayoutPanel flpCentral;
        private System.Windows.Forms.ToolStripMenuItem misDatosToolStripMenuItem;
        private System.Windows.Forms.ToolStripMenuItem modificarUsuarioToolStripMenuItem;
        private System.Windows.Forms.ToolStripMenuItem cerrarSesionToolStripMenuItem;
        private System.Windows.Forms.ToolStripMenuItem empresasToolStripMenuItem;
        private System.Windows.Forms.ToolStripMenuItem nuevaEmpresaToolStripMenuItem;
        private System.Windows.Forms.ToolStripMenuItem consultarEmpresasToolStripMenuItem;
        private System.Windows.Forms.ToolStripMenuItem clientesToolStripMenuItem;
        private System.Windows.Forms.ToolStripMenuItem nuevoClienteToolStripMenuItem;
        private System.Windows.Forms.ToolStripMenuItem consultarClientesToolStripMenuItem;
        private System.Windows.Forms.ToolStripMenuItem gradosDePublicaciónToolStripMenuItem;
        private System.Windows.Forms.ToolStripMenuItem nuevoToolStripMenuItem;
        private System.Windows.Forms.ToolStripMenuItem consultarGradosToolStripMenuItem;
        private System.Windows.Forms.StatusStrip statusStrip1;
        private System.Windows.Forms.ToolStripStatusLabel toolStripStatusLabel1;
        private System.Windows.Forms.ToolTip toolTip1;
        private System.Windows.Forms.FlowLayoutPanel flowLayoutPanel1;
        private System.Windows.Forms.Label label1;
        private System.Windows.Forms.Button factComBtn;
        private System.Windows.Forms.ToolStripMenuItem rolesToolStripMenuItem;
        private System.Windows.Forms.ToolStripMenuItem nuevoRolToolStripMenuItem;
        private System.Windows.Forms.ToolStripMenuItem consultarRolesToolStripMenuItem;
    }
}