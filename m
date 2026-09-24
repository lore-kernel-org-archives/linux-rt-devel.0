Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011064.outbound.protection.outlook.com [52.101.57.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13A323101A5
	for <linux-rt-devel@lists.linux.dev>; Thu, 24 Sep 2026 09:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790242798; cv=fail; b=ZBJWqFmXgjY8FM3Xn8fubSIBodlgtaZzOVQ37+Ov20phCwzWidGfuIOskbUS3u80HwHslDpI3BELyihOz9kVYMPsn0iQYM7okSje3pa+QaQSVN4MnebOqzzRypGjOhXG/c1wFPa/wYP5i7Kyx/iihRDpo1HgoM4Z1Kt89JQRwAY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790242798; c=relaxed/simple;
	bh=G+XkDxiio08ntnVIu+ZWorgtsu37sBeMGYg6nIEWbEA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=dlXflIsWSQhEJMwqo8e709EA/FC4XXN3G7KnCJ5VW8GYvlJWYvgB90pyGxGZ7UzPj3tM+bnCVMbqvUZjiQP16HT/1OZK/OEV1Y0r2RxKE+Yizy2jTAE2SIRkJ96Di4e3HYXqx8ZsPg7cIBheG1A+hLK4VD+6xU6DCt197WUHx7U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=2rKj1aPp; arc=fail smtp.client-ip=52.101.57.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="2rKj1aPp"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Rbv91+9zlvjcGWw8O7sSO8YFeMbBs6Idw3FFGcuSL0JOm2IdqJrbnLDARtUlKLJ/ogMqRVX4ZMKz6XEgQ+eZYgwSU/5CKbLuMCq5J1iqNZA0D3gTwp5tTI4o8ophbiipIk1euXtOhJuCu94LYWG6mY8GtfIpB716cmuZRyV+GZwvOwym+5wu0scQ0KdlY6Ef0sS34UjTVGA6Pw4BWst2yIuV0X3068oRUCm2K3+YjuoUA1q2GMbD5IK56mgeXBfZOZ9H9sy+aLTOldmneVx39sAUzfXz2PmH99lg0sEp/jrpa8c0DaKICaNAo4kEc9wSoLb3fKUtxb9H6ctFjH0VCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tlg4f67883b+Ux2W8CI3/M+1QHZ38PCcX5qiZI/Nmkg=;
 b=jU4YyTAArL8XU3dQM9Ovt/9Il3oK012oXt1J+TpBVKS5KIe9w8YcWpE/Z/PvrMXzZevxi3wzHSP8k1pwps9bk6gCW8/Z0z1c1MC92fGCVQDr/oHM4eHErEoFxWWXLTpBZfYcP6WTS5xh+M17fEWq3DRhkdOQF6/o2umi6k6AU7PmzXQSvWNLvvK/79oK6MsYh8HIUT/x22nzj2ANvk5pQ/aqbUjtMWgeBMQsbRETwqROFkOVXBfJSpjiIHIcVjp11IUbrLWwey2a6MW9W6M0/y3QrqPAGUw+LJflf4keSPcU5i12yka+vKUWgnRGYd5hL1DLGRJLRR7P+QN9JQJ+sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tlg4f67883b+Ux2W8CI3/M+1QHZ38PCcX5qiZI/Nmkg=;
 b=2rKj1aPpMSHSqWSsvGdijz7ItgQAn65kKTP/wLkysXZvduWRIWz2yUbw9oa7i1GsVc60WHDri+SDzy4c7PlIncpau1MugsE3xNJKiiysjAcyVhgRU70fAStd4cjMOE73vu5KfAMngUJOi9na/r7ktQ2UYOn7FNnF2pQCrXPHWvk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SN7PR12MB8147.namprd12.prod.outlook.com (2603:10b6:806:32e::5)
 by SA3PR12MB196577.namprd12.prod.outlook.com (2603:10b6:806:533::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Thu, 24 Sep
 2026 09:39:50 +0000
Received: from SN7PR12MB8147.namprd12.prod.outlook.com
 ([fe80::3923:c1a4:778b:56f2]) by SN7PR12MB8147.namprd12.prod.outlook.com
 ([fe80::3923:c1a4:778b:56f2%3]) with mapi id 15.21.0451.014; Thu, 24 Sep 2026
 09:39:50 +0000
Message-ID: <1e3e6064-83ec-496d-8935-637c87423f85@amd.com>
Date: Thu, 24 Sep 2026 15:09:40 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 2/8] net: xilinx: tsn: add TSN endpoint
 wrapper driver
To: netdev-bot+sashiko@kernel.org, srinivas.neeli@amd.com
Cc: nagadheeraj.rottela@amd.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, richardcochran@gmail.com,
 michal.simek@amd.com, bigeasy@linutronix.de, clrkwllms@kernel.org,
 rostedt@goodmis.org, netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rt-devel@lists.linux.dev, neelisrinivas18@gmail.com, git@amd.com
References: <20260909-patches_v2_external-v2-2-3a40babaff4c@amd.com>
 <178924536666.3125.1102910032368474240@kernel.org>
Content-Language: en-US
From: "Neeli, Srinivas" <srneeli@amd.com>
In-Reply-To: <178924536666.3125.1102910032368474240@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA5PR01CA0230.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1f4::11) To PH7PR12MB8156.namprd12.prod.outlook.com
 (2603:10b6:510:2b5::10)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8147:EE_|SA3PR12MB196577:EE_
