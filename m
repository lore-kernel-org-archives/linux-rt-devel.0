Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010036.outbound.protection.outlook.com [52.101.84.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37D354A8A1C
	for <linux-rt-devel@lists.linux.dev>; Thu, 15 Oct 2026 08:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792051895; cv=fail; b=MUIxC9De1f3RW/LZ+Y+cJveZkLez7mCeEpNxZNz71J1hqZKUJxUqjuWrFxzNu58BtYyfJNwLH7/uk5O6O/Rxs4yzByrIc/Hi9Y2/alQU8hor0lcsdx6k0N0438QDs8EqfIo4mrzU95BqwPX4/0sbggcXv1JxOT2xzSYgX8fHJsM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792051895; c=relaxed/simple;
	bh=CuqmN+hEV1X2+dF6XQ8Oe3cQ/ddGVX4cIjnEuIhMWaM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=qfu9aT7ZIyhZoA+V+mfS/aKgaOE2/YwGxTITJW+hqH7ovt0n22xMq2U/y5mrLKbmRE6cfaS+DLfxEXaABB8RstrJnJCqKtOhewQlZdBS37zW3muXIsRHVlws3Qi0tOxTtLHrjP4QcYz/+z7unv7LsibUlZd682guPUoc/EcyovE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mobileye.com; spf=pass smtp.mailfrom=mobileye.com; dkim=pass (1024-bit key) header.d=mobileye.com header.i=@mobileye.com header.b=Lr9OrUZj; arc=fail smtp.client-ip=52.101.84.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mobileye.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mobileye.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mobileye.com header.i=@mobileye.com header.b="Lr9OrUZj"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xfCSQojybMVALvA27Gm16vTRe17IRNgzgn8GYPDykIU3UXlJA7gv9Jv1agDECv4Rwjwj6EmfgoEHzRfGeqN/XJRiGhMmAF3v0zxCMnnjjmsAEVaDEiOdN5lxQAypY40NA5ZqHIce2wpc2BmJN1k862DlQtTlJFv+qlSh680sAX9ELzEBdeyH2NYV5gQFcV/1etkT/xAHEwvj9bM8lz3iyv7nAV4dC/+2ncrpmSxi3l1jSW77et1JoloVix9sV+pQM1FPrZ4ZixXHQwHqwmpo6tH+SB3TadHOnmX/UHQP+wLjzJ5OzXPh/tGJ/YsuTdnNZD98/1R5O6J+vmvHqx4+5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CuqmN+hEV1X2+dF6XQ8Oe3cQ/ddGVX4cIjnEuIhMWaM=;
 b=JacR/ea1ntIWeJHoRjagOqk5ZKMd+TvnoZ5EoYhx40R82mHekzo7XPVRsGeINEs1uFtzrF1RPoY1acPgFVzrXeCN6Wfr+K4QZrvEMKoPURmrsP19s5wQ2v+BFKm4YP4f/qTXXLR7whgyjLHcuG9VDQc/sioDVQNB3LQTCLmSjYU4y1wTUxjyzPmM5JxkF2HgcmdYLytvLOwu3tbzQn3LVdcnFZ3wBim8oLDMRF1h416RFq6CySbeDzrSt71Ethm2ypMAL9W9vz21t8U8T4vIPRKpE6HmLSUVFk/9yms0Vedi+l/laA5C5sAx7wkRVAagX73kDqBvN8dRzAjOgPKm/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mobileye.com; dmarc=pass action=none header.from=mobileye.com;
 dkim=pass header.d=mobileye.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mobileye.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CuqmN+hEV1X2+dF6XQ8Oe3cQ/ddGVX4cIjnEuIhMWaM=;
 b=Lr9OrUZjXlVicBRX+AQ8h6m4MiATCSZVzx7SpX6YNAcush/puWI0q8GYezyPOaeIYTX0ljoGDf4ducO6166BFo3X3pKDicjnl1a8bbmTx5euf9vO6xJi+MMrUSAzA+X0uUkhMxqBncZAvE907/IDV8MNK0l9fee2atwYQL9Xpi8=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mobileye.com;
Received: from ZR6PR09MB889505.eurprd09.prod.outlook.com
 (2603:10a6:910:e0::22) by VI0PR09MB7045.eurprd09.prod.outlook.com
 (2603:10a6:800:242::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.13; Thu, 15 Oct
 2026 08:11:27 +0000
Received: from ZR6PR09MB889505.eurprd09.prod.outlook.com
 ([fe80::9006:1164:b51f:23a2]) by ZR6PR09MB889505.eurprd09.prod.outlook.com
 ([fe80::9006:1164:b51f:23a2%4]) with mapi id 15.21.0522.011; Thu, 15 Oct 2026
 08:11:27 +0000
Message-ID: <9bb6f315-c668-4f90-9fee-920f115a3dcd@mobileye.com>
Date: Thu, 15 Oct 2026 11:11:24 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] irqchip/riscv-aplic: fix asynchronous probing
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Anup Patel <anup@brainfault.org>, Thomas Gleixner <tglx@kernel.org>,
 Radu Rendec <radu@rendec.net>, Paul Walmsley <pjw@kernel.org>,
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Alexandre Ghiti <alex@ghiti.fr>, Clark Williams <clrkwllms@kernel.org>,
 Steven Rostedt <rostedt@goodmis.org>, Jessica Liu <liu.xuemei1@zte.com.cn>,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-rt-devel@lists.linux.dev
References: <20261012-aplic-async-probe-v3-1-5cf52dc28690@mobileye.com>
 <20261013152727.2cUDX3l0@linutronix.de>
 <5a8048ef-a241-4486-adc1-440721d3606a@mobileye.com>
 <20261014105312.xNkvgkGg@linutronix.de>
 <46eaa0f0-ff72-4a72-91c8-b610be2d893a@mobileye.com>
 <20261015063227.GBjyN6LZ@linutronix.de>
Content-Language: en-US
From: Vladimir Kondratiev <Vladimir.Kondratiev@mobileye.com>
In-Reply-To: <20261015063227.GBjyN6LZ@linutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TL2P290CA0028.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:3::10) To ZR6PR09MB889505.eurprd09.prod.outlook.com
 (2603:10a6:910:e0::22)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZR6PR09MB889505:EE_|VI0PR09MB7045:EE_
