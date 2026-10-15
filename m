Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011048.outbound.protection.outlook.com [52.101.65.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9B5E446BE0
	for <linux-rt-devel@lists.linux.dev>; Thu, 15 Oct 2026 13:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792072380; cv=fail; b=K3wsR22kG4zM2gdSMvS9kk9hPvUL6OYX8mzvdDuZ4FF3eGzfptILAz1U5npZ7JJTO9sjArmFVmrxa8lQTFyLPaIgBE4vZ3pOz9QE4gD3dKyGV7vALIM80dBqTwYQFCffwC2oaNy2ORIjlAXlYv97fOvTo1n6HIYg/L3Q92g6vs8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792072380; c=relaxed/simple;
	bh=jbnFTYvY0yizVn0PcNftWCuttcH4B3bnRf0tB1DdGI8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=QZJefO1RSr9jU92HBvduPniD9/jUKmx+qrcSCGB+PhtCCX+ZIgbeC+BHqpbzrol/1PO/V4Ss2+Wimhf1yRGWXBdWbFUmjSYWLDXvIbITXA8exEARPPLYKiYqm7kx3DpSQl2aYDULEFdi/IZw4oT1rcxGGUzqXOy51XH2aDomCc8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mobileye.com; spf=pass smtp.mailfrom=mobileye.com; dkim=pass (1024-bit key) header.d=mobileye.com header.i=@mobileye.com header.b=jFf82haa; arc=fail smtp.client-ip=52.101.65.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mobileye.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mobileye.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mobileye.com header.i=@mobileye.com header.b="jFf82haa"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EbHANVFe7BAuUuNbLeH5W1w75yEW0AafLLLJRY5C0uCEodx2b+WMXclwA7vIsT/ugiE6zSQ8mAcvRt+ckgNFqY6phguvs8o2RjCBRIWM5W+iGmCPO1UAhgWcp2ViHHd8brLm30MCLiqOLlGh3ljOZVevZQ0FV/1UXRv3yNHk0DeCHCT6lIsiuWxtXqUkQblkHoNogwDdiJBGcay0XfV4Z5A/wjlRfUgL90vBRcL8BYm9vjcUon8ZZqZQKxFt2j/BU2eQjlrY1cWx/4+ActyWe0AbMKfQvxJoi4JU0iP10bKrOdPo2i6uf1aTg763+HvgtbWld0grX2AkSOTJ+9lBKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/Htw5rHPBQ7vm1XlGkigUCDbPo+0A56kEnwJUQgEBjQ=;
 b=LzdqQ3BMhCG2GrFVE41Wx3pHSUh4itKEE4eQab88hbLnK5tBai1Ty9Xz4KvOdQrgaQLDsVM6yCFVp7Q7idRPG1RNzIem4TU3EENcsdgVyx00woJtSOqMoJdq1FwPRpKN/ueZFT7FEljfrKztPvyepbCZz1LAxJWgZaYVaEqWAiDiYU7SvS6XVcdJ3rUKz8APXT1PZe30qdpgeu++v2pWDCjQ5TsG1cLzIgOEISXpwAjZ6Lfjt+n1RxFJygn7A+JoZ/C8u7q1R+dSrldKfStmroUwUDH2XpeexT7TkK1QvCav2+j0I8SAlfyf9KCCObqUlDLT9OBjgiKIjhYlnciRrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mobileye.com; dmarc=pass action=none header.from=mobileye.com;
 dkim=pass header.d=mobileye.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mobileye.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/Htw5rHPBQ7vm1XlGkigUCDbPo+0A56kEnwJUQgEBjQ=;
 b=jFf82haazI+V8weJxVdakQNgXRCUrUwf6rbTKmk0/hmn2jS90jOwNekL4IwxwLeVcmLxEBhf2oV+rzKLkfLKsUjfuE72msuCuQxrPkYlVHwBCxXCjteYeSJ0IY3J/vd8gTsG5CO5lPOWGvg+d4mxOW0FReG2fXto6kehKFG/cFw=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mobileye.com;
Received: from ZR6PR09MB889505.eurprd09.prod.outlook.com
 (2603:10a6:910:e0::22) by PA2PR09MB7345.eurprd09.prod.outlook.com
 (2603:10a6:102:402::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.13; Thu, 15 Oct
 2026 13:52:55 +0000
Received: from ZR6PR09MB889505.eurprd09.prod.outlook.com
 ([fe80::9006:1164:b51f:23a2]) by ZR6PR09MB889505.eurprd09.prod.outlook.com
 ([fe80::9006:1164:b51f:23a2%4]) with mapi id 15.21.0522.011; Thu, 15 Oct 2026
 13:52:55 +0000
Message-ID: <15394ce1-a191-4066-9c91-d69b84ea62b9@mobileye.com>
Date: Thu, 15 Oct 2026 16:52:51 +0300
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
 <9bb6f315-c668-4f90-9fee-920f115a3dcd@mobileye.com>
 <20261015095605.pIRkhzUR@linutronix.de>
Content-Language: en-US
From: Vladimir Kondratiev <Vladimir.Kondratiev@mobileye.com>
In-Reply-To: <20261015095605.pIRkhzUR@linutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TL2P290CA0030.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:3::16) To ZR6PR09MB889505.eurprd09.prod.outlook.com
 (2603:10a6:910:e0::22)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZR6PR09MB889505:EE_|PA2PR09MB7345:EE_
X-MS-Office365-Filtering-Correlation-Id: 33045c04-03a3-4006-192e-08df2ac39d08
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|23010399003|6133799003|22082099003|18002099003|10067099003|3023799007|11063799006|4143699003|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	c95Nrv9jJ7HSJEvW3P3JIBjX/S4bKxvaXoSfFaF2Fn7sATsh7t8AyD6BdfwDHazO08utZozukc2QJEPBhrCS1NikzoFixXrFpVGYxaFhBdUvBRfCViyznKdgPP5kZu1vMxFOiOTh9ujXY2h2fYt723IgqiEjLfuTcV00Y761lGnwVye6OF0DE1zI5RW/BorjTjWmq3bE7vFW57PyTjnYGl/yQ1oHtrfam+kC8nFNK6hN6YfIXy3igFwD8ksVYGpVnowY0skbSWOLVNliSYlwB9jAtgFArXeqgpwXNyBtEyQcsEmi2nyprxZNzreH9QyjDcx/M2hInVTluznqh3V/swvmWkVxzohb3d8gmdGmMsNitlhFZ0/vOhig6vwn2QawaW/L3U4gfXJ/JitiIae7kQCrumj5oIuwNDgulcc/2As6EHiB+olDS0NrpZBV27yslHsRC5RiywkdoqyNmw2FfEx1rCxou8/UxETKeDvce/bCU7chxhDGV8YfO6eJHnodv766bBr5KyXKsMDsvZraYNmKGEO0D03AEMzrpXVNFDlZCo7LpPAiKGtIikTQtV346CTxhhDobW4A+VvtK+5ohdXQyyyx8UuismASg2Xhx+ih1dY5cxxU6+OomKlTS8PvipMyi7LEcNflHEFkU1tnc8cg4vdTHkwK40QHf/Cs6xg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZR6PR09MB889505.eurprd09.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(23010399003)(6133799003)(22082099003)(18002099003)(10067099003)(3023799007)(11063799006)(4143699003)(261009223027099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZUxwMWxIeFByQWJ2M29LMkZDS1hwcWVZaHhGdzR2c3dSd3ZrWXo2WnVVOFlr?=
 =?utf-8?B?cnlJQmdWaUNPZzJ1YmNvUDN4WVVscFNPYlJmcml4TlUxU2NDb2QxYjhHLzMv?=
 =?utf-8?B?cHFkUHM1SnFlOFhSWXdxbUFucHh5VUJvSmoxSFJtU2NFOWpiR251SWNqMGl2?=
 =?utf-8?B?SmJPUStSSnUyVkhJaGtYNDdYaVVwQ2tYTDF5SVpiVmIvNitkWXMvYTUydXE0?=
 =?utf-8?B?L3Zlc0xKTU43RkhrVWdxUjBYU1hReGtadzIvOEdja3hVSS9xNWZ5Z0Z6UHg0?=
 =?utf-8?B?YWlPT20xa1ViNXlCZWk2YXpzbUJZbzJxQlJvWUpRTzJxQ3NvbGVDYUtIeEU0?=
 =?utf-8?B?b3lST1dnV1FEVWpkUGpWenYxcEQwenVuajlUWncyd2xRK0xWNFhXU0ZmckEv?=
 =?utf-8?B?aDNuZ3QrUjdKTjdHcm1UaGNmTHEzQUdWbUhrdDFpNm4zWURBdlpGSFZFcEtT?=
 =?utf-8?B?aWo4UDZneTEwdmNjQno1L0tYUG1MWXhNY0JRdkdGS1ZDSDNlQlAzNzVaSGwv?=
 =?utf-8?B?ZkE2WVRES1VDZ1ZqNThzNkdYNVJqMEhUa2FIcG9tYWt4SElKT0doMDdHTDZO?=
 =?utf-8?B?ZEhTUGhESHVNOHo2UVgzK0FwWUlHci8rVk15Q3YxNFNQa0FQNkpmWU12aE1T?=
 =?utf-8?B?OTZNY3l2THVlUjNwcDRybVhUVXM0Z0Z1Umh0MlZpZndQS2JWMDY2cmJ0cTdz?=
 =?utf-8?B?Zkx5Y2FFQU9CaHdYWm1QWGhiZ1gwNlFzekRNdXo1Rk5zcVNDaUZqU1pjZngr?=
 =?utf-8?B?MTZOSDlBMWh3SUUvZUhUWUtHYjBjUVpyQlB2TGRGUjNnZXpETkVFU1psZ21j?=
 =?utf-8?B?Sjh3R3JCWFUyQURvU0NrTkRoNkszWEptWGNZQmh4bWlxZ1JIbnN2anB6ZEYr?=
 =?utf-8?B?RXRtWmJnL3lSU3pFazZ5endNV3V3ZkEwRExGTXNpdTdBVTFjTDZwN0FIeVJB?=
 =?utf-8?B?K0V1WlBaNUVHSnJKOHZ4R0VKMzBXNnh4UHViaE9EL3RNalNET3NVN2NPM0Zk?=
 =?utf-8?B?UUlpRms5YXJIbXdYdXBtK1d6WGMrcG5rSjNXZjdrSGZ3SUZNNnNzcnphR3Fr?=
 =?utf-8?B?eUIyMlFCenQ2Z0k0Y0IrV1E3Y2VHUnF2SzUyaTY4M2tRb0lmbCsrWGFLYklL?=
 =?utf-8?B?WWx3MG02Wnh2ZEJlSVdJNnV6NFQzMWlxcjZLNW4vWUdQcnY0SFdnSGt2NnZE?=
 =?utf-8?B?T2hzZ3F5aldub2czM0JSQWpIWkJRdVIzU00yUGp4NmFRSnlTT3BUMHJ3R1Zl?=
 =?utf-8?B?OXpCQ0JtS2JlenJBb2tOVzJHeEllNElRZ3B4VHIzNlh0elNST3BCTjE3YjNP?=
 =?utf-8?B?a1JCQlZTVHdnTTFmRmpjNFlHRGoweUlQZkw0ZGsyWnd0UjFwT1NrVGQrUWR5?=
 =?utf-8?B?d3JuckY2bCtHWi9MZzdFWWV6NU5lR2t3R0drQWRvN2pwWEZwRWdySW5NU2JQ?=
 =?utf-8?B?allVWk5McFRQc0VwZnZkMThBRXRCT0tsTEFVWDRtU2s5eGdKcW1CZGV5MUZr?=
 =?utf-8?B?cVZkZVVUOU51TmpJaG1XbFZSejZxWk00eWFaU3ljekw4eTB1OHJvWFM3cXVm?=
 =?utf-8?B?WFpYZnJMazhKUU9hRHBiY3FVY09DMWZmZGpIVi9TSm9nZ0RPa2NLYTIvL1BN?=
 =?utf-8?B?czZJZ2QybSs5VHNtOG9HclJocHFkS2o4REhIOWR1NDUwWXE4Rm14QnE4Vy9M?=
 =?utf-8?B?c25HK0g5bEpQVmtHVnVqNUlRM3JOK3dCWk9nYWlETjRMak1HbDhFaEtEd2da?=
 =?utf-8?B?bit2M3pzWnFkYWVhT09yWDVieGRXeWlnbTkwQUQ1WXFsYU42OWJPN2lLbHgz?=
 =?utf-8?B?aG5La2NrK28rSkF3blg4eFhFejVLVlFPcWpab0VWTzR2SG1IUEVwQVRyV3Zw?=
 =?utf-8?B?MmJnb2FYeWNjclI1ZThudnZuSzRqQ3daUjZyaDhpQUYvbi90S2pwNTVTWEhQ?=
 =?utf-8?B?aFR2Q2J4QWV5TndCNmErWnByS0Q0eGdyMUc1WWhRODF4WUhPaGN3dTdRM0lK?=
 =?utf-8?B?YVNKNGtyOTNJS3N0b3FnaVg1UER2TU1vZkpTYlVCclZycG9JblZEeVVJSTVT?=
 =?utf-8?B?a2dSYktnTkh5d3ZKVGhWdE8vMC9zL0ZTc0VYN1RWZWpFVnYzQXN6NHBIUW1D?=
 =?utf-8?B?TkJMaWJPQ3VnWFM4MzcxRXQ3MVJsb1czUFcyRDVHTkJXaE1wcWIwOWZwV3Bm?=
 =?utf-8?B?N1FSSnY5bi9oakNQYkN3ZXppM3llUTFYYU10ankzTDk1NFRPRjY2bmM4YnFY?=
 =?utf-8?B?VmtLSEp6VTl6UGdXUHVNbSsraTEySFFiVGFRZXB6eDliUFMxWEJQbkRyWTFR?=
 =?utf-8?B?S1oyd2hSOVhwSmZuQVhpOUVDYWJkUzBzbVdid0xZRVJzR204d25Bdz09?=
X-OriginatorOrg: mobileye.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33045c04-03a3-4006-192e-08df2ac39d08
X-MS-Exchange-CrossTenant-AuthSource: ZR6PR09MB889505.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2026 13:52:55.2607
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f85ba13-6953-46a6-9c5b-7599fd80e9aa
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w/CLHM81jlfUM5dR0GoLJEvvsoHkXHVniykj68Y8UByJJdeVwB/x95q2VGU9SRWjhSUGuHr2waAhRXR5sNuInQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR09MB7345

On 10/15/26 12:56, Sebastian Andrzej Siewior wrote:
> EXTERNAL EMAIL: Do not click any links or open any attachments unless you trust the sender and know the content is safe.
> 
> On 2026-10-15 11:11:24 [+0300], Vladimir Kondratiev wrote:
>> On 10/15/26 09:32, Sebastian Andrzej Siewior wrote:
>>> The driver providing MSI capabilities (the MSI domain for this device)
>>> must a module. This is the requirement so that _this_ driver returns
>>> EPROBE_DEFER and *then* once the MSI domain driver is loaded as a module
>>> (after boot) this driver is probed again and succeeds.
>> Why module? for "riscv-aplic", "msi-parent" shall be "riscv-imsic" and
>> it is "builtin_platform_driver", see
>> drivers/irqchip/irq-riscv-imsic-platform.c
> 
> But _how_ do you want to make deferred probing happen that will change
> aplic_syscore_registered after init without using modules?
> 

This is how. I provide a counter-example. To model supplier that will
not be satisfied I added fake "clocks". I know there's no "clocks" in
the aplic bindings, this is simply to model supplier that takes long
time. In the real life it should be the msi-parent that takes forever to
probe.

DTS modified like this, it has 3 aplic_m/aplic_s pairs, I show here only
modifications:

/ {
	soc {
		aplic_late_supplier: aplic-late-supplier {
			compatible = "test,aplic-late-supplier";
			#clock-cells = <0>;
		};
	};
};
&aplic_s0 { clocks = <&aplic_late_supplier>; };
&aplic_s1 { clocks = <&aplic_late_supplier>; };
&aplic_s2 { clocks = <&aplic_late_supplier>; };
&aplic_m0 { clocks = <&aplic_late_supplier>; };
&aplic_m1 { clocks = <&aplic_late_supplier>; };
&aplic_m2 { clocks = <&aplic_late_supplier>; };

It fails on boot, real test with QEMU:

[    1.940204] Freeing unused kernel image (initmem) memory: 2328K
[    1.940774] Run /init as init process
[   10.874635] riscv-aplic 48760000.interrupt-controller: 257 interrupts
directly connected to 8 CPUs
[   10.874892] Unable to handle kernel paging request at virtual address
ffffffff80e04fc4
[   10.875059] [ffffffff80e04fc4] pgd=000000023fffe801,
p4d=000000023fffe801, pud=000000023fffe801, pmd=00000002004000e3
[   10.875407] Oops [#1]
[   10.875806] Workqueue: events_unbound deferred_probe_work_func
[   10.875961] epc : aplic_probe+0xd8/0xfa
[   10.876153] status: 0000000200000120 badaddr: ffffffff80e04fc4 cause:
000000000000000f
[   10.876210] [<ffffffff804ca134>] aplic_probe+0xd8/0xfa
[   10.876252] [<ffffffff80559b4e>] platform_probe+0x3e/0x7a
[   10.876262] [<ffffffff8055733a>] really_probe+0x88/0x35c
...
[   10.876349] [<ffffffff80556f9a>] deferred_probe_work_func+0x92/0xfe
[   10.876360] [<ffffffff800448aa>] process_one_work+0x150/0x3d4

cause: 0xf is a store page fault; the PMD 0x...e3 has V|R|X|A|D but not
W, i.e. the rodata mapping after mark_rodata_ro(). The faulting
instruction is the store from aplic_syscore_init() (inlined into
aplic_probe):

ffffffff804ca12a:	jal	ffffffff80558216 <register_syscore>
ffffffff804ca12e:	li	a5,1
ffffffff804ca130:	auipc	a4,0x93b
ffffffff804ca134:	sb	a5,-364(a4) # ffffffff80e04fc4
<aplic_syscore_registered>