X-MS-Office365-Filtering-Correlation-Id: 8867f145-5566-44bb-f0d3-08df1a1fc72f
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|376014|366016|23010399003|3023799007|6133799003|10067099003|56012099006|5023799004|4143699003|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	eddyas5BuTSf5ntXywfJ7Ig8uA0z8dD2BsQHmDP9Yt6TtzJqszPzMh1NjHlwvm97wcgKZaGfuW41CZt67nFfX+OAbxPyAnaaeuOsZyUsS9ArZBjtm7Eqr7gzM47n22wH09C3YxJQUrO9TnRVIlKGm8sV8/f76dkfl/QMkV9XQ6mZyeZYXA9QcBVQhPg8sNBvoWeU+p31nHtDIEkdh/vZHdrvZTcqrOMQ26iqRXj/vy+OkchjD5kgSJeiyzQM4YNX/7G29e3C09pxTPw/EQO6s13zahF3eG0xDm4/Ha4AZfsXzQyAU065P4G7mX0lHxA/ajccCXMq2ONHQStlZIxo9HvQU/h3gdZWwDR+D4oDuKdrqUOJFv6xYksvwaGAnDAQbHhX4MVQuw2vUvNlx4sGtvB1QhYRS6Rah+2s+a6e0wX1YfTPZinNdYGm/aVeVzTtDI59pF6lJjf3X8t2INyJCV+ui4e0loP8JMOrF6Q7jnLPNkrQBXBNe2C56Kzf4d3mImkVqxYu2D3wQKPdt1Q0+xCgvZjwChh2hCqXGfDx135csbgG5ZIzLN8WbsenvDmrk/CsIbrp+Ievp3o4siQDHgQ8tdnpcEmZkc4MO6+IOPt35VyXtN4wNFYqTZ60I1uBRWG7qYF8vfRiAxClchYdJg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8147.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016)(23010399003)(3023799007)(6133799003)(10067099003)(56012099006)(5023799004)(4143699003)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UDRsWVRLRDRtSCtkZWpnbFhnOFp2QWZPTFFIOVkrRVAxa2Y2TWNIMGp2aGcx?=
 =?utf-8?B?WVFvVjl2am9VdWpYK1J1UmlYSUJtd0dpYi9PTFlSbzQ5L2taK1puRVFQVU9q?=
 =?utf-8?B?Z3FmV2ZiNXdVMTlBM0x0L014MGJWS1V4VlZVUUQ1NEIveGpDK1FMY2x0VURR?=
 =?utf-8?B?UkgrSU9jVkR5VGFCYWxxYWtKVDhvQ0lwRXhlSCtSajR1UjdWZjZlR05xSE9y?=
 =?utf-8?B?YzFNWllPMm42N0dmQVNKQitGTm1mRkdsSTRzTm9QVnpIZklMaFBnT1BTQVIy?=
 =?utf-8?B?NStxcTlrOG1IbldMR2Y3c2VJUjBUN0dFK0taVDg5T0hPMEJDS2hSMk1nVGc2?=
 =?utf-8?B?aE9OUHF3Q1FMMVBDZUN3NFo1RjBBWmNVZ3ZCR0NuYlBiRkV0NVJ5SlF4L010?=
 =?utf-8?B?b29WTXhEajV0UDMrYzI3ak44bUVVUEhianVJWk11OTdBdnNQQ2FRd1Q5REVM?=
 =?utf-8?B?UjhzQkJFTnlGT0lGSGp2YWdGaldWNDZ5OGtrZUwzdjJwODg0NjEyeDJuS3Bh?=
 =?utf-8?B?K1ZmV1pSYzNQa2tUSTdYbk43QmYzVUdtaXZuekN0QzIvWkx0Q3ZWOEJIdm1i?=
 =?utf-8?B?ZE1WbjhLUUQvMXRVdW4zdzJ1ODRVY3RTbmdzWTU1dStnWXFERzM1aTJiTW9D?=
 =?utf-8?B?SnNWSHhJcW1IOHk4bzdjR3hZVWFiYndsR1hDbHhZMzVTMUkvUG5uSTdLVXgz?=
 =?utf-8?B?SXNmRzlxcGZpbXdHRGQrYTZIcGVCZnlNNUhtTmxuYVZ3Z2tzcG9Ibk5WRUdt?=
 =?utf-8?B?RmFzMHFLNzNFTzdnTlNGT21nRlZRYU5CbEZHSjU5K1ZoQStOK3F0eHZXZmdJ?=
 =?utf-8?B?SGFFQy9KV1N3LzIwWkhBZmw0NUNrV3J0RVZ1ZTlRSEUyUEdSYzhwUEgwV2ZX?=
 =?utf-8?B?T1JTT0hiWEpTaHpVOXBXYWdZRVBzZzEwTHdkdmU2WDlETjM0WVBXWWY0Z2tw?=
 =?utf-8?B?TW5zSU9qL3BEQ2I0cEhyWDh5SkJqSGUyVGwzZ09PZWNjaTUrNkxCVTd5Tldo?=
 =?utf-8?B?bkhOQmVFcGRqUmRIbE0rWGpwRm91VTJwM05melF5bm16Wm5XcDY0bzRYYzdp?=
 =?utf-8?B?SEVZdVd6aG9VelBvWU80alZ1di9pR1h0ckE4ZUxuVDJyM3VBSzFMa1pPZCtE?=
 =?utf-8?B?a1RqdEZMaUl4Z2Z2VUFOcjNXcmxZNzBiaTQ1UXJIS2Fkb3VJQlQ3U1BVTDhz?=
 =?utf-8?B?d1YzSW9XUjNCM1E5QzkwZ3hKRWp4aG9lTmlGaGEyZHdOZDdHcFRGSVNQL3N5?=
 =?utf-8?B?dFNteUlDS0hWc2VPbWJwdXo0cWpGSTNJbzM0ZTJoRUswaDNzRDR6Q0lPK2hK?=
 =?utf-8?B?dkNNMkg3SHVWRFRjTTg1NDRGOExCZVhoK1dMS2dkQVBwS05aai8ycmNsTFl6?=
 =?utf-8?B?dFJUbnVWenhIODRvSWxVVFA5dC8rTVZvQ2pGdk16ZTdsSlllSzEvMlp6bVg0?=
 =?utf-8?B?d0tMbTdLRWY0ZHc3YkRTTnBUMk9BbnJIUnFUMkNJRnNRdllnYXJqV2U5dW5R?=
 =?utf-8?B?R2hnYTE0c3AwQk9YUlN4eUZzSlFqU0Nod2R6R0FqUThYUVFwWW9FSUVpaG9D?=
 =?utf-8?B?VEdmRWpGeFBnUEk2bGUzNzZaYTBiWTdiNlVQOE5jOGd5eVI5bTN5ZDh3WHA1?=
 =?utf-8?B?K081YmtmM0QyeEhvV2NVYU50UUV4b0R6Z0VSalBadEdvWXEwT1hCRnd2cDJK?=
 =?utf-8?B?cDZYcDNtam10NmszZGpmazJBZEdxbFd2Z29nTktROXVBcUVmTERTY2Jnczkx?=
 =?utf-8?B?NTFCK3NCcnluUWJ0Y0FGdTBMOGhuUGZyZWNIaUtJdVZnOXcraStFOXpYNGE3?=
 =?utf-8?B?OUNiZ09obEgrN2RhMWFpQiticDRXbXdLTmhDaUsxTE11QnZkT05rT0tlb2pF?=
 =?utf-8?B?QWk3RStSenN1TkZpV0ZOQ2NaYTJOK2V3ZXgxN3E0MHdmcnhBTWYxU0V2YTEr?=
 =?utf-8?B?UTVLUUppU3ZUczFGMGhSaWVKc1ZQck00UmNHNWJMMzRGMVdNa0xuYnV2TW9n?=
 =?utf-8?B?QlFsV3R0SmlrSG9OT1F3d0p5Y1ZwbXpnTVNubzR4bG8yWlRXMDgvdmZ2bTZY?=
 =?utf-8?B?UUl6MmdhK281eWVhNUs2dXpLYnJIYXd0YlJVd0pVbzBtcHhKT3lQbnB0L0tU?=
 =?utf-8?B?OG93ZGkrb3NBeklId3hNREJyMUV5MVlXMDIySGZTcTkrc2kzV2I2WkNpYzZm?=
 =?utf-8?B?OEtsZ0tHSTRnbkdjV25FaUFUUVhhVDVEUzdvZXdDRUtPQzcwN3k4WHVKcHpW?=
 =?utf-8?B?L2psUThMVGQ2aFlKcmZZT01jdnhkS3lidnpTc3Z4dlEwdGNVVlhsMUc3dW9E?=
 =?utf-8?Q?ADngdrwFf4WJ6y4AUP?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8867f145-5566-44bb-f0d3-08df1a1fc72f
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB8156.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2026 09:39:50.4980
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0WsxNzD9vDvie2zpp785wCbwXIjsupAecN/eFdS1qm1TPFWbYu9DxYWjmkrY2uEj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB196577

