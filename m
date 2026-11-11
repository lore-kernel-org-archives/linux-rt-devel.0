Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.52.10
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794391262;
	b=g2Cq6vbl/PizAkK8FCd/mt0fLMW3XPAhW4+/ONiGluqR32VSxeuZskRVfImvfZ6UJ0sL
	 DU3ygnmyW2z1buvym+QjCjiCpto0vwxMLv17nGyO+gOuwuBUi6MYPzi5cjDqqZWXLo3fR
	 +gkb4D0NXpcwk2Kcwn6OFcTLXV/XDxOWpnO0oNrTD70F/yAwft8MVcKrcVBu1kHNrh037
	 /4AlH0jvkU8H0z1Ts4XxMxlPogoFcIbQmbKA9hjvfgj0O0u47R12Gv31ANsZNpNIZA5ey
	 vj1tMVrWiAonOYxYMfUkjjZaIhk+iqc6U+XKDvkTDSLj1S+6S8oohyEES/BoRWNt+7g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794391262;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Message-ID:Date:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-LD-Processed:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=4AHWSkS2lFACueb9zLscVLtkIk/hPUbbpFvzGBkQPgg=;
	b=AfjabWBQyq2PQadgRu8AXsCpzXvgz7WnwK0AbIR5prmRvnHUUUPoO6X8L+G7BrBy//ux
	 Gvx2h3ls5XmOLWFB8tVeoMKLGe5zaZ5Nf2/gcOcbsuzTq8tlmdm31zJ3Vpq4hfZ17Mceu
	 Cp5osG6tA5HePzYEeYODLbK0Bf3FqoEtX7DLnr41HXCLFxS0VZc8a1WnLAl3moa/ADKAJ
	 RQHd2RwDqjF0yLymj5mcKnqoZpO5yIJ6fSDu8bahnYPXg1G7RYhJNzy4pdsGytFVrqqsB
	 9Jt31GxKotaQkecOO8bup9QKCNzL6aT0zYUsA+MhTpuVMfL+y8ecGks5Xiz8bBF2CrA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=C6iIPJ+P;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.52.10
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011010.outbound.protection.outlook.com [52.101.52.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86FA760A2637
	for <linux-rt-devel@lists.linux.dev>; Wed, 11 Nov 2026 10:00:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 86FA760A2637
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=C6iIPJ+P
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v00eMOjVJNo4XIAkQ2JglFUr21RjOEOgsJmIBYzxGP/lnczVpaCLqFMmbVrIUij9BNUn2q0ROmU61pKgmYeAPGPBXlYD23Yb+ZEyzjAcAe2oBZn4Z609pWD58VbOFwe+Y5X/hukYOCkCx8AQCBeASjPkqcsuwoopLvBy0NcuAlCuObAiPcv75Gf6KrgV34St/yPXEZiYafJU4JzVznVMDqYVh0hpRVKXL1ZRzdEQNZKVIDpzyWhbAY58tZDURp6xsDibk5XG4AhrvZWnFf+CI0El5+C3b2gvx81SOji0v0xUwlZWuQTIaVlMCITc5qYShv9VvY2CMlvPhHpCOlqLug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4AHWSkS2lFACueb9zLscVLtkIk/hPUbbpFvzGBkQPgg=;
 b=mlEKzLeZbYD6o9XY6ndHB4LN/+TzjK2RPNe4rzfeRSglM5PA5Q56uhBHCfLJAqjDO3VUusViPRAht8QviPwDI6Pu5hAJZcIDyob+1TYHo5rXDqkAObRU1SVkKY5NuClAG4XDgD6b0VXrBNr/ApGR26qCQl1ywCnOhLQKfVc819deJLUPMN9COafiAduPqn0I+9sLx0TgWnz5mfPNlqVOmgO9CONR22aX/IEL2FjGnHOkEespmW3oRwlH2lFdqXhfXFRtyfCjfRMUqalnc3usU8/2dKjteMdRN3LphST4Te9QzeYeWD0v8PUnRPxIOgmgMpS+9sVwgC7rk00skhuNvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4AHWSkS2lFACueb9zLscVLtkIk/hPUbbpFvzGBkQPgg=;
 b=C6iIPJ+PD06z3btHA5soFoajFVmxqYI/aixoTfG6Q+cMiku2xj93EaAuAfXgMWQt9i+v7eJsl9mD8vuKaBnuk49uXuT57WeT/NmlpiA5STyPoVFimjEDzzttpiCbSI3dvL3D4+/dO0i8bKLvyZFBaHbnBYd6Mu/NyQeLpOlgirc=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SN7PR12MB8147.namprd12.prod.outlook.com (2603:10b6:806:32e::5)
 by DS7PR12MB6143.namprd12.prod.outlook.com (2603:10b6:8:99::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.13; Wed, 11 Nov
 2026 10:00:51 +0000
Received: from SN7PR12MB8147.namprd12.prod.outlook.com
 ([fe80::3923:c1a4:778b:56f2]) by SN7PR12MB8147.namprd12.prod.outlook.com
 ([fe80::3923:c1a4:778b:56f2%3]) with mapi id 15.21.0615.008; Wed, 11 Nov 2026
 10:00:51 +0000
Message-ID: <0193d8c8-5902-41fc-8469-1f9617a0098f@amd.com>
Date: Wed, 11 Nov 2026 15:30:41 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 7/8] net: xilinx: tsn: add the endpoint TX
 data path
To: netdev-bot+sashiko@kernel.org, srinivas.neeli@amd.com
Cc: nagadheeraj.rottela@amd.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, richardcochran@gmail.com, michal.simek@amd.com,
 bigeasy@linutronix.de, clrkwllms@kernel.org, rostedt@goodmis.org,
 edumazet@kernel.org, netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rt-devel@lists.linux.dev, neelisrinivas18@gmail.com, git@amd.com
References: <20261016-patches_v2_external-v3-7-e33d3960ca1e@amd.com>
 <179249750260.3135.7334440284014386144@kernel.org>
Content-Language: en-US
From: "Neeli, Srinivas" <srneeli@amd.com>
In-Reply-To: <179249750260.3135.7334440284014386144@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA5PR01CA0140.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1b9::9) To SN7PR12MB8147.namprd12.prod.outlook.com
 (2603:10b6:806:32e::5)
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Post: <mailto:linux-rt-devel@lists.linux.dev>
List-Help: <mailto:linux-rt-devel+help@lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
List-Owner: <mailto:linux-rt-devel+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8147:EE_|DS7PR12MB6143:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c44a99e-61e5-4eab-f4ba-08df3fdaaadb
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|7416014|366016|1800799024|18002099003|22082099003|6133799003|10067099003|5023799004|11063799006|261102123227099003|4143699003|261026121527099003|261021121427099003|261022075727099003|261021123027099003|261022105027099003|261026140227099003|56012099006|261009223027099003|261028144727099003;
X-Microsoft-Antispam-Message-Info:
	gTj45a89x1xtJdsmgSjLZZTWB02qzPWVxYiFHVEO07IROX4sgiQ+2U+uczeDLxu4CPe96HJQ0XD4wbDoDoEoR2lWD2Y55W7zXAMDwNDVXrGHaykCGznTVlLuU1Ju7f8Xp+Ohb11vjMjHWdwWxxh+gong9CRLnTO5MQ5kdfEOaIj/d5wgxRFXpxeVns1vgPKOiDAfCQIXYkxlfPR+W5s22/c7BhiAB/06ZzuMr5nynBpUtCzmZcEJYKtHH/WoCMLftY+/bpNghpWLQ8mqW2SEFE/WwrxIugbvMvYOXscMdIZJcHJITeOJGmJpvAYeKCa4ta4grLjHZuTDyNmrCkNI/tyoehWqOaJuekSA+J3wwwhulYx3mJZ58nWSBv1yqBpuITO1yQQgF68GuSpluNHNhsh9b4SiewJ+VZXPxJh8GBXTWZcMV2D17SaQswwkAOSq6SCTOxyzHNbzxh8nTeh1Qt3i0OWanyg53xEol+AESCB1nRwF8PGxflyiEAOtLR3x711Xq2IB4hEyZM/eSClCXJ3mPgFkV2ggPhCdNi2No7e+X03LUeCKdlRwYnRVceOZuq/weqFv0zJyTtF9GX95jwadoqaCYN5WUoUutRZ1On2PXfpOJhf3KBOsCvWzPO9/7sryFT48DpQSWnLB1LnzAFfD9e8zG+o8SQ1Erk1uRUw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8147.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(7416014)(366016)(1800799024)(18002099003)(22082099003)(6133799003)(10067099003)(5023799004)(11063799006)(261102123227099003)(4143699003)(261026121527099003)(261021121427099003)(261022075727099003)(261021123027099003)(261022105027099003)(261026140227099003)(56012099006)(261009223027099003)(261028144727099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?K2wxWHlpYVBYVWNXOHpnNlNDd0IwWFVnbGM4b210bHFOTDJVR3ZnN2dMMGJ2?=
 =?utf-8?B?WjM3VEN2Rm92U3lRZUdoLzBSOEpHaDJ3SGRENllwazMwZ21jTW81Z2s2aTZB?=
 =?utf-8?B?OERzVS9TT3N1V0p5U2hXOG4rTDFHWllTK1NvaFFaMlFaS2UxeElNRjJPaUF3?=
 =?utf-8?B?UEJ1TXM4RXdhdHNzSDRVeE5sU09qUkdNM2psQ1puUldPODd4b0V1Y3lnU09C?=
 =?utf-8?B?UVViNXBPNG5DV1lLTkFkRVFuaWdqeStubDNSZVJBcHBMYkVVME5VbE1HV3Nr?=
 =?utf-8?B?dk9yUDZLbVFTSWUrYjVyaGJjOXVyTE5LbTc5T05JUU1WNGdrNVY1YUNNLzlm?=
 =?utf-8?B?VkxtU2w2c1c5cVVSRmo5U0ZrNzNCL0RLZVUvMWRMUlcrMzkxRkxuT0tUa1hR?=
 =?utf-8?B?Mjk5RU9mT3FxMk9DRU1obHlpVzd1YnpTUFl5S3JoQmNlaU1VQUtjRThpMjln?=
 =?utf-8?B?M2RsbXRsUXkrcjlxYkJWb1ZyMzBDWE9yUXFydTVsb01TNjBVdi9VL2c0Skg1?=
 =?utf-8?B?d3lTd0ZraGNuMi9IWEwvMktXT0lPRUUzalhEV0xHSjBCc0tsQjZTditMZDRV?=
 =?utf-8?B?YXk0TCtiQmhjbmlud3c1WEpqbVFEQlZNVHNScFlKUmdycWlPVStFU3gyVlBm?=
 =?utf-8?B?SnJpLzBZUmFGTnluQkpEdEVlZU1VbVJNZ1dBLzBDRE1iY2xhMUpVWW42RDJM?=
 =?utf-8?B?SmsvQzQ1bUJOSmFDMXlZb0xvU1ltUGRHZUpqaGNKMUZoeERHeG9MK0UwTE1u?=
 =?utf-8?B?dkVKQUVKckw3ZEt2V2V2cy9hTWlVUnZBUTVoZ1VRR2RkblVvaUpEcVU2eXRY?=
 =?utf-8?B?MjRlbUg5V3o5a1YvVVFjdWhidWgxenZzWXBpdlZVbXpaK1VtZEJBK2JvZWZ1?=
 =?utf-8?B?N3JoSDIyNUNaQ3d1RWV0cm9WUE11dUhFc2RDU0xmcnp4dDlsOUxkc0VKMGwy?=
 =?utf-8?B?V0lYNFdaTjErSE92S2hxZ0dsdGxmSTRLZjlRZVN3R2RkVUhmVEF6a0RZR3VH?=
 =?utf-8?B?QWRtWmRwN25vSzYwSm0rZGZDc3l3NFdHbHlUVWticUZFNlZaUFNpcDVrUXFN?=
 =?utf-8?B?eVJSbEhFQWcrbnRFRnVNQlE2RHUvenNtYStQSnlwWEFwTEtuUWlONHJkZjVj?=
 =?utf-8?B?d1BNczNnbWk0dGNhbnJuWnpQZ3FIUVlRZmtBL3VjSFc5NVkvV01PbFR3Rk1Z?=
 =?utf-8?B?eTlIK2pFcmc0TndSQXFkdG1XYnROVmlnYjA4TElaRUNWME1adXh1c1dPaGpB?=
 =?utf-8?B?SGUvRGtrK3ZWOG5ZUmFoWHFhTWdTTklVY1JsdHhnTXloUDNEMnhzeHhQOEJB?=
 =?utf-8?B?Z0p5L1E4elo4VzArWEJpdnpjZGgrdXdMSk53bU1sYnh3d1BOeFNHUjVVdFVP?=
 =?utf-8?B?TWJ0QTl4Wkw4OE9CVjBmQ2tKNGk1OTRtZ1JoSGNYemRnQzgzQXVDL25uZHhB?=
 =?utf-8?B?emdIWGk4T1JNb1F5ZTl3WUlweHN3TFZjSnVCbEMvMEY2a3VEUlBWOE1TWHVW?=
 =?utf-8?B?OFRuNFNJZ2xPbytLaXFoNUhXWWE2OGdLK0l6YlBzam9UUUN3ZGg0WEp0ZVVn?=
 =?utf-8?B?RFJCV214S29lQXp2cSt0Y1NQMjlDbkVPM2VmQnJhQVBoaWp2VXR3YUtrckk5?=
 =?utf-8?B?czdBSURUYWlDVS9TWDN5bDRRL2l6bE1JMVVqYWM1MXZoVjFSYmJGM2kxQkZB?=
 =?utf-8?B?WUtzOXdieCs5Ym5sSlExdlZXajhXK01kdEhTdm5wNWN5UXYwWnBBTmw2U3Jj?=
 =?utf-8?B?WjYzVytJOFBDbHFhM3p3MS83OHNkK3RjRXpXeWI4TXlua3V1bXQxQUFPV0po?=
 =?utf-8?B?MEVQL2ZJN3pkU29LdkRYSEFYMkRZMWxrdmRtdHA1MTkxQWpjSVFOaktuNjBD?=
 =?utf-8?B?bEVFV0R4V3BkalRDU0xKaU1tUGFPTFRNdDlJN2FvdmRvbkRzbTltekVaMVZI?=
 =?utf-8?B?NEl0MnFPekNzakxhSkdNaXlRcHVuUm9ZeFRORU80ZU5xTTVFbFhRNXhZeC9i?=
 =?utf-8?B?MTYzUkJxZzU3U2dxNURNK0x1TzNpMUZqTGNRL3JVdjNTU0FveGhSUy9EaDUw?=
 =?utf-8?B?RHA4c2IyZkhXZEVkWlJyUkg5Q0dhMzBsZXI5dWZqV3hJU0xBd2p5V2JRT1Y0?=
 =?utf-8?B?NHRFVFF2ZVU3SzN2SHFkb3c1RlZ4QTV0ZUg1blFhalRTS1MxdW9yK2VXR2Na?=
 =?utf-8?B?VDRhcWppaGRpb3VXSFZXa1pHVC9vdXhNakJuSVVHZEtsVjVxQjBCZVl3M0hX?=
 =?utf-8?B?bWEyaDVub3gwVlFOemk2MmpYMWprSmQ5REg5Ykx6TXZ3VU5nVjJCQ1dUUE1Q?=
 =?utf-8?Q?1lU1WizCOZ1mOCFfqe?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c44a99e-61e5-4eab-f4ba-08df3fdaaadb
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8147.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 10:00:51.5380
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EOvcZSjUS8K4UA9558b0YjhpIH+TpoNOXyumLsjADGEvhLru41mHPBrg8ZhPb3Xb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6143

Hi,

On 10/20/2026 5:28 PM, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 5 potential
> issue(s) to consider.
>
> Critical: 1 · High: 1 · Medium: 2 · Low: 1
>
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwork
> know by including "pw-bot: cr" as a separate line at the end of your reply
> (one such reply per series is enough).
>
> - [Critical] Use-after-free in ep_start_xmit()
>    (drivers/net/ethernet/xilinx/tsn/xilinx_tsn_ep.c).
> - [High] Shutdown race: the closing flag does not stop a TX completion
>    that is already running from waking a queue after ep_stop() has called…
> - [Medium] The TX path cannot recover from an MCDMA channel error.
> - [Medium] TX flow control counts frames, but the DMA engine runs out of
>    segments.
> - [Low] The patch now produces software TX timestamps (skb_tx_timestamp()
>    in ep_start_xmit), but ep_ethtool_ops (line 515) only has .get_drvinfo…
>
> --
>
> net: xilinx: tsn: add the endpoint TX data path
>
> This adds the transmit path to the Xilinx TSN endpoint driver. Each frame
> is mapped into a scatterlist and submitted to the DMA channel in
> tx_chans[] for the frame's logical queue. The queue is stopped when the
> ring fills and woken from the DMA completion callback.
>
>> diff --git a/drivers/net/ethernet/xilinx/tsn/xilinx_tsn_ep.c b/drivers/net/ethernet/xilinx/tsn/xilinx_tsn_ep.c
>> index 0a13e04d40575..bd8cd504cefb4 100644
>> --- a/drivers/net/ethernet/xilinx/tsn/xilinx_tsn_ep.c
>> +++ b/drivers/net/ethernet/xilinx/tsn/xilinx_tsn_ep.c
> [ ... ]
>
>> @@ -310,8 +314,150 @@ static void ep_dma_rx_cb(void *data, const struct dmaengine_result *result)
>>   	ep_rx_refill(xchan, true);
>>   }
>>   
>> +static void ep_dma_tx_cb(void *data, const struct dmaengine_result *result)
>> +{
> [ ... ]
>
>> +	ndev = skb->dev;
>> +	txq = netdev_get_tx_queue(ndev, skb_get_queue_mapping(skb));
>> +	len = skb->len;
>> +
>> +	if (unlikely(result->result != DMA_TRANS_NOERROR)) {
>> +		DEV_STATS_INC(ndev, tx_errors);
>> +		dev_kfree_skb_any(skb);
> [Severity: Medium]
> How does the TX path recover if the MCDMA channel reports an error?
   I agree with the scenario. The MCDMA provider sets chan->err on an
   error interrupt but does not report it to the client, and it resets
   the channel only on a new submission. If the TX queue is stopped when
   the error arrives, nothing triggers that reset and TX stays stalled.

   As in my reply on patch 6, we will address MCDMA error notification
   and recovery in a separate MCDMA dmaengine series. Since an MCDMA reset
   affects the whole core, recovery has to cover both the TX and RX
   channels, so it is not handled as a TX-only change in this series

>
> In drivers/dma/xilinx/xilinx_dma.c, xilinx_mcdma_irq_handler() sets
> chan->err on an error. After that, xilinx_mcdma_start_transfer() stops
> handing BDs to the hardware:
>
> xilinx_mcdma_start_transfer() {
>      ...
> 	if (chan->err)
> 		return;
>      ...
> }
>
> The flag is only cleared by xilinx_dma_chan_reset(). That runs from
> xilinx_dma_tx_submit() on the next submit, or from terminate.
>
> Suppose the error arrives while the TX queue is stopped, either by
> netif_txq_maybe_stop() or by BQL through netdev_tx_sent_queue(). Then
> ep_start_xmit() is never called again. No reset happens, ring_tail never
> advances and __netif_txq_completed_wake() never runs. The queue stays
> stopped until ifdown/ifup.
>
> ep_netdev_ops has no .ndo_tx_timeout either. So the watchdog never
> terminates the channel or resets ring_head/ring_tail and the BQL state.
>
> A related point: xilinx_dma_complete_descriptor() checks per-BD
> completion only for XDMA_TYPE_AXIDMA. Can descriptors abandoned across a
> submit-triggered reset later complete here as DMA_TRANS_NOERROR and be
> counted as tx_packets?
>
> This looks unchanged at the end of the series.
>
>> +	} else {
>> +		DEV_STATS_INC(ndev, tx_packets);
>> +		DEV_STATS_ADD(ndev, tx_bytes, len);
>> +		dev_consume_skb_any(skb);
>> +	}
>> +
>> +	__netif_txq_completed_wake(txq, 1, len,
>> +				   CIRC_SPACE(READ_ONCE(xchan->ring_head),
>> +					      READ_ONCE(xchan->ring_tail),
>> +					      xchan->ring_size), 2,
>> +				   READ_ONCE(xchan->ep->closing));
> [Severity: High]
> Does the closing flag really prevent a wake after ep_stop() has disabled
> the queues?
>
> __netif_txq_completed_wake() checks netif_tx_queue_stopped(txq), then
> checks !closing, then calls netif_tx_wake_queue(). None of these steps
> is serialised against ep_stop():
>
> CPU A (TX completion)               CPU B (ep_stop)
> __netif_txq_completed_wake()
>    queue stopped, closing == false
>                                      WRITE_ONCE(ep->closing, true);
>                                      netif_tx_disable(ndev);
>    netif_tx_wake_queue(txq)
>                                      ep_exit_dmaengine(ep);
>                                        frees TX channels
>                                        ep->tx_chans = NULL
>
> netif_tx_disable() takes and drops each txq lock, then returns. It does
> not wait for a completion that has already passed the closing check.
>
> The qdisc path is covered by dev_deactivate_many(). generic_xdp_tx() is
> not: it only checks netif_xmit_frozen_or_drv_stopped(txq) under
> HARD_TX_LOCK.
>
> It can be reached through xdp_do_generic_redirect(). xdp_ok_fwd_dev()
> checks only IFF_UP, which is cleared after ndo_stop returns. It can also
> be reached through generic XDP_TX on this device's own RX, whose
> channels are freed after the TX channels.
>
> Could ep_start_xmit() then dereference a NULL ep->tx_chans or a freed
> xchan on the re-woken queue?
>
> The v3 changelog says the patch will "Skip the queue wake in the
> completion callback while closing". A lockless flag test doesn't seem
> to give that guarantee. This also looks unchanged at the end of the
> series.
>
>> +}
>> +
>>   static netdev_tx_t ep_start_xmit(struct sk_buff *skb, struct net_device *ndev)
>>   {
> [ ... ]
>
>> +	nents = dma_map_sg(xchan->dma_dev, skbuf_dma->sgl, sg_len, DMA_TO_DEVICE);
>> +	if (!nents)
>> +		goto err_drop_skb;
>> +
>> +	dma_tx_desc = dmaengine_prep_slave_sg(xchan->chan, skbuf_dma->sgl,
>> +					      nents, DMA_MEM_TO_DEV,
>> +					      DMA_PREP_INTERRUPT);
>> +	if (!dma_tx_desc)
>> +		goto err_unmap_sg;
> [Severity: Medium]
> Can this path drop frames under load once the DMA segment pool runs out?
  I agree the TX ring counts frames while the provider's per-channel
  segment pool (XILINX_DMA_NUM_DESCS, 512) counts scatterlist entries, so
  in theory the pool can be exhausted first.

  In practice this needs the up to 62 in-flight frames to average more
  than 8 scatterlist entries each, while typical frames at the endpoint
  MTU use one to three. If it does happen, prep fails and the frame is
  dropped and counted in tx_dropped. The queue does not stall, no buffer
  is leaked, and transmission continues as completions return segments.

  Since this needs unusually fragmented traffic and the only effect is a
  counted drop, I would prefer to keep the current behavior for now.

Thanks
Srinivas Neeli
> With ndev->features = NETIF_F_SG, one skb can need up to
> MAX_SKB_FRAGS + 1 scatterlist entries. xilinx_mcdma_prep_slave_sg()
> takes at least one segment per entry. The segments come from a fixed
> per-channel pool of XILINX_DMA_NUM_DESCS (512):
>
> xilinx_mcdma_prep_slave_sg() {
>      ...
> 			segment = xilinx_aximcdma_alloc_tx_segment(chan);
> 			if (!segment)
> 				goto error;
>      ...
> }
>
> The driver ring holds TX_BD_NUM_DEFAULT (64) frames. The stop/wake
> thresholds of 2 count only frame slots.
>
> Suppose in-flight frames average more than 8 segments each, for example
> MSG_ZEROCOPY with many small frags. The pool then empties while
> CIRC_SPACE() still reports room. prep returns NULL and the frame is
> counted as tx_dropped, instead of the queue being stopped.
>
> This looks unchanged at the end of the series.
>
>> +
>> +	skbuf_dma->skb = skb;
>> +	skbuf_dma->sg_len = sg_len;
>> +	dma_tx_desc->callback_param = xchan;
>> +	dma_tx_desc->callback_result = ep_dma_tx_cb;
>> +
>> +	spin_lock_bh(&xchan->tx_lock);
>> +	cookie = dmaengine_submit(dma_tx_desc);
>> +	if (dma_submit_error(cookie)) {
>> +		spin_unlock_bh(&xchan->tx_lock);
>> +		skbuf_dma->skb = NULL;
>> +		goto err_unmap_sg;
>> +	}
>> +	WRITE_ONCE(xchan->ring_head, xchan->ring_head + 1);
>> +	netdev_tx_sent_queue(txq, skb->len);
>> +	netif_txq_maybe_stop(txq,
>> +			     CIRC_SPACE(xchan->ring_head,
>> +					READ_ONCE(xchan->ring_tail),
>> +					xchan->ring_size),
>> +			     2, 2);
>> +	spin_unlock_bh(&xchan->tx_lock);
>> +
>> +	skb_tx_timestamp(skb);
>> +	dma_async_issue_pending(xchan->chan);
> [Severity: Critical]
> Can the skb already be freed when skb_tx_timestamp() runs here?
>
> Once dmaengine_submit() has returned and tx_lock is dropped,
> ep_dma_tx_cb() can take skbuf_dma->skb and free it with
> dev_kfree_skb_any() or dev_consume_skb_any().
>
> This ordering seems to assume the transfer can't start before
> dma_async_issue_pending(). However, the Xilinx MCDMA provider starts
> pending descriptors from its IRQ handler when an earlier transfer
> finishes:
>
> xilinx_mcdma_irq_handler() {
>      ...
> 		if (list_empty(&chan->active_list)) {
> 			chan->idle = true;
> 			chan->start_transfer(chan);
> 		}
>      ...
> }
>
> xilinx_mcdma_start_transfer() then moves the whole pending list onto the
> hardware:
>
> 	list_splice_tail_init(&chan->pending_list, &chan->active_list);
>
> So with an earlier frame in flight on the same channel:
>
> CPU A (ep_start_xmit)               CPU B
> dmaengine_submit(frame B)
> spin_unlock_bh(&xchan->tx_lock)
>    <delayed by irq/preemption>
>                                      IRQ for earlier frame
>                                        start_transfer() starts frame B
>                                      frame B completes
>                                      ep_dma_tx_cb() frees frame B
> skb_tx_timestamp(frame B)
>
> skb_tx_timestamp() reads skb->sk, skb->dev and skb_shinfo()->tx_flags.
> With SOF_TIMESTAMPING_TX_SOFTWARE or a PHY timestamper, it also clones
> the skb or queues it to the socket error queue.
>
> The skb_tx_timestamp() kernel-doc says it must be called "before TX
> completion of this packet can trigger. Otherwise the packet could
> potentially already be freed." The v3 note says the call was placed "at
> the hardware handoff", but here it runs after the handoff.
>
> Would moving skb_tx_timestamp() before dmaengine_submit() avoid this?
> The later patches in the series don't touch the TX path, so this is
> still present at the end of the series.
>
> [Severity: Low]
> The driver now generates software TX timestamps. Should ep_ethtool_ops
> also get a .get_ts_info, such as ethtool_op_get_ts_info()?
>
> ep_ethtool_ops only has .get_drvinfo. The default in
> __ethtool_get_ts_info() reports only SOF_TIMESTAMPING_RX_SOFTWARE |
> SOF_TIMESTAMPING_SOFTWARE. ethtool_op_get_ts_info() is what adds
> SOF_TIMESTAMPING_TX_SOFTWARE.
>
> As a result, ethtool -T won't list software-transmit for this device.
> Tools such as linuxptp, which check TSINFO first, will treat it as
> unsupported.
>
> [ ... ]
>

