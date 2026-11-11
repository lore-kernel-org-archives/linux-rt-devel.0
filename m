Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.62.69
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794382738;
	b=ymfWMkH4YP3fxi8cFNk6tHLvzIrZStOVkD9vLd2UkmVQESfT9pLapO+OpYJ9XsmDWQWb
	 uJ0uD5IM7ivgL8Er0rrspqThH8aBo1lepWW5FJrQNbO3rBHlzeIhhP1YApVw3ZKxAPF9b
	 nA/wmkDU0/1V8ijxzYNag3XhV5fDRGveACri9xSXOST7ZnvOIrm7u9dda54Yp4a8kUfC2
	 Jh9iazJ4HyreFHzqF+QwGMypfBEC63Sw3ZggiKjPFpZNKAQ4KtMUYl500K/Gv/0elJ9HA
	 n2A4OylZeb6oZKmQJjbMdPgSH09gfygj+KW9JjzFvJd6AG7HHuyQ0Mtgh9lw6Ltnu8w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794382738;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Message-ID:Date:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=ziZu9JiRnRxdCgL7BG+mZbEtW/lrPYvsJBgkZZ8k1+Y=;
	b=lbYRh4zpUaKkiB9lSV+AWGziQnlOYy/Yalxh6tVA+OSaO5xIcPdZQAZC8THFG8dNcKju
	 cZvLOGM/w0bKCi6VgC6e5G88KTEVE+su6SE/Q0wfFBB5gLlx8R/dFFmUFNKjKGC0BliwY
	 OB5pxpN24T3+t0wZbfdjEr1gOKOZ5S/aENQuJmQD4/FtyTdAHMGYkOkHkeey/CPYhSV8M
	 tmIH7c8JoUGXMuvbne+XcTSN2puYkJRSWBwk0ebnU84T1oUJsYz7vvGdqw9UKJP1QfZfh
	 11dO3dBhHWSTTpuV1P0ctgj8iPcs5iB26bLsax8vBY+oWG/UIazrnzQ/3QBUps3oq8w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=Qea2qAtR;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.62.69
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011069.outbound.protection.outlook.com [52.101.62.69])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D038606A320;
	Wed, 11 Nov 2026 07:38:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4D038606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=Qea2qAtR
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dDcwwZh94Wtcd8quL5yZaBHDeblP0WyWTtVGNDhGEnsmJi9c4nTFqzi31KGeSAv6g1H8HxD5JCFEENPM3eXbESzrfOvNR5/Fp09Y5/UPON/O2za0X9WWoTi26wJwVzR/l/brD4gok7obWe8xLRTPxjwHmKg+2/E37AmIsAODKS1oPeEB5ZCvNq92mYNb26+wmX20gp3A1is86fOOpYgN2rzGK8LZqF0zFbq2uf1ndswdzZ/RS8/+oynJiTKWDpdoXokdjZ5QWJWL72TGiICMa+u9jv8WP2Km5Zj8rlzciXlLA8AeCWZ1MQncJd2X95rPqXP5LFiVClnDrZFk37JF+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ziZu9JiRnRxdCgL7BG+mZbEtW/lrPYvsJBgkZZ8k1+Y=;
 b=oEx2BrLPCEcqIUPpzsc+rVnBw2ipvyfZldP3hwD+9lV+oWy9EN09mGRzIllaY2CD61zR9fUiIWkwCeSEyAzlBCrvQnCDKB12/yzeLQffxwEQmiTYaNqF6tyn8AijW9jclvfNnJ7v75zm7CN49+nCTRL9bLtK2s5iRoFw35i6rftV/2zaqJnFmBaVaSZWEwZSrTJxH1Lf7PSlcgTawTsVjXC4x+aRSqujpqodu1Ipi0jC1OXnif3LnounBqjXa7HVw1dagJfKyAO7XxVfKsS61dN8P33m7TpopHen6043RHKlL+Tull2QOicV8IpOUdppP2pSWUk2gEdYFLdT4WkL0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ziZu9JiRnRxdCgL7BG+mZbEtW/lrPYvsJBgkZZ8k1+Y=;
 b=Qea2qAtRoINGz1I+OL/PKBzx+9jOBMNOx3fe2/ACmzxuJU60NU1EpefhKb35EmRsgYnbj0KcOGZpSP07BWsfiT9tyqUUCWPzrM1LsrHXKTnwhOwfAEjQ2UndgHDu7N2kBp8XG79DU7AW7i4PQicLeR11TTISSJyXiiK7ffycE1g=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SN7PR12MB8147.namprd12.prod.outlook.com (2603:10b6:806:32e::5)
 by CH1PR12MB9621.namprd12.prod.outlook.com (2603:10b6:610:2b2::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Wed, 11 Nov
 2026 07:36:53 +0000
Received: from SN7PR12MB8147.namprd12.prod.outlook.com
 ([fe80::3923:c1a4:778b:56f2]) by SN7PR12MB8147.namprd12.prod.outlook.com
 ([fe80::3923:c1a4:778b:56f2%3]) with mapi id 15.21.0615.008; Wed, 11 Nov 2026
 07:36:53 +0000
Message-ID: <b28e1ea5-4309-4e50-8097-528163711569@amd.com>
Date: Wed, 11 Nov 2026 13:06:47 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 6/8] net: xilinx: tsn: add the endpoint RX
 data path
