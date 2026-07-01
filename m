Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012031.outbound.protection.outlook.com [40.107.209.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E49003BCD29
	for <linux-rt-devel@lists.linux.dev>; Wed,  1 Jul 2026 20:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782937140; cv=fail; b=WPnAEoxCtRIdcDI78+iAfnOtwc+tdJD16ut/Bdt15UNydql3ssPQ6LhBYk4HO+fSUK/rYh2obRHn8al4geX8gKbJ21SLgD4AqGIxr7Lq6aBm6Q4eG68f3WedDXaIJj7WPAUhblYMLbme8q1EelCfAPqE4+CnVUSUzQTBkrUJCXQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782937140; c=relaxed/simple;
	bh=TsLTskPnAp5DsDeVDDsOrIBAR3JizEBbNe4I9YcLhtk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=leYSS73il8ca43n/NnYt5NQ3doZlzlC+HJJoStXDp9tbDPEw1i9ehTaMfaRXaM30+9b+RGIJQHGcL4gvSlRJNPPnRUOPzHLy0Hp/7EmW8eYG3GtCCXzI3KwkfvntHtGv8Vy3L3wbTjseFcVNaS0ef811UIpLE8EhQoedA7gjIcg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=VFalMJCl; arc=fail smtp.client-ip=40.107.209.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="VFalMJCl"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PcFmjiRfOgXvy+bLpiHq2ONIFcnExmlTd+mWjZaGlgbeRLCQtSYspgPrCv4CaqioSFZjom94w0kkp/JJtnF+uIjKDfEeob9H4C8LFUo0flnC1+nTa59NVL1THpCHLhqLeuO/wWDN9IjW73CWoJOEp057XrDkulRtGXSU25b7sFwWE175INogGntnDppW3xU1w9+kLmg69lVA4/ALc7GEdFbMiWn91tLtqHdbAiVqdPI+9u8tufmFd9Y1jrCQh8eZXCDDCgH3QE3thaMBDHx4D/pvw4cth/ACoH1HHrOyo0kEpS0B2V6Vu8c8mkV3yhhXFFEl25zM7t/233ax7ST2qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Iav5KfsSoTnoiKe8D9uSv4ieJOH+QIbJ4UMhgpxhpCA=;
 b=nCfd7nTwsuyFETwJRqSQuoz2u1aoTx4ngWfGL2YXIy4rTP7bAjJvKg/Zd+2tDPyVLuMZo/nKNC3Hr1V6+UvJ30ArVzwx1V/IqJUePvEDskogyuRa5K4Dx2ZfMfifiNXS3/Bl0JkpXrX2r1x4P7jeYoxzGabLydcx54w/XyF4Yr1ezsS3lUAmHHCEmh6Kr9mXOILGZ/rKkzeM2k8KUe27bRbc0HYBPkhX71rS9l8HiLyXLQwELsQXTNCR4jeDc6ZfPbCjZF6LFLMKCGrtabxXe3KAxQviPaxui4N8DC9RPqlSTnIbWKJSeJ8WRI5IdMRcofflETT7Oiv/thTqTq9feA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Iav5KfsSoTnoiKe8D9uSv4ieJOH+QIbJ4UMhgpxhpCA=;
 b=VFalMJClxww6f5mmdOYZdLA8+xa84ARn6qBeFoi3lXHRS6QyctPjlZr3yfdlIK6zsg6y/I4GFC7YLXKdzhdRnza/LEbbTYPumqUOz3yPkN45J73nqWihZTVVj4z/mub4vn1xsFEFEOACiUzfNsh8bW12V6KmUjBnnT9EKef3HsvHmRZDaqfoPNIDVyAEOeBoGop+ZUFA0W58zylDOsJuAPoPdBUN6fqvxVWafStEgMpjUqoZIMAtllUH2OXNOjInDGSI2dCEnOqoP9NjVMeGRqSmmirsyRLrm1770ygjzGnFU10T4uDhoDa3J1EvFh4y53qBT1sPsYimLHpcaFfcHg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM4PR12MB5230.namprd12.prod.outlook.com (2603:10b6:5:399::11)
 by DM4PR12MB5843.namprd12.prod.outlook.com (2603:10b6:8:66::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Wed, 1 Jul 2026
 20:18:44 +0000
Received: from DM4PR12MB5230.namprd12.prod.outlook.com
 ([fe80::6e87:1bde:1853:3b73]) by DM4PR12MB5230.namprd12.prod.outlook.com
 ([fe80::6e87:1bde:1853:3b73%4]) with mapi id 15.21.0181.008; Wed, 1 Jul 2026
 20:18:44 +0000
Message-ID: <473da771-b711-457b-b9ad-491fee111b16@nvidia.com>
Date: Wed, 1 Jul 2026 13:18:41 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 5/8] riscv_cbqri: resctrl: Add cache allocation via
 capacity block mask
To: Drew Fustini <fustini@kernel.org>,
 Adrien Ricciardi <aricciardi@baylibre.com>, Alexandre Ghiti <alex@ghiti.fr>,
 Atish Kumar Patra <atishp@rivosinc.com>, Atish Patra
 <atish.patra@linux.dev>, Babu Moger <babu.moger@amd.com>,
 Ben Horgan <ben.horgan@arm.com>, Borislav Petkov <bp@alien8.de>,
 Chen Pei <cp0613@linux.alibaba.com>,
 Conor Dooley <conor.dooley@microchip.com>, Conor Dooley
 <conor+dt@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>,
 Dave Martin <Dave.Martin@arm.com>, Gong Shuai <gong.shuai@sanechips.com.cn>,
 Gong Shuai <gsh517@gmail.com>, guo.wenjia23@zte.com.cn,
 James Morse <james.morse@arm.com>, =?UTF-8?Q?Kornel_Dul=C4=99ba?=
 <mindal@semihalf.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 liu.qingtao2@zte.com.cn, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <pjw@kernel.org>,
 Peter Newman <peternewman@google.com>,
 =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@ventanamicro.com>,
 Reinette Chatre <reinette.chatre@intel.com>, Rob Herring <robh@kernel.org>,
 Samuel Holland <samuel.holland@sifive.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Tony Luck <tony.luck@intel.com>, Vasudevan Srinivasan <vasu@rivosinc.com>,
 Ved Shanbhogue <ved@rivosinc.com>, Weiwei Li <liwei1518@gmail.com>,
 yunhui cui <cuiyunhui@bytedance.com>
Cc: linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
 x86@kernel.org, devicetree@vger.kernel.org, linux-rt-devel@lists.linux.dev,
 linux-doc@vger.kernel.org
References: <20260628-dfustini-atl-sc-cbqri-dt-v3-0-c9c1342fe3cf@kernel.org>
 <20260628-dfustini-atl-sc-cbqri-dt-v3-5-c9c1342fe3cf@kernel.org>
Content-Language: en-US
From: Fenghua Yu <fenghuay@nvidia.com>
In-Reply-To: <20260628-dfustini-atl-sc-cbqri-dt-v3-5-c9c1342fe3cf@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY3PR05CA0045.namprd05.prod.outlook.com
 (2603:10b6:a03:39b::20) To DM4PR12MB5230.namprd12.prod.outlook.com
 (2603:10b6:5:399::11)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5230:EE_|DM4PR12MB5843:EE_
X-MS-Office365-Filtering-Correlation-Id: f1c83a16-a775-458f-83ff-08ded7adf336
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|376014|1800799024|7416014|3023799007|6133799003|11063799006|5023799004|56012099006|4143699003|18002099003|921020|22082099003;
X-Microsoft-Antispam-Message-Info:
	WJvaladdMkWROHMtbvpXxYXhW988f/RP2TE1c0ujUst/TmxEhHjBQMtZPngjx2wVJQnMqWXgHMKlWwm1np4kcmevg/QG6RuaKi4lBgf5tNan8Puy9Zkzse+nnyZPD+LqlYaLsKZ6BGqKfo9sHlRqowzn3ORjf+Q2GpXFRClo7bTPzjV4NBP4NfrbW7GIiz+htaZE+hm2iaUM9gIXe33CQ1uH8CfUJO1PLmpwzYCZBwCW1E8jdlr+pzXqMelBtJZpv0W5m8rl0nRv56/kVqVm26JdhWrMDnhRZglg3l3q54980h4fV3Z7YuNPOoRtKQ6HUNr5yi5wDJyZsVsneNzrMfR3Qh6R0skBNBC+2lUogJeL49EA8Icn/FZq1TXH3NLGB8zN6oWmYucIKSeoQeY9GEtas9Ks/+QrZ0BNCu7UHkAT12FmHwHW/5mr4Ipk/CcFy3YnoYR29p+YPxPLyWI4HJ0U8Whi0k70dZd+1XzCaVC2GtaxXWsfR6fsiZd95Z3JC7StILCjsme+qzghI2Wf+QIrTzudS2ZL8qD28Z2uFzJZM2A4sjGt4V98Db7YlKjEJ5KojUrZj5CxSyjLtONjCrE4PoRpAJhykvLq1f1qPN5WeZPued4b30x9JT9Wx8f0kUJ1JhMs5d1oGA1Rh6ZN2zxdhH6B+zN12sK27ig1Ygo+Rbq2fgCJPbxU4K+UH+jQyYgLG3fium5HOUK+40Eaqg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5230.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(7416014)(3023799007)(6133799003)(11063799006)(5023799004)(56012099006)(4143699003)(18002099003)(921020)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RGF0MGJtM0FjU0NncndDWlY0bTFzalN4M3JtQUtXbjE4YlpNRlFpUUJIK1Bl?=
 =?utf-8?B?QnhzL2xZTVR2SG9FUVdqakpzeXFRSUE2TFJyU0laMG5DYWpLbHlnMmY2VklG?=
 =?utf-8?B?SDZKekwwaUx3QmNJL0xwT2FZd3F1K1ViS3E4UEsrTzdYZTVhUG5xZjk5L0hR?=
 =?utf-8?B?YlpXTmVNZHdoS2ZpcFJvTFZUWG9ueU8wMDRvRDN1ZnBrRElRTjFhYVZ3TUVZ?=
 =?utf-8?B?VnpHSE9CQUxWa3lkYmhkSVZpVklGWWFwcjd0K1VPOXdxMTJQSndhZ2V1d2wv?=
 =?utf-8?B?M2NMV1hQT25GalZ6RWM4VHNOeTFBbXFrOGZJSFltcmJXcjBHVlV3Smp6R3Ns?=
 =?utf-8?B?SFdaZ001blN1eG9HY3VNRTRYUnpNbXZ0cW96UUN1bnZlSlhBSVN4SUo5Wm9X?=
 =?utf-8?B?NUpCMEtSbGM4THI4bGlkRDQ1RndWbXA3VmdWeTBUcVBGY2trQTFjZ1QzR3Mz?=
 =?utf-8?B?bHBENjFISWx4SGh5cWR1bUNaOExNQ0wvWVgzdTlRYWN0NmpROGJFYm9vekNo?=
 =?utf-8?B?dXhQNFpvbHo0UW9WSXNtSkFBSXpOQ2pMQjZYbnhrYkRzMDFGVFNNZ3VxVS95?=
 =?utf-8?B?WE8zNjJ2QWZPYzJCS1huWXZtSlN3am5Td3hOdGlDUUU5MHNRdHlrdXJBckx4?=
 =?utf-8?B?V3A4anl1U2ZTSENPNFNPR1NHYU01Z0xkd3ErcVpxWWFLYWFZNjlXWi80T01y?=
 =?utf-8?B?Sm53cUtUMDd6ZG1TQnI3U2Uxc1ducVlCbE9OWklDTWJPNW4vYVFEMXoxQWNU?=
 =?utf-8?B?UDhyMldtU2tzYmNGeENhZi9wUHNkdDkzeW95UjM2cFlSdG5vdWZLaFExd0ZE?=
 =?utf-8?B?TnpjbUNYN0ppV0xkeUZ6TTJBSzdRVmlJS096NmFkUWFnSjVrQ055OHkxS0wv?=
 =?utf-8?B?VEVRV0R2NjhDSFJDd1cwUEtMaElCczUvcmFCQ3E1ZU9LUlB6cEc4MVdGNWpk?=
 =?utf-8?B?b21UT3BaWDJ0dXBDZGVVS2pabUtLbDltd2RyVzFiYUhrb1lMeGY4QldIYzJN?=
 =?utf-8?B?WlhGZktuRlVtQVoveHdDWUQ3TW9HQm9KYlBwR0dFNWhOdE5QQWxmSWk3QnBY?=
 =?utf-8?B?aXlSeUh6Qmcwdm1jaC9XQWUyYmVJeU5pQ3VjQ2ljaXpMMWlNa1VYTXh6dnRw?=
 =?utf-8?B?cEtqWnRzTXZZL0hoOWpBMmpNeGhDQ0tiWTMzRjFtaWZCN3oveXNOL0Jsb3dB?=
 =?utf-8?B?L2pVeVFMNWhmcDFzZFBSeTE1eks0Q2dyNEdJVkdzUXVnZGRVVmkvYitUdlhG?=
 =?utf-8?B?R2ZtZmY2V09YK3JsOUJzL3Z5NTFxcXZoU1lwSkRlbEJSUVFFMkZIQTBIc0p1?=
 =?utf-8?B?QStYNjN2a3QvSmdJYVhWS1E5SUZGVkFYcWp2L2NKZCt5ZG42YTg5OGhiemZ3?=
 =?utf-8?B?RmlvM2N2WnZtRGxTL0g2OTRjRDQwS3NTbWlVMFpJVnJjbGk0elZHWWkrb3Fl?=
 =?utf-8?B?R0dzVzFFNmRxUERqNTVUakVUNzNmTnpTQ0NMWG5QdWg2Ym82RDRoMnlsRm1F?=
 =?utf-8?B?ZjZjRnBmNm50bVlCd3hzZXgwTTNESkR4OVpIQklkeU1ucTVBbWo5MmpLSllQ?=
 =?utf-8?B?Qm1yRE5BWUMzOEp6M0hqMTlCYzVhaGQ0SjNyWGF6OXZrZFAyNUgrWEU4THla?=
 =?utf-8?B?dGN2cW1uNi9xWnQvQmY3ZjQ5NjhodTgrZm5CZ0xVbjVJUWI3U0FoOEhCV011?=
 =?utf-8?B?N2VNVmg0UXpsNllTWHk2U1ZFNWhsUE5VQnNUb1cySW5RZnd2dDl5eVJVbm9j?=
 =?utf-8?B?dUF5cFkySFBRSVpCUS94bDN5SHBFZll5SXNaeXJSUWFPUkRIcUMwc2gramM1?=
 =?utf-8?B?dURUWmZoMi9qTWlSeUtONlA3bDdOcVdoVlQrOVVmclZjanFKMGo0bVNxTzJ1?=
 =?utf-8?B?bCt5YkIvanJEanVQNTBZMHNDWlBWT1VKb2syQjAvanplODNTcWhaOHE1V3ZZ?=
 =?utf-8?B?c1NuTnB4ZmI2V1YwZGNoekY4VVJXVEo2elZqQVNvSzdYOW53R3UzM21teTdy?=
 =?utf-8?B?UWdORXY4ZTl6QzA0aFV4aVZmZWpmSFU1YWZXUVExVU9paVFmSTZ1Z1hNUkZ4?=
 =?utf-8?B?dEYvdElsc3lWWUFULy9YN1prRUFXTnNRUGhYVEtrNkJLOHNIVVBQUWdYODJT?=
 =?utf-8?B?dndMcnBoMGVLZEVHZThqYUZBV2k2UTNrWkF1L1U4RDZsT2lOUVMyMWQ4TnFX?=
 =?utf-8?B?WUVhbGl2dFlYc05WYVBtS2h1S0F2Z2o0VUFvODQzQUtXZDQvelFVUkhIejdr?=
 =?utf-8?B?cGpjWWpvL3JGeE1xVHBGWDZYWEk0MllHb29PYi9PRHlxekk1djNnYVJ2akQy?=
 =?utf-8?B?MWYyRWYwUTlpMWQ4MFYrSWNtbU1uZEpoTjQwTGpKcTZGV016Rmxadz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1c83a16-a775-458f-83ff-08ded7adf336
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5230.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2026 20:18:44.4515
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2u0RbY+cPLJk5TjJcfuv6QG17jTQByQc1wrSgjjWgh3x8+HY4AZ5pPHJsh6/SK/wFCO14S/R3P7+INUQsVuMbg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5843

Hi, Drew,

Could you please change my email address to my NVIDIA email 
fenghuay@nvidia.com?

On 6/28/26 14:18, Drew Fustini wrote:
> Wire CBQRI capacity controllers into resctrl as RDT_RESOURCE_L2 and
> RDT_RESOURCE_L3 schemata.
> 
> Mismatched CC caps at the same cache level are treated as a fatal
> configuration error since fs/resctrl exposes a single per-rid cap
> set. Domains are created lazily in the cpuhp online callback so
> cpu_mask reflects only currently online CPUs.
> 
> Assisted-by: Claude:claude-opus-4-7
> Co-developed-by: Adrien Ricciardi <aricciardi@baylibre.com>
> Signed-off-by: Adrien Ricciardi <aricciardi@baylibre.com>
> Signed-off-by: Drew Fustini <fustini@kernel.org>
> ---
>   MAINTAINERS                      |   2 +
>   arch/riscv/include/asm/resctrl.h | 147 ++++++++
>   drivers/resctrl/Kconfig          |   4 +
>   drivers/resctrl/Makefile         |   1 +
>   drivers/resctrl/cbqri_resctrl.c  | 787 +++++++++++++++++++++++++++++++++++++++
>   5 files changed, 941 insertions(+)
> 
[SNIP]

> diff --git a/drivers/resctrl/cbqri_resctrl.c b/drivers/resctrl/cbqri_resctrl.c
> new file mode 100644
> index 000000000000..1fb0fbe1b000
> --- /dev/null
> +++ b/drivers/resctrl/cbqri_resctrl.c
[SNIP]

> +/*
> + * Walk cbqri_controllers and pick one capacity controller (CC) per cache
> + * level (L2/L3) to back the corresponding RDT_RESOURCE_L*. When more than
> + * one CC sits at the same level (e.g. one per socket), they must agree on
> + * rcid_count / ncblks / alloc_capable. A mismatch is fatal because resctrl
> + * exposes a single set of caps per rid. The first matching controller wins.
> + */
> +static int cbqri_resctrl_pick_caches(void)
> +{
> +	struct cbqri_controller *ctrl;
> +	int ret = 0;
> +
> +	mutex_lock(&cbqri_controllers_lock);

Is it better to change mutex_lock()/mutex_unlock() to
  guard(mutex)(&cbqri_controllers_lock)?

1. This code is simpler and can avoid potential missing unlock issue.
2. This matches mpam code.

> +
> +	list_for_each_entry(ctrl, &cbqri_controllers, list) {
> +		struct cbqri_resctrl_res *cbqri_res;
> +		int rid;
> +
> +		if (ctrl->type != CBQRI_CONTROLLER_TYPE_CAPACITY)
> +			continue;
> +		if (!ctrl->alloc_capable)
> +			continue;
> +
> +		rid = cbqri_cache_level_to_rid(ctrl->cache.cache_level);
> +		if (rid < 0) {
> +			pr_info("skipping controller at unsupported cache level %u\n",
> +				ctrl->cache.cache_level);
> +			continue;
> +		}
> +
> +		cbqri_res = &cbqri_resctrl_resources[rid];
> +		if (cbqri_res->ctrl) {
> +			/*
> +			 * CCs at the same cache level must agree on every cap
> +			 * resctrl exposes globally. Reject mismatches at pick
> +			 * time so the inconsistency is visible at boot.
> +			 */
> +			if (cbqri_res->ctrl->rcid_count != ctrl->rcid_count ||
> +			    cbqri_res->ctrl->cc.ncblks != ctrl->cc.ncblks ||
> +			    cbqri_res->ctrl->cc.supports_alloc_at_code !=
> +				    ctrl->cc.supports_alloc_at_code ||
> +			    cbqri_res->ctrl->alloc_capable != ctrl->alloc_capable) {
> +				pr_err("L%d controllers have mismatched capabilities\n",
> +				       ctrl->cache.cache_level);
> +				ret = -EINVAL;
> +				break;

Is it possible to support cbqri on both L2 and L3 on the same machine?
Failure on one controller will stop picking another other controller here.

If both L2 and L3 can be supported on the same machine, does it make 
sense to pr_err() (fatal for this controller) and continue to go to the 
next controller? So failure on L2 won't impact L3?

If that's the case, does it make sense not to return error for 
pick_caches()? So pick_caches() failure is not fatal?

> +			}
> +			continue;
> +		}
> +
> +		cbqri_res->ctrl = ctrl;
> +	}
> +
> +	mutex_unlock(&cbqri_controllers_lock);
> +	return ret;
> +}
> +
> +/*
> + * Fill the rdt_resource fields for one picked rid. An rid with no picked
> + * controller is left untouched so it stays out of resctrl_arch_get_resource().
> + */
> +static void cbqri_resctrl_control_init(struct cbqri_resctrl_res *cbqri_res)
> +{
> +	struct cbqri_controller *ctrl = cbqri_res->ctrl;
> +	struct rdt_resource *res = &cbqri_res->resctrl_res;
> +
> +	if (!ctrl)
> +		return;
> +
> +	switch (res->rid) {
> +	case RDT_RESOURCE_L2:
> +	case RDT_RESOURCE_L3:
> +		res->name = (res->rid == RDT_RESOURCE_L2) ? "L2" : "L3";
> +		res->schema_fmt = RESCTRL_SCHEMA_BITMAP;
> +		res->ctrl_scope = (res->rid == RDT_RESOURCE_L2) ?
> +				    RESCTRL_L2_CACHE : RESCTRL_L3_CACHE;
> +		res->cache.cbm_len = ctrl->cc.ncblks;
> +		res->cache.shareable_bits = 0;
> +		res->cache.min_cbm_bits = 1;
> +		res->cache.arch_has_sparse_bitmasks = false;
> +		res->cdp_capable = ctrl->cc.supports_alloc_at_code;
> +		res->alloc_capable = ctrl->alloc_capable;
> +		INIT_LIST_HEAD(&res->ctrl_domains);
> +		INIT_LIST_HEAD(&res->mon_domains);
> +		break;
> +	default:
> +		break;
> +	}
> +}
> +
> +static void cbqri_resctrl_accumulate_caps(void)
> +{
> +	int rid;
> +
> +	for (rid = 0; rid < RDT_NUM_RESOURCES; rid++) {
> +		struct cbqri_resctrl_res *hw_res = &cbqri_resctrl_resources[rid];
> +
> +		if (!hw_res->ctrl)
> +			continue;
> +		if (hw_res->ctrl->alloc_capable)
> +			exposed_alloc_capable = true;
> +	}
> +}
> +
> +/*
> + * Create, list-insert, and online a fresh ctrl_domain backing ctrl on
> + * resource res, seeded with cpu and identified by dom_id. Caller must
> + * hold cbqri_domain_list_lock and must have already verified that no
> + * existing ctrl_domain on res carries this id.
> + */
> +static struct rdt_ctrl_domain *cbqri_create_ctrl_domain(struct cbqri_controller *ctrl,
> +							struct rdt_resource *res,
> +							unsigned int cpu, int dom_id)
> +{
> +	struct rdt_ctrl_domain *domain;
> +	struct list_head *pos = NULL;
> +	int err;
> +
> +	domain = cbqri_new_domain(ctrl);
> +	if (!domain)
> +		return ERR_PTR(-ENOMEM);
> +
> +	cpumask_set_cpu(cpu, &domain->hdr.cpu_mask);
> +	domain->hdr.id = dom_id;
> +	domain->hdr.type = RESCTRL_CTRL_DOMAIN;
> +
> +	err = cbqri_init_domain_ctrlval(res, domain);
> +	if (err) {
> +		kfree(container_of(domain, struct cbqri_resctrl_dom,
> +				   resctrl_ctrl_dom));
> +		return ERR_PTR(err);
> +	}
> +
> +	/* Insert sorted by id so user-visible ordering is deterministic. */
> +	resctrl_find_domain(&res->ctrl_domains, dom_id, &pos);
> +	list_add_tail(&domain->hdr.list, pos);
> +
> +	resctrl_online_ctrl_domain(res, domain);
> +
> +	return domain;
> +}
> +
> +static int cbqri_attach_cpu_to_cap_ctrl(struct cbqri_controller *ctrl,
> +					unsigned int cpu)
> +{
> +	struct cbqri_resctrl_res *hw_res;
> +	struct rdt_ctrl_domain *domain;
> +	struct rdt_resource *res;
> +	int dom_id;
> +	int rid;
> +
> +	rid = cbqri_cache_level_to_rid(ctrl->cache.cache_level);
> +	if (rid < 0)
> +		return 0;
> +	hw_res = &cbqri_resctrl_resources[rid];
> +
> +	if (!hw_res->ctrl)
> +		return 0;
> +
> +	res = &hw_res->resctrl_res;
> +	dom_id = ctrl->cache.cache_id;
> +
> +	domain = cbqri_find_ctrl_domain(&res->ctrl_domains, dom_id);
> +	if (domain) {
> +		cpumask_set_cpu(cpu, &domain->hdr.cpu_mask);
> +		return 0;
> +	}
> +
> +	domain = cbqri_create_ctrl_domain(ctrl, res, cpu, dom_id);
> +	if (IS_ERR(domain))
> +		return PTR_ERR(domain);
> +
> +	return 0;
> +}
> +
> +static void cbqri_detach_cpu_from_ctrl_domains(struct rdt_resource *res,
> +					       unsigned int cpu)
> +{
> +	struct rdt_ctrl_domain *domain, *tmp;
> +
> +	list_for_each_entry_safe(domain, tmp, &res->ctrl_domains, hdr.list) {
> +		if (!cpumask_test_cpu(cpu, &domain->hdr.cpu_mask))
> +			continue;
> +		cpumask_clear_cpu(cpu, &domain->hdr.cpu_mask);
> +		if (cpumask_empty(&domain->hdr.cpu_mask)) {
> +			resctrl_offline_ctrl_domain(res, domain);
> +			list_del(&domain->hdr.list);
> +			kfree(container_of(domain, struct cbqri_resctrl_dom,
> +					   resctrl_ctrl_dom));
> +		}
> +	}
> +}
> +
> +/*
> + * Remove a CPU from every domain it was attached to. The per-resource
> + * detach helpers act only when the CPU is set in a domain's mask, so this
> + * is idempotent and undoes a partial online attach as well as a full
> + * offline. Caller holds cbqri_domain_list_lock.
> + */
> +static void cbqri_detach_cpu_from_all_ctrls(unsigned int cpu)
> +{
> +	int rid;
> +
> +	lockdep_assert_held(&cbqri_domain_list_lock);
> +
> +	for (rid = 0; rid < RDT_NUM_RESOURCES; rid++) {
> +		struct cbqri_resctrl_res *hw_res = &cbqri_resctrl_resources[rid];
> +
> +		if (!hw_res->ctrl)
> +			continue;
> +		cbqri_detach_cpu_from_ctrl_domains(&hw_res->resctrl_res, cpu);
> +	}
> +}
> +
> +/*
> + * Attach a CPU to every controller that claims it. On failure, detach the
> + * CPU from everything attached so far: the cpuhp core does not run this
> + * state's offline teardown when its startup fails, so a partial attach
> + * would otherwise leak into the domain cpu_masks. Caller holds
> + * cbqri_domain_list_lock.
> + */
> +static int cbqri_attach_cpu_to_all_ctrls(unsigned int cpu)
> +{
> +	struct cbqri_controller *ctrl;
> +	int err = 0;
> +
> +	lockdep_assert_held(&cbqri_domain_list_lock);
> +
> +	/*
> +	 * Hold cbqri_controllers_lock across the walk so a controller
> +	 * registered after boot cannot corrupt it. The register path takes
> +	 * it as a leaf and never cbqri_domain_list_lock, so this nesting
> +	 * cannot invert.
> +	 */
> +	mutex_lock(&cbqri_controllers_lock);

guard(mutex)(&cbqri_controllers_lock)?

> +	list_for_each_entry(ctrl, &cbqri_controllers, list) {
> +		if (ctrl->type != CBQRI_CONTROLLER_TYPE_CAPACITY)
> +			continue;
> +		if (!cpumask_test_cpu(cpu, &ctrl->cache.cpu_mask))
> +			continue;
> +		if (!ctrl->alloc_capable)
> +			continue;
> +
> +		err = cbqri_attach_cpu_to_cap_ctrl(ctrl, cpu);
> +		if (err) {
> +			cbqri_detach_cpu_from_all_ctrls(cpu);
> +			break;
> +		}
> +	}
> +	mutex_unlock(&cbqri_controllers_lock);
> +
> +	return err;
> +}
> +
> +static bool cbqri_resctrl_inited;
> +
> +static void cbqri_resctrl_teardown(void)
> +{
> +	int rid;
> +
> +	if (!cbqri_resctrl_inited)
> +		return;
> +
> +	resctrl_exit();
> +
> +	for (rid = 0; rid < RDT_NUM_RESOURCES; rid++) {
> +		struct cbqri_resctrl_res *hw_res = &cbqri_resctrl_resources[rid];
> +
> +		hw_res->ctrl = NULL;
> +		hw_res->cdp_enabled = false;
> +	}
> +	exposed_alloc_capable = false;
> +	cbqri_resctrl_inited = false;
> +}
> +
> +static int cbqri_resctrl_setup(void)
> +{
> +	int rid;
> +	int err;
> +
> +	for (rid = 0; rid < RDT_NUM_RESOURCES; rid++)
> +		cbqri_resctrl_resources[rid].resctrl_res.rid = rid;
> +
> +	err = cbqri_resctrl_pick_caches();
> +	if (err)
> +		return err;

Failure in pick_caches() will abort any future cbqri features e.g. 
memory bw allocation/monitoring. Is it possible to ignore the 
pick_caches() failure and continue to setup other cbqri features? Failed 
caches won't impact other QoS features, right?

> +
> +	for (rid = 0; rid < RDT_NUM_RESOURCES; rid++)
> +		cbqri_resctrl_control_init(&cbqri_resctrl_resources[rid]);
> +
> +	cbqri_resctrl_accumulate_caps();
> +
> +	if (!exposed_alloc_capable) {
> +		pr_debug("no resctrl-capable CBQRI controllers found\n");
> +		return -ENODEV;
> +	}
> +
> +	err = resctrl_init();
> +	if (err)
> +		return err;
> +
> +	cbqri_resctrl_inited = true;
> +	return 0;
> +}
> +
> +static int cbqri_resctrl_online_cpu(unsigned int cpu)
> +{
> +	int err;
> +
> +	mutex_lock(&cbqri_domain_list_lock);
> +	err = cbqri_attach_cpu_to_all_ctrls(cpu);
> +	mutex_unlock(&cbqri_domain_list_lock);
> +	if (err)
> +		return err;
> +
> +	/*
> +	 * Seed the per-CPU default RCID/MCID to the reserved (0, 0) pair and
> +	 * notify the resctrl core so it tracks this CPU in the default group.
> +	 */
> +	resctrl_arch_set_cpu_default_closid_rmid(cpu, 0, 0);
> +	resctrl_online_cpu(cpu);
> +	return 0;
> +}
> +
> +static int cbqri_resctrl_offline_cpu(unsigned int cpu)
> +{
> +	resctrl_offline_cpu(cpu);
> +
> +	mutex_lock(&cbqri_domain_list_lock);
> +	cbqri_detach_cpu_from_all_ctrls(cpu);
> +	mutex_unlock(&cbqri_domain_list_lock);
> +	return 0;
> +}
> +
> +static int __init cbqri_arch_late_init(void)
> +{
> +	int err;
> +
> +	if (!riscv_isa_extension_available(NULL, SSQOSID))
> +		return -ENODEV;
> +
> +	err = cbqri_resctrl_setup();
> +	if (err)
> +		return err;
> +
> +	err = cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "cbqri:online",
> +				cbqri_resctrl_online_cpu,
> +				cbqri_resctrl_offline_cpu);
> +	if (err < 0) {
> +		cbqri_resctrl_teardown();
> +		return err;
> +	}
> +
> +	return 0;
> +}
> +late_initcall(cbqri_arch_late_init);
> 

Thanks.

-Fenghua

