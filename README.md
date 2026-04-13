# Lucas Infra Core

![Deploy](https://github.com/seuusuario/maya-infra-core/actions/workflows/deploy.yml/badge.svg)

Infraestrutura como código para o ambiente de avaliação CORE.

## Stack

- Vagrant — provisionamento das VMs
- Ansible — configuração da infraestrutura
- GitHub Actions — pipeline CI/CD

## Como usar

### Pré-requisitos

- VirtualBox
- Vagrant
- Ansible

### Subir a infraestrutura

```bash
cd vagrant
vagrant up
ansible-playbook ansible/site.yml
```

## Infraestrutura

| VM   | IP            | Serviços                          |
| ---- | ------------- | --------------------------------- |
| vm01 | 192.168.51.11 | nginx, keepalived, snmp, scripts  |
| vm02 | 192.168.51.12 | nginx, keepalived, snmp, jboss    |
| vm03 | 192.168.51.13 | nginx, keepalived, snmp, iptables |

## VIP Keepalived

- 192.168.51.10 → avaliacaocore.maya.local
