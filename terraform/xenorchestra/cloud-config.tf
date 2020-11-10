#definicao de cloud-config
resource "xenorchestra_cloud_config" "bar" {
  name = "cloud config terraform"
  template = <<EOF
#cloud-config
hostname: terra-form-app
ssh_authorized_keys:
  - ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQC/keTt1zcA70l15wziQO3ayu0hIcFgfTEMD23Trp5CBwohbmnu0P1R/0YMKnBrSZrZgoK+jgoajWNae8hb0Bw9aIEPHbJrCdmXztdVn6iHqbyTFm+iODZy1mUuuLC3U16QSipOH+Om+78R6OE1fPgBjIQFbbpPfna4SAdbcSfV+lJbn1ewezbb8nT6f/XegwFVL9rSq/KfK6bsOGU3kyiYJXX2whIwv+kydItLMYCh68MmdUqvW27tf6bgvZW4uwO6ebdiEa5F1oe4h5dvfyMqqRMnbX/jixTFWmZFRuGf6hLJQPjUnwh93hj4tRaaN2jjtT/fEl+wxEH8dje458itdf0H0q9L/DTj64L23JHsBoBbPPVUu+oDXc8zRBFl1QogPZx9BNaT13b2J0s8g5umzBtCirl4wvQwcB/mSyKspcW73j/gTsbEv+M3FKGFv5fGwAK0vOlBuZ+XLGMZF4xmO+ZY/Nl7uqSpjVRAUw35cW32M2ALHhYcoE0f68LVPnhR12taplUkoyQSOp2b/fq3BCsfp6q7meb1b3dstkeN4O8drgIXRH0HLmphUWLLykYLt/kwDmqpJ5FQFcRXm5nQdMGDbB/Rhk2C7t/cbV+J2PYOzD1rpmbJa8uJQmj1M2VyTPphVLew4iQzCFyFYResoQM+IFOcsaIlOgdN5bGXUw== marlluslustosa@gmail.com

#extender / com o novo tamanho adicionado para o disco principal xvda
#atencao: bootcmd rodará antes de packages e runcmd mas a ordem neste arquivo não é a mesma coisa que a ordem dos modulos do clouinit. bootcmd sempre rodará primeiro (cloud-init initial stage)
bootcmd:
#cria uma particao (xvda3) usando o espaco adicional e depois extenda o lvroot
  - parted /dev/xvda mkpart primary ext4 4294MB 100%
  - vgextend debian10-minimal-vg /dev/xvda3
  - lvextend /dev/mapper/debian10--minimal--vg-root /dev/xvda3
  - resize2fs /dev/debian10-minimal-vg/root

packages:
  - apt-transport-https
  - ca-certificates
  - curl
  - gnupg-agent
  - software-properties-common

runcmd:
  - curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add -
  - add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/debian $(lsb_release -cs) stable"
  - apt-get update -y
  - apt-get -y install docker-ce docker-ce-cli containerd.io
  - systemctl start docker
  - systemctl enable docker
  - curl -L "https://github.com/docker/compose/releases/download/1.26.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
  - chmod +x /usr/local/bin/docker-compose
  - ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose
EOF
}