X-MS-Office365-Filtering-Correlation-Id: c5dd39b6-7b60-43fb-ae80-08df2a93e986
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|376014|7416014|366016|6133799003|22082099003|10067099003|18002099003|11063799006|4143699003|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	Cd1Gmuo4UlJzOPNoADBfVI7IBtVejVT2DR2LmMX2WInTt315D/DlPxlniMIYw0AlswBZhYvZRC1EDqXESviMomuCSTRI6NrWamP6ACpkLLJrClkjK/tg8EgZKJcTLozwHbCqu8sP2W2PHDs2SqnbjpPgfPXvHRfSnzOmEcNEWxBCaR6Jevz4xdb1kT9N9gnTCHNVSXhKxSiEIvP8Y8Dkfd1ON2cq88sG+87wLaMxyJBFOsmUi5SOjjcUakJi4Fms48D8OBgCb9HY3EkrsLHKbIJQAOkGpWMZaAiktfyoe+VU3dCjjr7RUkfuJct4elaCsf1un7TbeZv4NX0j29pPCckRNg8ube32eWJLcw+xzADQH9Atvj1MNhMvHQ0WDnfkLdWtbahzcfllVsSHfsjy9fxUNATXqBcf/5ZSsA1EbXriDYcLCgXcYoFnJFXxg3/TPeQvJgW9VZDVeU67zL6obLDdnsO+QAO5wD5lFJpiI+mCIvuBDkEcZVBAcJC+nud4eFmmF28IoewPaco8YS6aek2aClxnSMR7A0dq8PrgLiV9Gt8zAb69NPA9Z9bzFo/nE6mo+Za97oLXiMybc16KA7jMxH/hqXHSzRxC+KGp9uneIPfHQlkSJI36d2zZ3rfFyf55XTivPyvX5zVJaZoVspVoxxwE1iEwJkyh4QBDK0c=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZR6PR09MB889505.eurprd09.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(7416014)(366016)(6133799003)(22082099003)(10067099003)(18002099003)(11063799006)(4143699003)(261009223027099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cmkwUlpITXpTUW40akpaeWxiVThwSk85NHRyUm9jOUxucmpaVDBtK0pWKy92?=
 =?utf-8?B?ZHYrREFueG5qblVDN2g5M1lSd2RPWCtyVUtXaXNqUitkZE0zaVk0aW9ib2Vn?=
 =?utf-8?B?Z2V0cVA3WnhTSjBVYUJUZ0tQRWNkT2toZWp1bHhTeFdZMWo5VVo3Yy9jZlNI?=
 =?utf-8?B?Y0hkMEpRWnhCSkJ1Ykl3NmdzaVNTdXJpZlk5RU5uMGgzVUVmdGNya0ZwMGFT?=
 =?utf-8?B?aENTa1JsbU52aFJmRXZGV24wUDIwR2VUcWoraEpsb0w0RDNoV3JBT3pQVCtP?=
 =?utf-8?B?VWpYRS9XWHNnckJnUnYraSt5L1ZvTC9qaU8zSS8ybS9seWxTMW1KVzFXVzM2?=
 =?utf-8?B?QTJ4d3RFN2x1VTF5QWxHSFBnM25aUXVINU5FbndDczdqVUZPbTBlUW5janNw?=
 =?utf-8?B?eC9adEZhai8yZDJZQUJaaFZxZzErVE9NZmF6d1NQUXc4S2xwOFFnNmxzUWFL?=
 =?utf-8?B?YTNDc3hIa0RvTlhmeVRndHFIT1g1QUlBVUQvWEtmV1ZoTmFyZ2NDNXVkOW1M?=
 =?utf-8?B?cmtYWE0yaGo2M0ozdGRMT0pibDRZTnBNbWVFYjRlalVlV3hjUzFqY1N5ZXlC?=
 =?utf-8?B?eXZtSVlhdjlPWmxXZkluYVdOenBiaXFLSVZzOGc0T2kzeXM4bTZKbjNvU2VN?=
 =?utf-8?B?UlBXWklUaUR2a1d2WDlrTmJjRFA2WjNxYkdmQ3N2TU1wNXhvNXZKejdsYmZ3?=
 =?utf-8?B?Z2pDSUg4cUJUV2tpL2cwSi90aUlxTDllcGQwdHlzallJNEZRQ21NRkJjUitm?=
 =?utf-8?B?dVk0M3lhT1lkMVp5UVh6UFNmNDlHbVJpN0VlSzNXTVB2WEM0WWI1WW5XVWRR?=
 =?utf-8?B?dlBSQkVnNW9yOG1RSllWdTdhYzYyK0RhVDNnQmFTOVdYYzFsMkJlUzZNMGNi?=
 =?utf-8?B?YkRpR1VZdmtzd1N0Z3BuaFM3MnBaTjZIdXcvancyYVZQTHR6MjEzVTRacnBX?=
 =?utf-8?B?UjNpUVhyWG1ZM0NKajc4bnpmQUlpU1V0SjRreHRBRUMrN3pVNWFWUTRhcDlZ?=
 =?utf-8?B?OUZXbDIwcUliNVFwQ2ZZODhyT3R4WVZPOXgzamlzSTlVeWtWdWszWjFwbEo4?=
 =?utf-8?B?a0YxQkc0a2pMbXMxdXB2UTVmemxDR2FnNEFzby9YTFZkR3ZGd0ZnVHhnZXBT?=
 =?utf-8?B?SE4zYmowRmpnVDNNMDEwcm96azZpb2lUdEZqWWdYY3ZRMFJEMCt4VmJheUNM?=
 =?utf-8?B?ZUNOVFV4M1F6c3o2K3Z2MUZLUjJhZElhRjVHQVVzY1Y5Tmx5c09TblJqSzFu?=
 =?utf-8?B?UkdWcExDa3hGblQyVkpxeU1BQnFJMkpXc3h3V0xZT0R5NnpkRlNVQlZhU0tr?=
 =?utf-8?B?SWVMY0laZVVMdllLSWY5MWl5dGd2bVVQZnFuY2FaZ081WnNEMEhYOGk0amIx?=
 =?utf-8?B?aU5ROFJMV0RVNlJSNkorRTFTSkdtR3FvK0V5T1hETnlBR3lNa1haSTEzMFAr?=
 =?utf-8?B?OFlsdEVvREI0YzAzbVhSWTB3Skl2aktIMGNIRWt6Y1dVZzBjYllOcWpIQ1Z2?=
 =?utf-8?B?cXVRNXRadmx4dWVQbFlES09oWWo4UTducE9GMjBxMXJXREtzZTlCNDJwY0hV?=
 =?utf-8?B?eWlPZEZ5Z0NjUlBnUnk0bG1sdE1BN29zekxPanJzYlF3Qm5Kbkt0c09vSWVX?=
 =?utf-8?B?QW43S0dYVXprM1ZqN3ovSW5hck1TNUN1cWJ6UG00NEZ0cHpXUVhJNm16MnJl?=
 =?utf-8?B?eHdJZGRqMXVDY2JFdWhFVmZ6cHNQTUhjMmdSeTl0SUNkY0gwekJjQ1c1V0U3?=
 =?utf-8?B?Wm1JeFA3bThndlVGdXpWcEVYeHQvL3pUSXV2bERsaGFSbmFTQ0g3MmtISzVH?=
 =?utf-8?B?bUlaem9RL2JRY3FBODJQK2RLWTgrazVrVjI0b0tFcERQVm5vTWhMUmppL2dQ?=
 =?utf-8?B?dzRMOTFkMStsamE5akZ3ZmNVWnFDVExJT2U4UnhlYTROZWwxdmhDMzZKbnJI?=
 =?utf-8?B?cTVEZTgyMlYwWEVpa09WcEQ2TXFtZ0E3amhEWHF2U3RaVEYyTXgxL2tURUcv?=
 =?utf-8?B?RGR5N08yTWw1eUpPWmR1bUpMY3JEOGNuUE8wbHpPSFFvSE90aE04QmhQK1Nh?=
 =?utf-8?B?Njg2TkpUQVFsRlR1OU9OY1VqcVN6Y0dEcDc3elBUQjhVNkhWNm1IdHJ0cTlT?=
 =?utf-8?B?K3pWc09rZHM5TFQ0b0hmalVYQjhLY0RmUEpMN2YvSUV5WGlIUUxTSHpubjZl?=
 =?utf-8?B?bGNFa1p0U1NmQjBZQjdPR3pJVGNyeWlJd2E3enkvYW1nK1JZeWx0SnlQVUJs?=
 =?utf-8?B?dmpzbHkwS0dQckxuU25sVWZlaVVEbFE1ZjY0NjRxRk9SalV3Y2xmRmZrMUR0?=
 =?utf-8?B?TEtJMGVLeHlESEpscU50bTQwNnBoWUIyalVSMFJDTWkyM1MwbmRnQT09?=
X-OriginatorOrg: mobileye.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5dd39b6-7b60-43fb-ae80-08df2a93e986
X-MS-Exchange-CrossTenant-AuthSource: ZR6PR09MB889505.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2026 08:11:27.7315
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f85ba13-6953-46a6-9c5b-7599fd80e9aa
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LqagKNtVBnk/nopBK+R3C3rnmbW1jM3616GrLzz6PGcs3tZOxOe2Y/j67d3eet5MXbd8RLRynBc7hw4uwcJ57w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR09MB7045

On 10/15/26 09:32, Sebastian Andrzej Siewior wrote:
> The driver providing MSI capabilities (the MSI domain for this device)
> must a module. This is the requirement so that _this_ driver returns
> EPROBE_DEFER and *then* once the MSI domain driver is loaded as a module
> (after boot) this driver is probed again and succeeds.
Why module? for "riscv-aplic", "msi-parent" shall be "riscv-imsic" and
it is "builtin_platform_driver", see
drivers/irqchip/irq-riscv-imsic-platform.c

Thanks, Vladimir
