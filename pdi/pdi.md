# Dockerizando PDI

## Dependências

graph LR;
flowchart TD
```mermaid
flowchart TD;
    Host;
    PastaHost;
    %%-------------------------
    Container;
    %%-------------------------
    Ubuntu[ubuntu:24.04] --> Container;
    volume --> Container;
    %%-------------------------
    RepositorioObsoleto[Repositório do Ubuntu Bionic] --> Ubuntu;
    Java8 --> Ubuntu;

    .kettle --> volume
    src --> volume
    libs --> volume
    %%-------------------------
    GTK[libwebkitgtk-1.0] --> RepositorioObsoleto
    %%-------------------------
    PDI--> GTK & Java8 & .kettle & src & libs;

```

## Componentes

### Ubuntu
```bash
docker pull ubuntu:24.04
docker pull docker.io/ubuntu@sha256:2e863c44b718727c860746568e1d54afd13b2fa71b160f5cd9058fc436217b30
```