To: sashiko-reviews@lists.linux.dev, Srinivas Neeli <srinivas.neeli@amd.com>
Cc: devicetree@vger.kernel.org, linux-rt-devel@lists.linux.dev,
 robh@kernel.org, conor+dt@kernel.org, linux-kernel@vger.kernel.org
References: <20261016-patches_v2_external-v3-0-e33d3960ca1e@amd.com>
 <20261016-patches_v2_external-v3-6-e33d3960ca1e@amd.com>
 <sashiko-outbox-175444@kernel.org>
Content-Language: en-US
From: "Neeli, Srinivas" <srneeli@amd.com>
In-Reply-To: <sashiko-outbox-175444@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA5P287CA0338.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:21f::16) To SN7PR12MB8147.namprd12.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: SN7PR12MB8147:EE_|CH1PR12MB9621:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c76aa04-1b88-4ba7-7e2c-08df3fc68e50
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|23010399003|376014|11063799006|4143699003|261022105027099003|261022075727099003|56012099006|261026121527099003|261026140227099003|261028144727099003|261009223027099003|18002099003|22082099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	XlPyqXi3MUO5vaA21DB/2Y6Juxi/cJdGlvSNbfzZeU25p2JEJ6aoLp4PBNT1ohI20fv+3S049jb0e6a11q6vyKQv582zX0c9m6/ubNZJWo7sEk5VtA+R5m1xw/40qBZ8JI32Ux4WxTfWOflqMM42b4Uzyfnp5GjIf79ExsC0af01DGoGb3iN7FJ9yVb/cPT/rfc0U5vYjmpwWy+9GSgI/BONbqlhxElhNvOZMfT4IAu9v4fxvgjs28S7GtJEirPuCIz8yku/qYixL497i6glguxWkn7jCAzbvfIkr1vmVo2OBf7xwzErB04RAJYVW/IuvPDsi5TR/iw2zls41CUWEDO6O0WkmNSt4qlOKRzbAsdaF/6WRg36iJe30xPxlR52CbPqCfy/sdrYzSAhhNU3jz7SDkFyXC/fm67JcIQ/t6qGKING6l0P+Zi2o8CEemZS7Ck6nim0doEEge/XKNpqKyrYgLAYLHknlQdBPBnO9iUzZf76jSk8mkaT6huBHRyCpwJA3EHWNzNbLIxtyg2Vk8a9KjGFmjdW4O5hPa0CBCB70gyXLC722Z2JkEETzXVXDvrijq8igTKtYQJKp7Vk/QqCw6snFvKLWn29+3igiqU5mi0mGUXFOCg5Lc/lledgN8BZUB1RNoGoj6I/VxORgS16jVLBQiQVlRDMEJFPnK8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8147.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(11063799006)(4143699003)(261022105027099003)(261022075727099003)(56012099006)(261026121527099003)(261026140227099003)(261028144727099003)(261009223027099003)(18002099003)(22082099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?a0tFQm1sNy9DWXFPZllrdFNuU2FzTldaSkVGVjE3cVlrWkQxYkIrcVJ4N3BH?=
 =?utf-8?B?NFdseWFDNXRYOEF1M1RvYWFsd1dObll6Y2FieFNkR2JWQUFiVDJSTmd3eW53?=
 =?utf-8?B?WUhQZU9WVHhhOHcxWEtHS0ZlY1UwUnRZaXB6R3dpeGYrZTY0N1gvY0IwbFl3?=
 =?utf-8?B?WW9Bb3U1MVhhSnRQWDZndTArZjZjTENlMlh1M2pMdThGZFBUYjBuTEx4Nzhk?=
 =?utf-8?B?U2p3OGNIcy9SSFB3bW1tWEpmM3IxZXdUQkJrN0VBZ2cxRFZHbW82NHpYRFR1?=
 =?utf-8?B?QjhoSUhEWXI2RW1oUnBsWDRPNW9IOTZBWlhwUlFBenl3N1p4V3VWMThLRTBi?=
 =?utf-8?B?ZS8wWkpaWnEvVEdUeURXSnEwcVROS1BGTWlTVjZTUld1RnQ0Q3Ixbk9nRmc0?=
 =?utf-8?B?TmFpUzB2WVplNFZYd2xDK3ZTZEp3UUo0dDVmR1JwUHVBcW10THczQkZ4Wm8w?=
 =?utf-8?B?cGxpSHFQc2ZGcnpqaE9HTk5xVmpieDRxbklIaktiOVhXd3pvRTkxRCtNWnk0?=
 =?utf-8?B?enhubFJDT0RWUU4wQU1ERHhhOGZkVTFmaWlwK21kY1Nab3F1UG1MbnRDeGZr?=
 =?utf-8?B?Qk03dzc5RjlaamVEMHZIdzNsSFpDc1NOVHNiRTRySlBwMU9TSzFqNzljUUhS?=
 =?utf-8?B?RDVGWllsZjNQRnVocWxlQkUxbnRkenQyanVTaml4NEMxYlY0MXFmK2FGZTBO?=
 =?utf-8?B?M0NOQW9Cd0laQkU4UzR1ampTZkoxMTFWM1JSOUJFc2JEU05scHNldnd2T2hq?=
 =?utf-8?B?K0pENjcwa2pNajAyQm83cFRPQ3E2YitaUmwrQ1greWV3MWtuMTg0VG9UUmhv?=
 =?utf-8?B?ZWJhd09lczR6Ym9VM1VHM0cxWm9UdW4reVYzbEt3ak8raHhvUHpsTlc1Zmh2?=
 =?utf-8?B?MzE3MHpCRHhCNHNmM24vR3BMN1BxV3RjNFRYZ0M3M2Y1TWVPY1lvbmRRVzly?=
 =?utf-8?B?M21LSlg1aWt6ajBHMmphaU0xamJYbGQ3a3ZpejQzUlU5V0h4Z3JVak1sTU40?=
 =?utf-8?B?cW50TmJDVGVsR3R2emMyVk11RG9vT0pteHhzL2ZWU3c3WVJuakNvVS95cENl?=
 =?utf-8?B?ZkJIcFk1RnJTM2xKSGtFbmN6VmtkdUFVSmhkTzlvbHhmNHBIb1M2TEVkYlpO?=
 =?utf-8?B?SDM3UDhyRDJ0YkNEKzFYYkQ2NTVBSUJIZ2NuOE50TFp1N3dRZkpFZEFIbnpD?=
 =?utf-8?B?eEFYZVdiTTJBL0lWU0hvazEza0dPNzVBbXZwM2ZPSGUwVFdzYTlVVnhVbDJL?=
 =?utf-8?B?K2VCc0NxdVdOaEJoN1hBWkJlK1h3N0l6b09kcmw1c2ViUTFIVTZnTHozekUr?=
 =?utf-8?B?S3JROFpCV2N0WEh6d29IVVpmdnk2SWJrMWVXWVZHWEVrYWF2cnpLMExyMlZa?=
 =?utf-8?B?Z0pYRzNqL2xGRFJsTHVyK2N3U084VUFTOEYrSldvMmMvcGJicmVveENySmQ1?=
 =?utf-8?B?c01CMEtrOTNLTmxrbmtHcG1aNXduT0FrQ2tnYU1tM25NV0VOMWRIZkdkc3h1?=
 =?utf-8?B?NlhTbmdHYmJ2dU9adi9rNXl1VWtPV3RJS0ZMbEt6Y1FiY3IrYjhoaXJVZEtW?=
 =?utf-8?B?WXFnaTVTSTNhNkQyR0RYRTlhYlFFRkdCZlY2K2hsTklrNU5tL3B0Nmc1N0FV?=
 =?utf-8?B?SnpDbGRkWitnSWJYR2k5WndyQkE3LzBnZVVBSDR0eWZKVUR1Q1hoNkZyanVO?=
 =?utf-8?B?a1dEckcyUVhrU2RCQnpNTGF0YWQwa25yak1LRFZvUmpxTUJDd3UwcVR1Mklv?=
 =?utf-8?B?RlpuNUdXNE1pUXJ4UVl0R3BmRTlLTElNZ1VBa1ZscEpVY2xYMGZ0M0dwTHph?=
 =?utf-8?B?ZC91RithZ3ArUTVxRURRemFKaG0wdDdua1NNcHM2cGhOamxRNldlYkhWaTBl?=
 =?utf-8?B?ajNQeWNGNUNqem10cXJVdS9ud1drYXhmR2RBTnVTelV4YU8xNHNPNnFrSk9T?=
 =?utf-8?B?OW5Gd04yeXBtZldSUHBEeDRJbUJQVXk2ZTE5b0VDTWhvK0JZNG10RnZ2SUhZ?=
 =?utf-8?B?b0xDS0xXUnJtczIxc1BVNHFoVHdIenQ1T285dG5BK0h3Sng2K1NPbEZORGIv?=
 =?utf-8?B?ZWp6c09xbS82ZkdrQmFLbHl0TlZRSElGVHJXdSs5RldiTE1GRkVVMCtUaFRw?=
 =?utf-8?B?dmIvZnVaUW9EdWNwL3Z1YVdZcnZBRk5IS0lGYXVNRGNOS014a3RmYnY2ajBC?=
 =?utf-8?B?aXdaU2oyYjFzYmRicU9TNW9yWXlNVUxHTFVtc0tXVmhmMGc1ZGxDWllGRS8y?=
 =?utf-8?B?c29aLzQ4SmlkRGhrOXRmeGpOa3c3OS9UeDZISUFZZkVKNG9xZXoxR2wvTTUv?=
 =?utf-8?Q?vXUvtp/sytf9Nfy/DH?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c76aa04-1b88-4ba7-7e2c-08df3fc68e50
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8147.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 07:36:53.4418
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J5nT3RCrRPzdpO5gXmZXrRpBClcKCMMQ7xjeuSqd7TQwc6KAFSM2t58O7p1mhROE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PR12MB9621

Hi,

On 10/17/2026 3:04 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] net: out-of-bounds read of DMA metadata due to missing meta_len check
> --
>
> commit 0ae3124fbc7145cd6d9f2c1314d8d1defc3b13e2
> Author: Srinivas Neeli <srinivas.neeli@amd.com>
>
> net: xilinx: tsn: add the endpoint RX data path
>
> This commit adds the RX data path for the endpoint to start receiving frames.
> It posts RX buffers to the channels and handles inbound frames in a completion
> callback. It also serialises the RX refill process against the interface
> teardown.
>
>> diff --git a/drivers/net/ethernet/xilinx/tsn/xilinx_tsn_ep.c b/drivers/net/ethernet/xilinx/tsn/xilinx_tsn_ep.c
>> index ab3d6d8cb9440..0a13e04d40575 100644
>> --- a/drivers/net/ethernet/xilinx/tsn/xilinx_tsn_ep.c
>> +++ b/drivers/net/ethernet/xilinx/tsn/xilinx_tsn_ep.c
> [ ... ]
>> @@ -112,6 +135,181 @@ ep_get_desc(struct xlnx_tsn_ep_dma_chan *xchan, int idx)
>>   	return xchan->skb_ring[idx];
>>   }
>>   
> [ ... ]
>> +static void ep_dma_rx_cb(void *data, const struct dmaengine_result *result)
>> +{
> [ ... ]
>> +	metadata = dmaengine_desc_get_metadata_ptr(skbuf_dma->desc,
>> +						   &meta_len,
>> +						   &meta_max_len);
>> +	if (IS_ERR_OR_NULL(metadata)) {
>> +		if (net_ratelimit())
>> +			dev_warn(ep->dev, "Failed to get RX metadata pointer\n");
>> +
>> +		dev_kfree_skb_any(skb);
>> +		DEV_STATS_INC(ndev, rx_dropped);
>> +		DEV_STATS_INC(ndev, rx_errors);
>> +		goto submit_new;
>> +	}
>> +
>> +	/* MCDMA metadata: [0] = status, [1] = sideband (TID/TDEST/TUSER), [2..] = app */
>> +	tuser = metadata[1] & TSN_TUSER_MASK;
>                   ^^^^^^^^^^^
>
> [Severity: Medium]
> Could this result in an out-of-bounds read if the metadata array is too small?
>
> The driver gets the metadata pointer and its length via meta_len, but it only
> validates the pointer using IS_ERR_OR_NULL(). There isn't a check to see if
> meta_len is large enough before accessing metadata[1].
>
> If the DMA hardware or backend driver provides fewer than 8 bytes of metadata,
> reading from metadata[1] might result in an out-of-bounds access. Should
> there be a check that meta_len is at least 2 * sizeof(u32) before accessing
> the array?
   The length is fixed by the provider rather than by the frame. For MCDMA
   xilinx_dma_get_metadata_ptr() returns

     *max_len = *payload_len = sizeof(seg->hw.s2mm_status) +
sizeof(seg->hw.s2mm_sideband_status) +
                               sizeof(seg->hw.app);

   which is 28 bytes, and the pointer starts at the status word, so index 1
   is the sideband word and is always in range. A shorter payload is not
   reachable, and the earlier IS_ERR_OR_NULL() already covers the case 
where
   the provider attaches no metadata_ops at all.

Thanks
Srinivas Neeli