Hi,

On 9/13/2026 2:06 AM, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential
> issue(s) to consider:
>
> Critical: 0 · High: 0 · Medium: 0 · Low: 2
>
> - [Low] Kconfig help text for CONFIG_XILINX_TSN claims the option
>    "provides the wrapper device and the endpoint MAC that connects the IP…
> - [Low] The binding Documentation/devicetree/bindings/net/xlnx,tsn-
>    endpoint-ethernet-mac.yaml puts 'xlnx,num-priorities' (uint32, 2..8)…
>
> --
>
> net: xilinx: tsn: add TSN endpoint wrapper driver
>
> This adds a thin wrapper platform driver for the AMD/Xilinx TSN Endpoint
> Ethernet MAC IP node. The wrapper enables the six IP-wide clocks
> described in the device tree and then populates the DT sub-nodes so each
> one can bind to its own driver.
>
> A couple of questions on the new Kconfig text and on the DT properties
> the wrapper consumes.
>
> [ ... ]
>
>> diff --git a/drivers/net/ethernet/xilinx/tsn/Kconfig b/drivers/net/ethernet/xilinx/tsn/Kconfig
>> new file mode 100644
>> index 000000000000..b8939d8a92ef
>> --- /dev/null
>> +++ b/drivers/net/ethernet/xilinx/tsn/Kconfig
>> @@ -0,0 +1,15 @@
>> +# SPDX-License-Identifier: GPL-2.0-only
>> +#
>> +# Xilinx TSN device configuration
>> +#
>> +
>> +config XILINX_TSN
>> +	tristate "Xilinx TSN Ethernet driver"
>> +	depends on OF_ADDRESS
>> +	help
>> +	  This driver supports the AMD/Xilinx Time-Sensitive Networking
>> +	  (TSN) Endpoint Ethernet MAC IP. It provides the wrapper device
>> +	  and the endpoint MAC that connects the IP to the host CPU. The
>> +	  three-port switch is supported by the companion DSA driver.
> [Severity: Low]
> Is the help text accurate at this point in the series?  It says the
> option "provides the wrapper device and the endpoint MAC that connects
> the IP to the host CPU", but the Makefile added by this patch builds only
> the wrapper object:
>
>    xilinx_tsn-y := xilinx_tsn_main.o
>
> and tsn_drivers[] registers only &tsn_driver, which matches
> "xlnx,tsn-endpoint-ethernet-mac-3.0".  No driver in the tree matches the
> sub-node compatibles at this commit, so devm_of_platform_populate() in
> tsn_ip_probe() creates child platform devices that cannot bind, and
> enabling the symbol here yields enabled clocks but no netdev.
>
> The endpoint MAC part is resolved by later patches in this same series:
> by the end of the series the Makefile also builds xilinx_tsn_ep.o,
> tsn_drivers[] gains &xlnx_tsn_ep_driver, and xilinx_tsn_ep.c matches
> ".compatible = \"xlnx,tsn-ep-mac\"", so this is only a transient
> mismatch between patches.
>
> The remaining sentence about the "companion DSA driver" refers to
> something that is not in-tree at any point of this series.  Could that
> sentence be dropped or reworded until the DSA driver lands?
   The Kconfig text describes what the option provides once the series 
