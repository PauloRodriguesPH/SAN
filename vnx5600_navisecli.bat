@echo off
setlocal

REM ============================================================
REM VNX5600 - LAB COMMANDS (NAVISECCLI)
REM Autor: Paulo Henrique da Silva Motta Rodrigues
REM Data: 25/03/2026
REM OBS:
REM - Ajuste o comando adicionando: -h IP_DO_STORAGE
REM   Exemplo: naviseccli -h 10.10.10.10 getagent
REM - Ou execute diretamente via Service IP dentro da SP
REM - Comandos baseados em laboratório real
REM - Alguns comandos são DESTRUTIVOS
REM ============================================================

REM ==============================
REM VERIFICACAO BASICA
REM ==============================

REM Verifica comunicação com o storage
naviseccli getagent

REM Status das SPs
naviseccli getsp

REM RAID Groups
naviseccli getrg

REM LUNs
naviseccli getlun

REM Storage Groups
naviseccli storagegroup -list

REM ==============================
REM CRIACAO DE RAID GROUP
REM ==============================

REM RG 0 - RAID 6
naviseccli createrg 0 0_0_4 0_0_5 0_0_6 0_0_7 0_0_8 0_0_9 0_0_10 0_0_11 0_0_12 0_0_13 -raidtype r6

REM RG 1 - RAID 6
naviseccli createrg 1 0_0_14 0_0_15 0_0_16 0_0_17 0_0_19 0_0_20 0_0_21 0_0_22 0_0_23 0_0_24 -raidtype r6

REM ==============================
REM CRIACAO DE LUN
REM ==============================

REM Criar LUN no RG 0
naviseccli bind r6 0 -rg 0

REM Renomear LUN
naviseccli chglun -l 0 -name LUN_PH_01

REM ==============================
REM STORAGE GROUP
REM ==============================

REM Criar SG
naviseccli storagegroup -create -gname SG_PH

REM Mapear LUN
naviseccli storagegroup -addhlu -gname SG_PH -alu 0 -hlu 0

REM ==============================
REM INITIATORS (WWPN)
REM ==============================

naviseccli storagegroup -setpath -gname SG_PH -hbauid 51:40:2e:c0:11:0c:6b:0d:51:40:2e:c0:11:0c:6b:0c -sp a -spport 0

naviseccli storagegroup -setpath -gname SG_PH -hbauid 51:40:2e:c0:11:0c:6b:0d:51:40:2e:c0:11:0c:6b:0c -sp b -spport 0

REM ==============================
REM LIMPEZA (DESTRUTIVO)
REM ==============================

REM Remover HLU
naviseccli storagegroup -removehlu -gname SG_PH -hlu 0

REM Apagar SG
naviseccli storagegroup -destroy -gname SG_PH

REM Remover Clone Private LUN
naviseccli clone -deallocatecpl

REM Remover LUN
naviseccli unbind -o 0

REM ==============================
REM TROUBLESHOOTING
REM ==============================

REM Faults
naviseccli faults -list

REM Geral
naviseccli getall

REM

echo ==========================================
echo FIM DOS COMANDOS
echo ==========================================

endlocal
pause
