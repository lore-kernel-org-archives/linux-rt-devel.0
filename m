Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010028.outbound.protection.outlook.com [52.101.193.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8629441027
	for <linux-rt-devel@lists.linux.dev>; Thu, 24 Sep 2026 09:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790242162; cv=fail; b=YsKeg4nJI+TIMUcgbiT5Bfgetu7aTPBPyxH+yZJ86VZaZqGjJsM0dDDYSjzAZ3n6TBOU0gOUR7mTV9HH+6nQ20qUSBtEzY5/5H655SJ4luBHM31G/0KxPScqRjr7jbeE6Z6ArLVlS1oMXj6idaAfSy8lIHxgPP8bmk8Ms/g9/Ug=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790242162; c=relaxed/simple;
	bh=poxf5bGyAUBXfEp4TModaSgiR9PpbBmn2mz2Z+F7x5k=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=QLG7Wj/o0dDaHmoxw9mz/zQDoTOxLxpp4kmszmj8hUN8DaZUUc1VRSaYBXAkLNND4ScB5hS+mmAoQmXeojM6dS8CEq/B05duX2RspRlT8VR6us7eYzT4+r6iyZ9QdnSCwDj548S0IP8M3UXSgdoelAmzOydMeRe+UKVR8LlXuWQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=iUNHWLHu; arc=fail smtp.client-ip=52.101.193.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="iUNHWLHu"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uBgZjYNW+kRhZtoBLg4odpzkS/fJo9Ibd7iEd/Ts/5G3IOwC52XTDwm1NqPcIXs9HueZxCR2ipbd9UxjPvmEUtmxm3kNVXrqyMIFbDTGxMMpk8t7tBdkUO2YsXJFfW2/XxaPnA7hrNfdgVl5BlpKXI9MMBr0kubIRocB7IbAHPkg1YRxwpSp24axDVApilkxwZ8B+jrfTj5RQV3tcwUWYg0SsG3BDoa+O8RF0YiUAqpvHBDTwL/8TpmBb/IqJ5RewgL+M8gEbWjrYeL2YMVSFioF/cqH97Kl/sVGsHgsI33ZxnURm8Q22tw2Aff8T1pR8bX4TNXVoCKUTiaqd5IgKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BkATPKz8peYTmst8OH6sGzKdxfIiedNVA9/xXGPK1dE=;
 b=CxazQ8mzMzmnN7vLsEN7MYz1k+3Hzy8aQVgQiqjCrXjqD2J/X+WEWDbA+xwGdWP+twhXRVgS5LsUS8X6L7bLqKn2JHBgmA3gkrv6IO2PY3PgXsrwHBQB7DxmMotuxLSpFKQPOX+l3G9q41rDvyjcrTB/mplxVH6+k/zly+TJ2EaZrwgxtbL0wlHv644QHmibRZ1kfS+KdKNWnQGr8dXoR+3vqZbocM+m0J6yE9lt3niBjUExVJt7NzwFQ7lnMhpdMgggGP/VNuTby3wFsby5PLIWEVZddU7UscXI3+YcQXHJQlsVlQo5TBHfb5hW1hRx1b7grz2ygVh3KL91dU/zmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BkATPKz8peYTmst8OH6sGzKdxfIiedNVA9/xXGPK1dE=;
 b=iUNHWLHuYzT4+4eBrBBUmoByTfsghoPuMFWHzs+0XW4WBpSRzAHJ9pbaYcbdRjsad2ObXPDp0eTf03OGpynnLlBrkhOGdDNdwi1WW3Cy4qosAwoU14n4roY60G/0N7lsgMpA+Csaj9jrHeUZLWLHCnLSt2UrW+KSFL4hZlIdBds=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SN7PR12MB8147.namprd12.prod.outlook.com (2603:10b6:806:32e::5)
 by DM4PR12MB5772.namprd12.prod.outlook.com (2603:10b6:8:63::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.16; Thu, 24 Sep
 2026 09:29:13 +0000
Received: from SN7PR12MB8147.namprd12.prod.outlook.com
 ([fe80::3923:c1a4:778b:56f2]) by SN7PR12MB8147.namprd12.prod.outlook.com
 ([fe80::3923:c1a4:778b:56f2%3]) with mapi id 15.21.0451.014; Thu, 24 Sep 2026
 09:29:13 +0000
Message-ID: <a30f5acd-b8a8-4e8f-a01f-a94bcf04504b@amd.com>
Date: Thu, 24 Sep 2026 14:59:02 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 1/8] dt-bindings: net: add Xilinx TSN Endpoint
 Ethernet MAC
To: netdev-bot+sashiko@kernel.org, srinivas.neeli@amd.com
Cc: nagadheeraj.rottela@amd.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, richardcochran@gmail.com,
 michal.simek@amd.com, bigeasy@linutronix.de, clrkwllms@kernel.org,
 rostedt@goodmis.org, netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rt-devel@lists.linux.dev, neelisrinivas18@gmail.com, git@amd.com
References: <20260909-patches_v2_external-v2-1-3a40babaff4c@amd.com>
 <178924536482.3125.12884246382008244685@kernel.org>
Content-Language: en-US
From: "Neeli, Srinivas" <srneeli@amd.com>
In-Reply-To: <178924536482.3125.12884246382008244685@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PEPF0000017B.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c04::46) To SN7PR12MB8147.namprd12.prod.outlook.com
 (2603:10b6:806:32e::5)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8147:EE_|DM4PR12MB5772:EE_
