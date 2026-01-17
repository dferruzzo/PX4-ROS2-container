# PX4 ROS2 Container

Script para executar o PX4 SITL com Gazebo em um container Docker com suporte a GUI.

## Pré-requisitos

- Docker instalado
- X11 disponível (para GUI do Gazebo)
- PX4-Autopilot clonado em `$HOME/PX4-Autopilot`

## Instalação

1. Clone o repositório PX4:
```bash
git clone https://github.com/PX4/PX4-Autopilot.git $HOME/PX4-Autopilot
```

2. Configure permissões do script:
```bash
chmod +x px4-container.sh
```

## Uso

Execute o script:
```bash
./px4-container.sh
```

O container iniciará e você será colocado diretamente no diretório `$PX4_DIR` com bash aberto.

## O que o script faz

- Verifica se o diretório PX4 existe
- Remove containers anteriores com o mesmo nome
- Configura acesso ao X server para GUI
- Monta o volume PX4 como leitura/escrita
- Mapeia a porta UDP 14570 para comunicação MAVLink
- Inicia o container e abre um shell bash

## Variáveis

- `PX4_IMAGE`: Imagem Docker oficial do PX4 com ROS2 Foxy
- `PX4_DIR`: Diretório local do PX4-Autopilot (`$HOME/PX4-Autopilot`)

## Ports

- **14570/UDP**: MAVLink (comunicação com simulador)

## RODAR PX4

Na pasta `$HOME/PX4-Autopilot` rode:
```
make px4_sitl_default gazebo-classic
```

## Notas

- Use `xhost +local:docker` se tiver problemas de acesso ao X11
- O container é removido automaticamente ao sair (`--rm`)
- Modo privilegiado está ativado para suporte a devices

