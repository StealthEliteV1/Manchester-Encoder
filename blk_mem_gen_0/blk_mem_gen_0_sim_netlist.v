// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// Copyright 2022-2025 Advanced Micro Devices, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2025.2 (win64) Build 6299465 Fri Nov 14 19:35:11 GMT 2025
// Date        : Fri Mar 13 10:11:35 2026
// Host        : RCrook_HP running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode funcsim
//               c:/Manhattan/ECE-232/VHDL_Examples/blk_mem_gen_0/blk_mem_gen_0_sim_netlist.v
// Design      : blk_mem_gen_0
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xc7s50csga324-1
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CHECK_LICENSE_TYPE = "blk_mem_gen_0,blk_mem_gen_v8_4_12,{}" *) (* downgradeipidentifiedwarnings = "yes" *) (* x_core_info = "blk_mem_gen_v8_4_12,Vivado 2025.2" *) 
(* NotValidForBitStream *)
module blk_mem_gen_0
   (clka,
    ena,
    wea,
    addra,
    dina,
    douta);
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA CLK" *) (* x_interface_mode = "slave BRAM_PORTA" *) (* x_interface_parameter = "XIL_INTERFACENAME BRAM_PORTA, MEM_ADDRESS_MODE BYTE_ADDRESS, MEM_SIZE 8192, MEM_WIDTH 32, MEM_ECC NONE, MASTER_TYPE OTHER, READ_LATENCY 1" *) input clka;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA EN" *) input ena;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA WE" *) input [0:0]wea;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA ADDR" *) input [6:0]addra;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA DIN" *) input [19:0]dina;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA DOUT" *) output [19:0]douta;

  wire [6:0]addra;
  wire clka;
  wire [19:0]dina;
  wire [19:0]douta;
  wire ena;
  wire [0:0]wea;
  wire NLW_U0_dbiterr_UNCONNECTED;
  wire NLW_U0_rsta_busy_UNCONNECTED;
  wire NLW_U0_rstb_busy_UNCONNECTED;
  wire NLW_U0_s_axi_arready_UNCONNECTED;
  wire NLW_U0_s_axi_awready_UNCONNECTED;
  wire NLW_U0_s_axi_bvalid_UNCONNECTED;
  wire NLW_U0_s_axi_dbiterr_UNCONNECTED;
  wire NLW_U0_s_axi_rlast_UNCONNECTED;
  wire NLW_U0_s_axi_rvalid_UNCONNECTED;
  wire NLW_U0_s_axi_sbiterr_UNCONNECTED;
  wire NLW_U0_s_axi_wready_UNCONNECTED;
  wire NLW_U0_sbiterr_UNCONNECTED;
  wire [19:0]NLW_U0_doutb_UNCONNECTED;
  wire [6:0]NLW_U0_rdaddrecc_UNCONNECTED;
  wire [3:0]NLW_U0_s_axi_bid_UNCONNECTED;
  wire [1:0]NLW_U0_s_axi_bresp_UNCONNECTED;
  wire [6:0]NLW_U0_s_axi_rdaddrecc_UNCONNECTED;
  wire [19:0]NLW_U0_s_axi_rdata_UNCONNECTED;
  wire [3:0]NLW_U0_s_axi_rid_UNCONNECTED;
  wire [1:0]NLW_U0_s_axi_rresp_UNCONNECTED;

  (* C_ADDRA_WIDTH = "7" *) 
  (* C_ADDRB_WIDTH = "7" *) 
  (* C_ALGORITHM = "1" *) 
  (* C_AXI_ID_WIDTH = "4" *) 
  (* C_AXI_SLAVE_TYPE = "0" *) 
  (* C_AXI_TYPE = "1" *) 
  (* C_BYTE_SIZE = "9" *) 
  (* C_COMMON_CLK = "0" *) 
  (* C_COUNT_18K_BRAM = "1" *) 
  (* C_COUNT_36K_BRAM = "0" *) 
  (* C_CTRL_ECC_ALGO = "NONE" *) 
  (* C_DEFAULT_DATA = "0" *) 
  (* C_DISABLE_WARN_BHV_COLL = "0" *) 
  (* C_DISABLE_WARN_BHV_RANGE = "0" *) 
  (* C_ELABORATION_DIR = "./" *) 
  (* C_ENABLE_32BIT_ADDRESS = "0" *) 
  (* C_EN_DEEPSLEEP_PIN = "0" *) 
  (* C_EN_ECC_PIPE = "0" *) 
  (* C_EN_RDADDRA_CHG = "0" *) 
  (* C_EN_RDADDRB_CHG = "0" *) 
  (* C_EN_SAFETY_CKT = "0" *) 
  (* C_EN_SHUTDOWN_PIN = "0" *) 
  (* C_EN_SLEEP_PIN = "0" *) 
  (* C_EST_POWER_SUMMARY = "Estimated Power for IP     :     3.03925 mW" *) 
  (* C_FAMILY = "spartan7" *) 
  (* C_HAS_AXI_ID = "0" *) 
  (* C_HAS_ENA = "1" *) 
  (* C_HAS_ENB = "0" *) 
  (* C_HAS_INJECTERR = "0" *) 
  (* C_HAS_MEM_OUTPUT_REGS_A = "1" *) 
  (* C_HAS_MEM_OUTPUT_REGS_B = "0" *) 
  (* C_HAS_MUX_OUTPUT_REGS_A = "0" *) 
  (* C_HAS_MUX_OUTPUT_REGS_B = "0" *) 
  (* C_HAS_REGCEA = "0" *) 
  (* C_HAS_REGCEB = "0" *) 
  (* C_HAS_RSTA = "0" *) 
  (* C_HAS_RSTB = "0" *) 
  (* C_HAS_SOFTECC_INPUT_REGS_A = "0" *) 
  (* C_HAS_SOFTECC_OUTPUT_REGS_B = "0" *) 
  (* C_INITA_VAL = "0" *) 
  (* C_INITB_VAL = "0" *) 
  (* C_INIT_FILE = "blk_mem_gen_0.mem" *) 
  (* C_INIT_FILE_NAME = "blk_mem_gen_0.mif" *) 
  (* C_INTERFACE_TYPE = "0" *) 
  (* C_LOAD_INIT_FILE = "1" *) 
  (* C_MEM_TYPE = "0" *) 
  (* C_MUX_PIPELINE_STAGES = "0" *) 
  (* C_PRIM_TYPE = "1" *) 
  (* C_READ_DEPTH_A = "104" *) 
  (* C_READ_DEPTH_B = "104" *) 
  (* C_READ_LATENCY_A = "1" *) 
  (* C_READ_LATENCY_B = "1" *) 
  (* C_READ_WIDTH_A = "20" *) 
  (* C_READ_WIDTH_B = "20" *) 
  (* C_RSTRAM_A = "0" *) 
  (* C_RSTRAM_B = "0" *) 
  (* C_RST_PRIORITY_A = "CE" *) 
  (* C_RST_PRIORITY_B = "CE" *) 
  (* C_SIM_COLLISION_CHECK = "ALL" *) 
  (* C_USE_BRAM_BLOCK = "0" *) 
  (* C_USE_BYTE_WEA = "0" *) 
  (* C_USE_BYTE_WEB = "0" *) 
  (* C_USE_DEFAULT_DATA = "1" *) 
  (* C_USE_ECC = "0" *) 
  (* C_USE_SOFTECC = "0" *) 
  (* C_USE_URAM = "0" *) 
  (* C_WEA_WIDTH = "1" *) 
  (* C_WEB_WIDTH = "1" *) 
  (* C_WRITE_DEPTH_A = "104" *) 
  (* C_WRITE_DEPTH_B = "104" *) 
  (* C_WRITE_MODE_A = "WRITE_FIRST" *) 
  (* C_WRITE_MODE_B = "WRITE_FIRST" *) 
  (* C_WRITE_WIDTH_A = "20" *) 
  (* C_WRITE_WIDTH_B = "20" *) 
  (* C_XDEVICEFAMILY = "spartan7" *) 
  (* downgradeipidentifiedwarnings = "yes" *) 
  (* is_du_within_envelope = "true" *) 
  blk_mem_gen_0_blk_mem_gen_v8_4_12 U0
       (.addra(addra),
        .addrb({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .clka(clka),
        .clkb(1'b0),
        .dbiterr(NLW_U0_dbiterr_UNCONNECTED),
        .deepsleep(1'b0),
        .dina(dina),
        .dinb({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .douta(douta),
        .doutb(NLW_U0_doutb_UNCONNECTED[19:0]),
        .eccpipece(1'b0),
        .ena(ena),
        .enb(1'b0),
        .injectdbiterr(1'b0),
        .injectsbiterr(1'b0),
        .rdaddrecc(NLW_U0_rdaddrecc_UNCONNECTED[6:0]),
        .regcea(1'b1),
        .regceb(1'b1),
        .rsta(1'b0),
        .rsta_busy(NLW_U0_rsta_busy_UNCONNECTED),
        .rstb(1'b0),
        .rstb_busy(NLW_U0_rstb_busy_UNCONNECTED),
        .s_aclk(1'b0),
        .s_aresetn(1'b0),
        .s_axi_araddr({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .s_axi_arburst({1'b0,1'b0}),
        .s_axi_arid({1'b0,1'b0,1'b0,1'b0}),
        .s_axi_arlen({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .s_axi_arready(NLW_U0_s_axi_arready_UNCONNECTED),
        .s_axi_arsize({1'b0,1'b0,1'b0}),
        .s_axi_arvalid(1'b0),
        .s_axi_awaddr({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .s_axi_awburst({1'b0,1'b0}),
        .s_axi_awid({1'b0,1'b0,1'b0,1'b0}),
        .s_axi_awlen({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .s_axi_awready(NLW_U0_s_axi_awready_UNCONNECTED),
        .s_axi_awsize({1'b0,1'b0,1'b0}),
        .s_axi_awvalid(1'b0),
        .s_axi_bid(NLW_U0_s_axi_bid_UNCONNECTED[3:0]),
        .s_axi_bready(1'b0),
        .s_axi_bresp(NLW_U0_s_axi_bresp_UNCONNECTED[1:0]),
        .s_axi_bvalid(NLW_U0_s_axi_bvalid_UNCONNECTED),
        .s_axi_dbiterr(NLW_U0_s_axi_dbiterr_UNCONNECTED),
        .s_axi_injectdbiterr(1'b0),
        .s_axi_injectsbiterr(1'b0),
        .s_axi_rdaddrecc(NLW_U0_s_axi_rdaddrecc_UNCONNECTED[6:0]),
        .s_axi_rdata(NLW_U0_s_axi_rdata_UNCONNECTED[19:0]),
        .s_axi_rid(NLW_U0_s_axi_rid_UNCONNECTED[3:0]),
        .s_axi_rlast(NLW_U0_s_axi_rlast_UNCONNECTED),
        .s_axi_rready(1'b0),
        .s_axi_rresp(NLW_U0_s_axi_rresp_UNCONNECTED[1:0]),
        .s_axi_rvalid(NLW_U0_s_axi_rvalid_UNCONNECTED),
        .s_axi_sbiterr(NLW_U0_s_axi_sbiterr_UNCONNECTED),
        .s_axi_wdata({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .s_axi_wlast(1'b0),
        .s_axi_wready(NLW_U0_s_axi_wready_UNCONNECTED),
        .s_axi_wstrb(1'b0),
        .s_axi_wvalid(1'b0),
        .sbiterr(NLW_U0_sbiterr_UNCONNECTED),
        .shutdown(1'b0),
        .sleep(1'b0),
        .wea(wea),
        .web(1'b0));
endmodule
`pragma protect begin_protected
`pragma protect version = 1
`pragma protect encrypt_agent = "XILINX"
`pragma protect encrypt_agent_info = "Xilinx Encryption Tool 2025.2"
`pragma protect key_keyowner="Synopsys", key_keyname="SNPS-VCS-RSA-2", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=128)
`pragma protect key_block
YqH9kwIC39+qbZg4PSfFsXuB9k9wnuxNryS/CfnEri6Ci9fSC6fsrQ/T/hnt3u/yolbJ8DJa1Qu6
Qnm24A9jLbA+fu3Nsmm6/rM6a4vU6OfVl/gTFd/CiWDutv6Dhn6Lim4uUNPahoOR/A2Yc4Zo2tdI
kMLO9gn9WlH2l3O2oXs=

`pragma protect key_keyowner="Aldec", key_keyname="ALDEC15_001", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
XJYO2VHd/cnMxQd3i7/2qRhl57dl+doEKuhAunQyv3vpGRG/jlNxj8PqrgLoF0HMdqE3qJUVE/oq
kBSapqjVjLDMOrNGQ+Tc6VGsKMZH8FE/TXHQJ/IM5Iuiu2eozEwwVUomF+7cfqn+9OsVsqCONQ1M
g0oRlangiqasJDhhMfnlGGqwAwmgWRGQA6dmhTuua1s8zdvIv540zY6p5au8cAKVhqyyKK7wbxEE
SGuFqX+NYoyRV+rfWCcWM+hJEmnWS8LNAKkd13YE2+17sPYzUdZ23DmTxXK6KlAxKFW27CBySUfg
qdNXp2DSs2KAQYih27pBNMuHfGbM/ATFPWFvxg==

`pragma protect key_keyowner="Mentor Graphics Corporation", key_keyname="MGC-VELOCE-RSA", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=128)
`pragma protect key_block
lYoEi/e8HsDTz6N11EDe/B/iitERmeYndlCklmCluwgb0N4W80JUGVlkd7NlRZHRNhxaNBJPkcjC
n61nO0tb17NwsMwjbY5TF8JWRYTNw1JXCFacvQYrdKv4/7QNQEtwVGiCLxFhOA8aHlWMZIrc2fri
VRMVWaEBcPwCGorlVIM=

`pragma protect key_keyowner="Mentor Graphics Corporation", key_keyname="MGC-VERIF-SIM-RSA-2", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
QEw9fEsWFbdX0OQLvYs/gl+zyEOW3ak9TdQVaq+0AXXOT3LIqF7wDxJ6ZBnlf9mNbdsUVH5tAz1o
H8u7ihJl1L3THEvugW+TS8hkvVbEA9rKO2vV15KAj4Lla7UdFT/xDfe79RFarlLI7yGrubjgdoRi
QWy//UKsffG7IWNwmoSuppWiWB4ZHJtkunNyIkm70JPGyZF62VxJg1MTT+5LUbZG5vZjjuHZud9w
xJaKv1tFP/x8RVqLU5gPOqGqTW7/nKO2S+450Vo4D9vAmBVVcXpaL1EbSmCvQ+qJmcQKtf9qYFRV
Zko08hbpHjPxstqvTDro01jRzB8592m4xU2TWA==

`pragma protect key_keyowner="Real Intent", key_keyname="RI-RSA-KEY-1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
TC7q853CWBPPJgbRfgDV1lmjUwSAtliljShAyNFg8sfRfwDzchthzoSPH1UCHV++E2JXacEKq1lB
UWsNP92U4Xh0/Gu+6esOI0pJb8I+TRTxyBN1I4cRQEfQHcwfhbSdeH3yX9OV3opLEqYmT37hWU+J
zCawYnxVESI0FtRzEXve9gdEWlrKKckrT/hp4mvxxOjvOkOSQBvy0elgUOqh6mEOZl+JnUbsR+Wm
CoZLE1eefMZy3FnVmyDNPv3JPXi88aLXMyimal0MYFkTiS4XJiGT3eAIMIbksehXY+eYi/KFpZWQ
GHpX+lG3UmiWWLwyPakFwKEHbrBc70AlJ2eV9g==

`pragma protect key_keyowner="Xilinx", key_keyname="xilinxt_2025.1-2029.x", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
j9nmCKgjPWNChPbpSW6EWLrMA6oCG2JGPoum8px09v0PEAh0DRXZi0J8HPzXUsZgOEMcKpA7X54u
YFcDDCLAQ+urha/eSPbQYHQh4yGCursxAQ1C6LEyNQ2wJ0eLlO2bJeAl/gof06zqsYVM2lLJVNv5
wao1k2bmgPdfpfY3c9vPD0fSMuZPS41EoRS0cQhO5GTZnKdjxm6tEUL3GnTjB8ynSCIbCJUsMtAX
4FRHNa52gudx5B5fagR+lXgFhE7e++rWTJELr7SYB+r5Es8qZLTpCH8TrQxEkV0rY/+e4sAjNE2D
gHw8GD7VcUtc15B8y1BbVmh29qc8Nd3V2i/miA==

`pragma protect key_keyowner="Metrics Technologies Inc.", key_keyname="DSim", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
UkCD6I/Vye4qNoNoa3hIexBXG3xyKUJPAHAjIo7UcNVCDXpMQiYEtPDqExZMfiPlJn2nswCYIfIJ
FYWqMCloKSQyyI/7yZ2EtbyWEklb/P5IyZyvGi6hhFUo/JFTb12b4bK0gZPr+bCDdlVQKTx5GVHz
wptdUJO2omSj8axVMPbLRRtVzlJIZ29dTJ2ATXVXAcBxPnFfHRAMnYYKLeeLExX61vQvpqrkLQHm
XG7hpVzJi56gYKAzxa2BLq072OCVpVS70bfWlhlSTVcSlCrUf+EcarEk4FD8+Ih2NCvrqremG6yn
TtcBn8Xr8M/6zhOYvLi6AD6eArDMKA8n+Ccv8A==

`pragma protect key_keyowner="Atrenta", key_keyname="ATR-SG-RSA-1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=384)
`pragma protect key_block
A5y5QVZU8yjPexRVPioSiAGohCHD5DX5FVobuMyhcgQRExLUhPvnnS8HOtxTj/2IapEcz68gFMGG
Hpi+m725u85/om/Vze9pGIW9Mn328Kz2FIg3W5EvGstfGwY+48LiAGAmTR269JS4lJGVYWYOz7Xk
S8cEsFd2m7j8iyKtARJzD90+UdXq/cIIh725jC9i8nbgxB364zddvm1Z/DF3JRw1qFp6GGcuRai1
KNcJ1j8c9wtIgktpsteU3e5+bxHEw8NT3gWXUFYjm00NDq97Jals8Jjktmum2nQxoF7ivPacfEey
gnSF6jRMkTsZObzc30hAhs0CEtc33hZLhPLHSn8pQ0WyvKJLHdd5s2yckgTZtqxC1Sbwe7WEgNXe
ZMX3pIkz+aoXsAL7GBLyVBMVQcyMoF0w8QGAaTe8sqatABwPqXidYRqNROTf62IYcMpV89XYgaTv
EwIn/oni9KOFd2BFVxRZbFGGC4IjvigsTBUijI+Dk6kVnDh240clGcc4

`pragma protect key_keyowner="Cadence Design Systems.", key_keyname="CDS_RSA_KEY_VER_1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
Omtp+lCaqUx7Z4qdFj2zrN8LpCkit2eX4hlMtig+ielGm/x4FSZkpjoFmiqdKFPi2eg0pg09MSai
XyGH68UzAR7Xrj8f1jlIoUmMKp4GcxfdqfTeuu7kWGOJEP6cvgTjSJFj2gawDv7f4yZcltnK2x0L
e4GW/rBTmGvZtKWb2ahjINLxPuh3dDaSaWdb+zVgbtyrI5FrjxBkq+aOxSjyNsqnCx1L0uWbxnkl
88NbXN3dTaECXHNm/fsleayM5hKis7kTv9BFajJMGy+BhQlmIYpE+F5zchnTTFUFJZCz1sX9Fc8e
HcY7irB8mR3ajdzjUZLBQEMktp096Nheq3U75A==

`pragma protect key_keyowner="Synplicity", key_keyname="SYNP15_1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
hpeBLwN9x2ZFDwroYLlUe5GjjDepHik2l0c2s3/6S7JPCRkzQSyt2V1Ad/JewAs/QNp5SXSbYYB4
rQl0My1LDMF3xw43r0g2IbcyHVpPhGp0W5msuQdF67afnsRv90iJYWLMI3QkYGCTWAzl4HrLxFSg
3z8XZRK670IcxznOrlvgHmIKsvubZrBkuc1EynrVb9Nw16QnIx2rc4WgcEXeFf+4i1RoYLDd3gXK
NFCNMdtaRYUThunFP6Z4ViZ5UnDmKq+IMhd31jTaqIlWOBDxPI1+v5RJYxIyTbn4rxlKR2fNbl5/
z4OUjBTd+1GH3I2OXlqmAOvIhpe2Z2HH7nZu/A==

`pragma protect key_keyowner="Mentor Graphics Corporation", key_keyname="MGC-PREC-RSA", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
Mt2RhTSUwEIEWeNARbyL+EdfS1UF6nPaL/fKl/7oO2gina93egwCWDLl1fbBtkfaPco0cu4MJ9K3
OraAsyHRlY+MNShmJ1LzAIA1LjZx4y55lu9dlQqSUXR7AW7wVbkg1864mK+hM/1XygU0jvebKNW9
B7xSER+asLO6pxi0mt7uC2PHxLPAYEszFhmnap82TtbDGdQ2qtyekY+ngs+N2fAdsblxVwJruiMl
e6XJ127M8N1mYwhWU2HtRpBOSnnKoHgD9fG51XK/rhk8DxT66QnX9uLPB+H25eDupBJGi1Y5o6x8
hOwZiSUVlBLh7brfzevh7+eRn+7es6wBas0+3w==

`pragma protect data_method = "AES128-CBC"
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 20336)
`pragma protect data_block
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
`pragma protect end_protected
`ifndef GLBL
`define GLBL
`timescale  1 ps / 1 ps

module glbl ();

    parameter ROC_WIDTH = 100000;
    parameter TOC_WIDTH = 0;
    parameter GRES_WIDTH = 10000;
    parameter GRES_START = 10000;

//--------   STARTUP Globals --------------
    wire GSR;
    wire GTS;
    wire GWE;
    wire PRLD;
    wire GRESTORE;
    tri1 p_up_tmp;
    tri (weak1, strong0) PLL_LOCKG = p_up_tmp;

    wire PROGB_GLBL;
    wire CCLKO_GLBL;
    wire FCSBO_GLBL;
    wire [3:0] DO_GLBL;
    wire [3:0] DI_GLBL;
   
    reg GSR_int;
    reg GTS_int;
    reg PRLD_int;
    reg GRESTORE_int;

//--------   JTAG Globals --------------
    wire JTAG_TDO_GLBL;
    wire JTAG_TCK_GLBL;
    wire JTAG_TDI_GLBL;
    wire JTAG_TMS_GLBL;
    wire JTAG_TRST_GLBL;

    reg JTAG_CAPTURE_GLBL;
    reg JTAG_RESET_GLBL;
    reg JTAG_SHIFT_GLBL;
    reg JTAG_UPDATE_GLBL;
    reg JTAG_RUNTEST_GLBL;

    reg JTAG_SEL1_GLBL = 0;
    reg JTAG_SEL2_GLBL = 0 ;
    reg JTAG_SEL3_GLBL = 0;
    reg JTAG_SEL4_GLBL = 0;

    reg JTAG_USER_TDO1_GLBL = 1'bz;
    reg JTAG_USER_TDO2_GLBL = 1'bz;
    reg JTAG_USER_TDO3_GLBL = 1'bz;
    reg JTAG_USER_TDO4_GLBL = 1'bz;

    assign (strong1, weak0) GSR = GSR_int;
    assign (strong1, weak0) GTS = GTS_int;
    assign (weak1, weak0) PRLD = PRLD_int;
    assign (strong1, weak0) GRESTORE = GRESTORE_int;

    initial begin
	GSR_int = 1'b1;
	PRLD_int = 1'b1;
	#(ROC_WIDTH)
	GSR_int = 1'b0;
	PRLD_int = 1'b0;
    end

    initial begin
	GTS_int = 1'b1;
	#(TOC_WIDTH)
	GTS_int = 1'b0;
    end

    initial begin 
	GRESTORE_int = 1'b0;
	#(GRES_START);
	GRESTORE_int = 1'b1;
	#(GRES_WIDTH);
	GRESTORE_int = 1'b0;
    end

endmodule
`endif