X-MS-Office365-Filtering-Correlation-Id: cc4dbe57-8d48-4083-23d4-08df1a1e4bdb
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|23010399003|366016|1800799024|3023799007|56012099006|5023799004|11063799006|6133799003|4143699003|18002099003|10067099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	qTNEuzDzqOW1TLSuelVX8y7IcNDm3nmuRyFUQGafSv/bxKwFzW/Q7Txo7GuLZEQAjUAmOpUGguUFIpdRZZM2XeANyA6lR0cp9C7sICZFefGG8GfBBxHDDR1Kt8kUTzAReAsc0y1jC1R+Bu7ZBcBt1zKDaN02BSSoqpOynf5iuNWwp37K35sSc0D5p7CiyVdiIAuGHtmNM20yFZJ7TimakedPbEWYW/Kg3e+jZd5G2dgmxhEXphILbIiYShusdZTzjlHfeay3LDnJU5XAUTrvkJdGgULjQyQHzz66p5E15XqrQmgHpHTBqZOL5Si8e5A2+hufXkPEcgNd2RSdi9DjIWgbqjd0VieoScDi1RSO1rpBb7MHB459cKKu9Z+JHyAoJ4Q2Kkc8nVkxU9X1VQ27RZDkwEEBVgzjkYmW2G6JRNCRc/toNy2p8I7FZozkOs84aQGyCN+hfWJNszPBf+NBKaci+edoI2JW6dHBUJGUgKzo2yoI7f/pl8hkcKovutxAWyGoRXRkQAhDn3cfIo2+kvcQaPPt9dsnCfJZwqWMYZxdtgzOIneeoc0ZzILbP9MhMBBaqmDsL8TLBh136+rTpWOiEdGVYZXyuxH3uVT+wEHyVsKD7lu5Xj0N2oRiVipwc7nTxK4sKR6iA5YdLCibPLtUGjseHxx+xQ16lrc+Oiw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8147.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(23010399003)(366016)(1800799024)(3023799007)(56012099006)(5023799004)(11063799006)(6133799003)(4143699003)(18002099003)(10067099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aGJLRjVNVU52ci9qdEVxYVRrSVViWHFJc1NEMWI1SmZGNXU5UjZ3TFdtYVVz?=
 =?utf-8?B?cjdIejd0OGJ4UTZCM3lGY0dxWmJpVW5BZEhPL285TnlqSHNKbjMyWmt3TVQx?=
 =?utf-8?B?TTQyZGhpVjl4N3N5NVoxdGhvSzMzamRwWkQxM1pkQVdaOFp6eHJqNlI3QnZO?=
 =?utf-8?B?RGFQVTAyNEc2TkRKcWJMNUlKS2RxNklpN2c5NUxveDJjcXE0YjdrQVNDVVRH?=
 =?utf-8?B?aW1aM1lsS2h3TzRCZEFnRk9YUlQ3dGZyU0loKy9ENHJjRG1pbHR5K2ZpWENX?=
 =?utf-8?B?QUJjcEZPUm9JeTBwdGpmczdsdnp4S0NzbTBkWUVYa3lpOWFON1Qyb01jeEVG?=
 =?utf-8?B?cEVxbGwydVB2U28zQ3lVdDhtTjZoS1hHVW4rSkhzVTZETHdGY2l4dllUYTdq?=
 =?utf-8?B?bS9Tb1JzMjEycUNVdHFkRjZkcVJkaW54T2ZVWVkzbEZlWFB0OFlHVndkRzR1?=
 =?utf-8?B?bzJrN0dCUDB0U2p1V0I2VEFJckxJRElMRXdNZUlSYkpmR3hyc1cvdithYjRI?=
 =?utf-8?B?MjdUWFRtWXpmZTlhMk1mQ20rU2UwRlIwS1UxcTUrNDhtTmtuaU5lYU5lSW5y?=
 =?utf-8?B?cWZFUWZhTUlheFZSSXNsa3N6WE1PZjhLVE5PZ0xjTlJNcWNuT0wzUEt1N3NY?=
 =?utf-8?B?T051eTdpWUdDWFlBQkpmV0QydWFZeVh2ZVFYYm5NZVp4RHNSME9oYklrZTk5?=
 =?utf-8?B?YmJnS0I5Q2tnVU9iR1J5WWZJWGlTdEh6QU9ZMEFmMUhRbkF2aCtHeVBpZWpl?=
 =?utf-8?B?SkhqckdnQTc0TUgrdkNHZTMzWkQwL0lpWVBTZlFsdDRBUi8rY2h5dkhTRXBT?=
 =?utf-8?B?bElEeDZZazV4SjROc0RQQWZLcW5VYkYwcXhGVHhmQVVuMmtDczFJZFAvVThq?=
 =?utf-8?B?SkI4UlZmeG5lcmJlcVNSWUh4a2xSeFh5TVc4ZlhyK2d2c1lLQTh1dkxnYzZO?=
 =?utf-8?B?U0l3SllVbFVIM2V2aGF3ZFRaZXpxMEFrTnpXek1uSmFGLzBzY0VzYVlxb1hy?=
 =?utf-8?B?Umh3OC9EbEMyZ3hTRzJrZEpUZ1crNis0Mk5RbDIzOFNPdmtTc1E4TVBaYnZ0?=
 =?utf-8?B?MmFYRkY2WWZQcmE2L2Q0QS9OUHA1WjRkWXF0K1FYZTEveWFRNUxEelFGOUdO?=
 =?utf-8?B?dytVWENNVXR4aExPT1VwTUVIODQ5Mmd5OExRQTZzYStGdlljaTF5QWc4QUJp?=
 =?utf-8?B?cEErUGlYcHNESzBhajBpSXdSaVJROUVuU1FSTmpyUmRWbHIvTlI5bDV0Z2pX?=
 =?utf-8?B?UENRUjFHK1ExSXJ6eTdaQm1vd1hMNHJHaHFzUTZHS1NTZjJiNEs2clF2azVQ?=
 =?utf-8?B?YmFyVW12M2l3cjY5WlBZS2hReWRORXYxb3dJRk80UEEzY0ZDL2kxdFV4Wi9G?=
 =?utf-8?B?Sm9VS3NrK3JWUWZ2M09pTys1QkNUWGNLV1YwNDNQYWNVeiswbHNzMmQ5Vk4r?=
 =?utf-8?B?NUJrOWk0N1FqVU5zMy9DRGFuZ2toWnVMM2lXS2ZtUVZMamZVOFJGZWZ0a2lW?=
 =?utf-8?B?ZUNubkR2VktpZDB0VVZHTlZPUXdqWXN3cWdIdWRaZEswRStNRHB0OXB5dHF6?=
 =?utf-8?B?THJVL3A5aFhxZlJmLzYyNzU1dkNXMHVPRFFvV2JQMkVLZE5zSURjNnBjWFR5?=
 =?utf-8?B?VFc1Y0l0czBuZHU2Qk5QbEp4RFJuVnpPYjhnZDAvcCtaZy9ROS9OZGVLc3VS?=
 =?utf-8?B?cWxZQlJBRHlkcjV6UGJneCt1OEEyQXYvdWhSM2lsMUo5SEJ2dGRWRmVTQ3hY?=
 =?utf-8?B?TTF5bDB4dFB1aExiWWtLT24yRUhHNjRZQ3FTOGZudGNFMlFxM0M5NGxCZzB1?=
 =?utf-8?B?cUFjTDFQRVA0TEFqdE9GRFdUWnlMWDlBV2ZPaWVLTjd4WHgydWEvSXZGN2JX?=
 =?utf-8?B?di9ERzZoVTdRViswdmhSV1FJdkExaHN0SHV5a1Fub3JOWTJNTjRTcE9HTzZq?=
 =?utf-8?B?dXVqRHV0NHhkYVphbEZZclE3OXNuaVZLbjl2TjY3UHJTZVEwSE9iUTFvSEZI?=
 =?utf-8?B?SUQvZXc0enBmc0NoSUovdHpZeUFsUGpVVG5tWGg1QzZsc2x0WXd1QnBOVVl0?=
 =?utf-8?B?THBVQXdnN3FweWZ6b2JHb2R2bGJFVWV0TFZCaWNqNzRzUWdyL0gwWUFTMER6?=
 =?utf-8?B?eWxPekpxckV1NHUyV2xjbWZYd2wrcHpmcWphVERVQUd2cmNaWlVLR2Q3VmQ1?=
 =?utf-8?B?ZDNCV05uYmxkOTl1SVBNdkIvdFd5TVhzc0QzUzJ6WkN1ekpYR3JTUWQ0cktF?=
 =?utf-8?B?UUlSYzBkbWI1L0UvMGloUGt2UGh5Q3djTmpRRG00NUxWTWNGM1hrSmlCdFoy?=
 =?utf-8?Q?qsmFVA4QW2fr1jAnPY?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc4dbe57-8d48-4083-23d4-08df1a1e4bdb
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8147.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2026 09:29:13.7372
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TWHVzeiLGaay/RAkP3nCLfYmy1w8q85KqDBRsVEY3af493Ch3NAiRPYCC3ghN4Op
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5772

Hi,

On 9/13/2026 2:06 AM, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential
> issue(s) to consider:
>
> Critical: 0 · High: 0 · Medium: 1 · Low: 1
>
> - [Medium] Inconsistent/incomplete port constraints in the new switch
>    `^(ethernet-)?ports$` container.
> - [Low] The endpoint MAC child's DMA/queue description is under-
>    constrained and, more importantly, duplicates information that is…
>
> --
>
> dt-bindings: net: add Xilinx TSN Endpoint Ethernet MAC
>
> Adds a new binding for the Xilinx TSN Endpoint Ethernet MAC IP in the
> Bridged Endpoint configuration.  The wrapper node owns the six IP clocks
> and xlnx,num-priorities, and has an ethernet@ child for the endpoint MAC
> and a switch@ child for the three-port switch plus its two per-MAC
> windows.
>
> Two questions below about the schema constraints.
>
>> diff --git a/Documentation/devicetree/bindings/net/xlnx,tsn-endpoint-ethernet-mac.yaml b/Documentation/devicetree/bindings/net/xlnx,tsn-endpoint-ethernet-mac.yaml
>> new file mode 100644
>> index 000000000000..4e65d1710da7
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/net/xlnx,tsn-endpoint-ethernet-mac.yaml
>> @@ -0,0 +1,364 @@
> [ ... ]
>
>> +  xlnx,num-priorities:
>> +    $ref: /schemas/types.yaml#/definitions/uint32
>> +    minimum: 2
>> +    maximum: 8
>> +    description:
>> +      Number of traffic classes (priorities) configured in the IP.
>> +      This is an IP configuration parameter that determines the number of
>> +      priority queues available for QoS scheduling. Traffic classes map to
>> +      IEEE 802.1Q priority levels (0-7).
> [Severity: Low]
>
> Is xlnx,num-priorities derivable from the properties already present in
> the ethernet@ child?
>
> The driver added later in this series only accepts one value for it.  In
> xlnx_tsn_ep_probe() in drivers/net/ethernet/xilinx/tsn/xilinx_tsn_ep.c:
>
> 	if (num_tx != num_prio)
> 		return dev_err_probe(dev, -EINVAL,
> 				     "TX channel count %u must equal num-priorities %u\n",
> 				     num_tx, num_prio);
>
> so the only legal value is the number of tx_chanN entries in the child's
> dma-names.
>
> Since this is a required ABI property, would it be better to drop it and
> count the tx_chanN entries, or, if it must stay, to state in the
> description which of the two is authoritative?
>
> [ ... ]

No, xlnx,num-priorities is not derivable from the ethernet@ child 
properties.

xlnx,num-priorities is the number of egress priority queues the IP is
synthesised with. It is an IP configuration parameter and describes the
hardware, so it belongs in the binding independently of the host DMA 
wiring in
dma-names.

The num_tx == num-priorities check reflects this MCDMA only configuration,
where the driver sets up one MCDMA TX channel per priority queue. The driver
requires the tx_chanN count to equal num-priorities and rejects a device 
tree
where they differ. That requirement is a property of this configuration, not
the meaning of num-priorities. With the time-aware and per-stream 
schedulers a
priority queue can be served without an MCDMA TX channel, so 
num-priorities is
not derivable from the dma-names count in general.

Thanks
Srinivas Neeli
>> +      dma-names:
>> +        minItems: 2
>> +        maxItems: 16
>> +        items:
>> +          pattern: "^(tx|rx)_chan[0-7]$"
>> +        description: |
>> +          Names matching the entries in 'dmas', one per DMA channel and in
>> +          the same order. TX channel names use "tx_chan<N>" and RX channel
>> +          names use "rx_chan<N>", where N is 0..7. Example: "tx_chan0",
>> +          "tx_chan1", ..., "rx_chan0", "rx_chan1", ....
> [Severity: Low]
>
> A plain items pattern here also accepts lists the description rules out:
> a TX-only or RX-only list, the same name repeated twice, or RX names
> before TX names.  Could the entries be spelled out as an ordered items
> list (or split with minItems/maxItems per direction) so the "TX first,
> then RX" ordering is actually enforced?
>
>> +      tx-queues-config:
>> +        type: object
>> +        additionalProperties: false
> [ ... ]
>> +        patternProperties:
>> +          "^queue[0-7]$":
>> +            type: object
>> +            additionalProperties: false
> [ ... ]
>> +            properties:
>> +              xlnx,dma-channel-num:
>> +                $ref: /schemas/types.yaml#/definitions/uint32
>> +                description:
>> +                  DMA channel that transmits this priority queue, given as
>> +                  the N of the tx_chanN entry in dma-names.
>> +                minimum: 0
>> +                maximum: 7
> [Severity: Low]
>
> tx-queues-config is required but has no required queueN child, so an
> empty tx-queues-config node validates.  xlnx,dma-channel-num is also
> bounded only by 0..7, so a queue may point at a channel that is absent
> from dma-names, or at a channel another queue already claims.  Was at
> least a required queue0 intended here?
>
> [ ... ]
>
>> +    patternProperties:
>> +      "^(ethernet-)?ports$":
>> +        type: object
>> +        additionalProperties: false
>> +
>> +        properties:
>> +          '#address-cells':
>> +            const: 1
>> +
>> +          '#size-cells':
>> +            const: 0
>> +
>> +          port@0:
>> +            type: object
>> +            unevaluatedProperties: true
>> +            description:
>> +              CPU port. Wired internally to the endpoint MAC sibling.
>> +
>> +            properties:
>> +              reg:
>> +                const: 0
>> +
>> +              phy-mode:
>> +                const: internal
>> +
>> +            required:
>> +              - ethernet
> [Severity: Medium]
>
> Should reg be required on port@0 as well?
>
> The value is constrained with reg: const: 0, but the required list only
> names ethernet, and nothing in the inherited chain makes reg mandatory:
> dsa.yaml#/$defs/ethernet-ports -> dsa-port.yaml only defines it,
>
>    properties:
>      reg:
>        items:
>          - description: Port number
>
> and its if/then on ethernet/link requires phy-mode plus one of
> fixed-link/phy-handle/managed.  ethernet-switch.yaml's ports container
> requires only #address-cells/#size-cells.
>
> So this node passes dt_binding_check:
>
>      port@0 {
>          ethernet = <&ep_mac>;
>          phy-mode = "internal";
>          fixed-link { speed = <1000>; full-duplex; };
>      };
>
> but dsa_switch_parse_ports_of() in net/dsa/dsa.c bails out on it:
>
> 	for_each_available_child_of_node(ports, port) {
> 		err = of_property_read_u32(port, "reg", &reg);
> 		if (err) {
> 			of_node_put(port);
> 			goto out_put_node;
> 		}
>
> That is also asymmetric with the sibling ^port@[1-2]$ subschema below,
> which does require reg.
>
>> +        patternProperties:
>> +          "^port@[1-2]$":
>> +            type: object
>> +            unevaluatedProperties: true
>> +            description:
>> +              External Ethernet port. port@1 is wired to MAC1 and reached
>> +              through the mdio-1 bus, port@2 is wired to MAC2 and reached
>> +              through the mdio-2 bus.
>> +
>> +            properties:
>> +              reg:
>> +                enum: [1, 2]
> [Severity: Medium]
>
> Since both external node names share this one subschema, reg is
> decoupled from the unit address.  This validates:
>
>      port@1 { reg = <2>; phy-handle = <&phy0>; phy-mode = "rgmii-id"; };
>      port@2 { reg = <1>; phy-handle = <&phy1>; phy-mode = "rgmii-id"; };
>
> as does giving both ports the same reg value.  The description keys the
> MAC and MDIO association by node name, while the DSA core selects the
> port by the reg value, so a swapped DT passes the schema and then
> associates the wrong PHY/MDIO bus with each MAC.
>
> Would per-port subschemas with reg: const: 1 and reg: const: 2, in the
> same style used for port@0, work better here?
>
> [ ... ]
>

