
# Brocade – Comandos Úteis

## 🔎 Diagnóstico e Portas

**Listar switches do fabric**
```bash
fabricshow
```

**Mostrar status geral das portas**
```bash
switchshow
```

**Detalhar uma porta específica**
```bash
portshow <porta>
```

**Exibir configurações das portas**
```bash
portcfgshow
```

---

## 🧩 Zoning – Consulta

**Mostrar zoning ativo**
```bash
cfgactvshow
```

**Ver nome da configuração ativa**
```bash
cfgactvshow | grep cfg
```

**Listar zones e seus membros**
```bash
zoneshow
```

**Encontrar zone pelo WWN ou alias**
```bash
zoneshow | grep -B 1 -i "<wwn-ou-alias>"
```

**Mostrar zones onde o WWN está presente**
```bash
nszoneshow -wwn <wwn>
```

**Ver detalhes da porta pelo WWN/Alias**
```bash
nodefind "<wwn-ou-alias>"
```

---

## 🧾 Alias

**Criar alias**
```bash
alicreate NOME_ALIAS, "wwn"
```

**Encontrar alias pelo WWN**
```bash
alishow | grep -B 1 -i "wwn"
```

**Listar todos os aliases**
```bash
alishow
```

---

## ➕ Criando Zone e Ativando

**Criar a zone**
```bash
zonecreate "ZONE_SERVER_STORAGE", "SERVER_HBA1; STORAGE_HBA1"
```

**Adicionar a zone à config**
```bash
cfgadd CONF_SAN, ZONE_SERVER_STORAGE
```

**Salvar**
```bash
cfgsave
```

**Ativar**
```bash
cfgenable CONF_SW
```

---

## 🧹 Remover Zone

**Remover da config**
```bash
cfgremove CONF_SAN, ZONE_SERVER_STORAGE
```

**Excluir a zone**
```bash
zonedelete "ZONE_SERVER_STORAGE"
```

**Salvar**
```bash
cfgsave
```

**Ativar**
```bash
cfgenable CONF_SW
```
