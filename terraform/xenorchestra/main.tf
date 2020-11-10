#definicao do template que sera usado
data "xenorchestra_template" "template" {
#    name_label = "Debian10-Cloudinit"
     name_label = var.template_name
}

#definicao da rede
data "xenorchestra_pif" "pif" {
    device = "eth5"
    vlan   = 802
}

#outra rede (Backup)
#data "xenorchestra_pif" "pif2" {
   #device = "eth7"
    #vlan   = 50
#}

#orchestracao da maquina virtual
resource "xenorchestra_vm" "bar" {
    memory_max = 1073741824
    cpus  = 1
    cloud_config = "${xenorchestra_cloud_config.bar.template}"
    name_label = "VM-build-Terraform"
    name_description = "VM criada a partir do terraform - usando provider Xen Orchestra"
    template = "${data.xenorchestra_template.template.id}" #posso tambem colocar o uuid do template
    network {
      network_id = "${data.xenorchestra_pif.pif.network}"
    }
   
    #caso queira adicionar outra pif (definida em pif2)
#    network {
#      network_id = "${data.xenorchestra_pif.pif2.network}"
#    }

    disk {
      sr_id = "698e0f55-c22c-0262-aef9-0fe31fbfa6c6"
      name_label = "Debian10-terraform"
      #size = 4294967296 #disco padrao (4gb).
      size = 11212254720 #10gb
    }

    #adicionar outro disco ainda n esta funcionando
    #disk {
    #  sr_id = "0c931761-7885-59c3-13ba-3dddd4dd84b2"
    #  name_label = "Debian10-terraform-1"
    #  size = 11212254720 #10gb disco
    #}
}