is applied,
   and it is written once rather than edited in each patch. 
xilinx_tsn_ep.o and
   the endpoint driver land in the next patch of this same series, so 
"the wrapper
   device and the endpoint MAC" is accurate for the series as a whole.

   The switch is a separate submission. V1 carried the endpoint, wrapper and
   switch together, following the guidance to keep a series reviewable 
we split
   it, so the DSA switch driver is posted as its own series. The sentence
   describes how the three-port switch is supported in the overall 
design, which
   is the same text V1 and V2 carried, so we are keeping it unchanged.
>> +
>> +	  If unsure, say N.
>> diff --git a/drivers/net/ethernet/xilinx/tsn/Makefile b/drivers/net/ethernet/xilinx/tsn/Makefile
>> new file mode 100644
>> index 000000000000..6f99226f3dc8
>> --- /dev/null
>> +++ b/drivers/net/ethernet/xilinx/tsn/Makefile
>> @@ -0,0 +1,2 @@
>> +obj-$(CONFIG_XILINX_TSN) += xilinx_tsn.o
>> +xilinx_tsn-y := xilinx_tsn_main.o
>> diff --git a/drivers/net/ethernet/xilinx/tsn/xilinx_tsn_main.c b/drivers/net/ethernet/xilinx/tsn/xilinx_tsn_main.c
>> new file mode 100644
>> index 000000000000..afe7609c67fb
>> --- /dev/null
>> +++ b/drivers/net/ethernet/xilinx/tsn/xilinx_tsn_main.c
>> @@ -0,0 +1,104 @@
> [ ... ]
>
>> +static int tsn_ip_probe(struct platform_device *pdev)
>> +{
>> +	struct device *dev = &pdev->dev;
>> +	struct xlnx_tsn_ip *w;
>> +	int ret;
>> +
>> +	w = devm_kzalloc(dev, sizeof(*w), GFP_KERNEL);
>> +	if (!w)
>> +		return -ENOMEM;
>> +
>> +	for (int i = 0; i < TSN_NUM_CLOCKS; i++)
>> +		w->clks[i].id = tsn_clk_names[i];
>> +
>> +	ret = devm_clk_bulk_get(dev, TSN_NUM_CLOCKS, w->clks);
>> +	if (ret)
>> +		return dev_err_probe(dev, ret, "failed to get clocks\n");
>> +
>> +	ret = clk_bulk_prepare_enable(TSN_NUM_CLOCKS, w->clks);
>> +	if (ret)
>> +		return dev_err_probe(dev, ret, "failed to enable clocks\n");
>> +
>> +	ret = devm_add_action_or_reset(dev, tsn_clk_bulk_disable, w);
>> +	if (ret)
>> +		return ret;
>> +
>> +	return devm_of_platform_populate(dev);
>> +}
> [Severity: Low]
> The binding
> Documentation/devicetree/bindings/net/xlnx,tsn-endpoint-ethernet-mac.yaml
> lists xlnx,num-priorities (uint32, 2..8) in the required: list for the
> "xlnx,tsn-endpoint-ethernet-mac-3.0" node:
>
>    xlnx,num-priorities:
>      $ref: /schemas/types.yaml#/definitions/uint32
>      minimum: 2
>      maximum: 8
>
> tsn_ip_probe() is the only driver matching that compatible here, and it
> does devm_kzalloc(), devm_clk_bulk_get(), clk_bulk_prepare_enable(),
> devm_add_action_or_reset() and devm_of_platform_populate() without any
> of_property_read_u32(), so the mandatory property is neither read nor
> range-checked.
>
> A later patch in this series ("net: xilinx: tsn: parse endpoint DMA
> channel configuration") does consume it from the parent IP node in
> xlnx_tsn_ep_probe():
>
>    ret = of_property_read_u32(ip_np, "xlnx,num-priorities", &num_prio);
>    ...
>    if (num_tx != num_prio)
>            return dev_err_probe(dev, -EINVAL, ...);
>
> so the binding/driver mismatch only exists between patches of this
> series.  Was leaving the property unconsumed by the wrapper itself
> intentional?
   Yes, that is intentional. The wrapper driver only enables the IP-wide 
clocks
   and populates the DT sub-nodes. It does not implement a data path, so 
it has no
   use for the priority queue count. xlnx,num-priorities describes the 
IP and is
   consumed by the endpoint MAC driver, which reads it from the parent 
IP node in
   xlnx_tsn_ep_probe(). Keeping the property on the IP node and reading 
it from
   the child that needs it avoids duplicating it per sub-node.

Thanks
Srinivas Neeli
>> +
>> +static const struct of_device_id tsn_of_match[] = {
>> +	{ .compatible = "xlnx,tsn-endpoint-ethernet-mac-3.0" },
>> +	{ }
>> +};
>> +MODULE_DEVICE_TABLE(of, tsn_of_match);
> [ ... ]
>

