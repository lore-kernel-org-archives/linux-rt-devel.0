Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.200.19
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794388774;
	b=ARBH2zP+9I1QeMmkY2zg8Wm0B/ByW4LFCHFXtzlBIOaaI8ByEK70Zb4DKXytiblHHfnA
	 5SUyXgY7Wgzq47UCAzFKzGlPxOZXkan+4vQjHDApqZUVO7ipBzV071rxRM73vG7joevYr
	 Ys/CSQ9oHVY4Cme8+Pcbol70k3/8YMd/ZjChvHX1ewJjmTMnS9vsC9p2TCP247uuphc1n
	 TGsEHMgn8m3Xae5vPlnkMTqKm4jj/PPCzRUOaQppzs5DD3co4ZPuoQUZ1POYyCV7VhmbF
	 i2Un2Ot4TQhhCMK5pf6nHZiXt5Soo07lhdgt8/zQ3BvvcpF/pV5T4jWK00Ty/1EJuKw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794388774;
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
	bh=kVNJULxs6r3wqWmUXVfAcTTx8q2Yb2G92B+sVNZQPg8=;
	b=NpKwN3+Tx3Cg5esq5Tl+JmCFAhvklFtQg4+KsZEqrVPQ08fBbv7pCbygL75TGb7epgbu
	 JXtcxheOnG+2PxxBdUPRnq6v/q7UQDdgBegIyA906efFC+UVChbMK8U7fB2QgM1OePZH+
	 e0g8hCiL3cOT++ERhyyESQqO0yIS4rqbYETHe1fBzFxrkP2NLfC5vPMUYkUvMXI5eX2hQ
	 l6ligHOWNIoUq+y7VF2eBSG/ZFhoEVUz7koy/MvKr3hclZEPQNwU7lLDFUq8Ge9c7TZJ5
	 5wU9LTtIg5j2Z27TOv+mB91aVS+CQlw7DbtkKvfAexD3gzr82VIJGAzQMt6/+o0MbYw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=kC1HVz1S;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.200.19
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012019.outbound.protection.outlook.com [40.107.200.19])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7A6D606A31C
	for <linux-rt-devel@lists.linux.dev>; Wed, 11 Nov 2026 09:19:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A7A6D606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=kC1HVz1S
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OtGYXxnXajaHflSfsSJZRQkjUXKFzNLDEn2vN/2RtwrxBir70DE7huyVUQY+e5BPe7Kr1ulNakTmUWBL1U47ymSCqa/wlLFmgTMbNzNwzjSWJ28wjEcqKrsTHLrg33Pcv/6gNPHirOHqdGyU31Kx/H9wM/L138hJOVkVHQPOGU5EDMx5wthAfy1UTalklv7i3DjKrAtVZXvTPYvHcn28aE8IOk0tI5J5ubCEHmPdndF5dJp6iJrHGvnT9aqIK7QCuR3hbLBxMOVV21e3yNrFfavyfDCflU0xfHt/GNuhtOcRqlYVRDDob/a/gb55hOndQd7bLkjxRJRyovjj/JGjhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kVNJULxs6r3wqWmUXVfAcTTx8q2Yb2G92B+sVNZQPg8=;
 b=v6PWL/pt5B2oWV5/BkeNQR3s97McBFDJwF+nCy0TE+3OoWLJ31Um3ZDzNvynFzhNHOxct3VrvLGmXtkZSAVxSYvhKQIj3b+I3D6TbmQZi9h4AS4j4KJW3Im3GtPJtW78ox916vaMml5ehibK7rUadtthmvGKjPnCZoBt9oTK3ntW8VeBAvf96d1obQCdx2a4U+LC6k1WnzTLCv6V/jYNpcEag7FQ6OxyMBZb4IUqzABVjdLARtRxzi989qMtoATpQrB7CoPEA2smro4uST4z7yVM6eKxdcT2A4bSiR2wSync9MuHQyBjUeBGXRUWfYtiPCMelKsUWLWFu6OdC0NNRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kVNJULxs6r3wqWmUXVfAcTTx8q2Yb2G92B+sVNZQPg8=;
 b=kC1HVz1SWzhm129DBvorNSzuz3NI4XjuMA6vB67t747phFsOWxKCAL3PUnv5iVLRvq7G/xyoMA6/QoW1HRNkBHNW00L/RPKC3WSBrjQxd+v1ZoqG5ds2t2nEdBRmOgzp8ISPNChlfNBMxqOgUwMhrezTnIQihQtrL/pSpSGIJDY=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SN7PR12MB8147.namprd12.prod.outlook.com (2603:10b6:806:32e::5)
 by DM6PR12MB4338.namprd12.prod.outlook.com (2603:10b6:5:2a2::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.9; Wed, 11 Nov
 2026 09:17:21 +0000
Received: from SN7PR12MB8147.namprd12.prod.outlook.com
 ([fe80::3923:c1a4:778b:56f2]) by SN7PR12MB8147.namprd12.prod.outlook.com
 ([fe80::3923:c1a4:778b:56f2%3]) with mapi id 15.21.0615.008; Wed, 11 Nov 2026
 09:17:20 +0000
Message-ID: <902079b6-c634-4f29-972e-1cba65d372bb@amd.com>
Date: Wed, 11 Nov 2026 14:47:10 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 6/8] net: xilinx: tsn: add the endpoint RX
 data path
To: netdev-bot+sashiko@kernel.org, srinivas.neeli@amd.com
Cc: nagadheeraj.rottela@amd.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, richardcochran@gmail.com, michal.simek@amd.com,
 bigeasy@linutronix.de, clrkwllms@kernel.org, rostedt@goodmis.org,
 edumazet@kernel.org, netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rt-devel@lists.linux.dev, neelisrinivas18@gmail.com, git@amd.com
References: <20261016-patches_v2_external-v3-6-e33d3960ca1e@amd.com>
 <179249750068.3135.14908716798460807295@kernel.org>
Content-Language: en-US
From: "Neeli, Srinivas" <srneeli@amd.com>
In-Reply-To: <179249750068.3135.14908716798460807295@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA5P287CA0066.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1b3::11) To SN7PR12MB8147.namprd12.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: SN7PR12MB8147:EE_|DM6PR12MB4338:EE_
X-MS-Office365-Filtering-Correlation-Id: 47b9b0ca-7c52-4559-0dbd-08df3fd496c2
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|7416014|366016|1800799024|10067099003|11063799006|5023799004|4143699003|56012099006|261022105027099003|261021123027099003|261021121427099003|261026121527099003|261026140227099003|261028144727099003|261102123227099003|261009223027099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	yM3o9CArHbzAfQnvfLXOnYwuj9sbHCaxI/xWlpXczRRUTGii9oO+R3M30vAnX678/NNzCQF26AYfvYzHOhkX6JZQjtRo4OTKfYiPDiBFGM55SNmz27mE8bylnLS/UCmaK2shKjX6hD4Ld7JQnXC5esnADR98bhFJ0oHobgU2BYFK8ViTYBmNLe4tYnEP1zMCg7cE9pKBFRlnPe0oRW+l/JWGOotaFQO4q8o7x/PPPBFiDgg/FVz8O6uOn4wAvn4LcT/hApsQlsbhtPQ+UbkxWy9dAnJaOUuhor7fhAa/xRdjBq40wOkwOY6k0QmVD8uHdjdY1sZLeLeByRBQLSZDnfnFhwu1AX5i28FjStWyxIfjXvrzTXHMpcsTgCJr7RTcVzwvrOPrwxPGzWnQY3leAot0SEGWJGbfAOj/aH84PeJ6BuuEF6LU4VsYblZnTDBbdaRLK0qpoV5LS0rR8amY9XydfzKaOYyOIQb44asVZo7OITeJbiItD9tNzMJyIFYtiaEVwXCCl6n0T4UBTcrs9eGJsLJJ8WduWaNTpmsL032P6lfCQmEmPOpPvVteFLpZ8XITKmFrwghxH4xFxX7lrKPOWHWbw4Fc0ymfp1p99osg3TWfswJ5L20T9lyBFZ+JH0+J4kV/WcjgAPiCf79/5I7+cjMVpOxWyXr4BglLoCo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8147.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(7416014)(366016)(1800799024)(10067099003)(11063799006)(5023799004)(4143699003)(56012099006)(261022105027099003)(261021123027099003)(261021121427099003)(261026121527099003)(261026140227099003)(261028144727099003)(261102123227099003)(261009223027099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WGhsMDhpeWNldUU3SUtpdWJCQ1NWQzI1bEl3Y214RjlpeEFmRUYrWkFSenE4?=
 =?utf-8?B?V1M3Y0VJRWZpck1SeSs5QW0rRUUydXR4QTRvd3pOb0k3VmlNMDVEYjNhbGps?=
 =?utf-8?B?SDhoTFJndk8wNG1PeEF3aGVVbmo4R21EcUoyTFlBNGdJMGhjZVNDSmdGdW1W?=
 =?utf-8?B?QmJXaEZWZWJIc0lTVkZwZ0ZDd051aU1PMkh4U2hKYXphRFlYV0J6L0hKdUY3?=
 =?utf-8?B?WW5MSDU1NU1vT3dvdWk3Zk9VNlhyc0syYW9FSnpjR3drQldmQ3BiSjV0RThF?=
 =?utf-8?B?azBLemtTb1laQWdqTTd4SnBjK3hyT1NJNUNDUFVML2lFZkN6dUdKMEM2blRC?=
 =?utf-8?B?eWJUeFZxZDREV2p2d3VoTUt6S1FkcGRQOXV4OXRzdmtydVVpdXRkbXdlVlBh?=
 =?utf-8?B?aFV4WnYyd3o1VS9sRkVPcW1acStkUGhld3ZnZ1hteTYrUWNVVWF6SmdKMXdF?=
 =?utf-8?B?bEZncEVOYzJoUzE4R1RRaU9pczFUYkdFbGpVemRZM0RiWFNRK1hLSkp0NXVN?=
 =?utf-8?B?YkhDQVdobC9QRHJwQThEVUZMc05oLzdrK2drNTUzQ21QREw3R1pDTVMzLzk1?=
 =?utf-8?B?djV1aUFhTEFxOFdXYUN1dTl4c0NzQWQwWVVBNzVvMVpWL3hldExpaHNybFZq?=
 =?utf-8?B?Z1VMZVB1OHpRYXF1Q1cxeGFKVGc1SVdCbklTZzZnM1BpOCtDaFp1dE1BdWlK?=
 =?utf-8?B?MkVsRy9wWWY0Uk5ucVYzSWQ4WXJDNjhZNTVMbmNCUXpxd2gxNTdZZ3VaWG45?=
 =?utf-8?B?eXAyZU8xTlVCQnJLZEVBcS9tNkdEODJLUFk2aGJYbDJoV3IxSGtVd2VpblpD?=
 =?utf-8?B?bC9vbmY1clFUN0VxcVZueWRsYVVPalRSRGUrNFM3VENzeEgwQ1F5YjZxUXJX?=
 =?utf-8?B?aWZydHhYTC9KbklsSHg0b2poS0lLWndyd0kwMzJuTFN5WXNINXpzMjhSbHVL?=
 =?utf-8?B?Ry83Y2I3Q2lMd28zT2VuQ3p0ODZDZldxRjZjZEFwU0RXTlF0aVNvcjMzR21q?=
 =?utf-8?B?MDd3OVN2UmNWNzZzamlVdnRQNk4zQTBSMlZNOUgrZ1VtQVRHSWhUR1NNbWFV?=
 =?utf-8?B?SVcyZ0ZjTXNSeFVyRkpFMzM4NUhyRWtQd2lsdFpqa09uMWhSTlNxRnZGMHlO?=
 =?utf-8?B?YkRQMlRLMWtjSkZNSTlBMzBXS0E0UTA3enhoQitOazhvdXZFUXhVZG9seUlW?=
 =?utf-8?B?Y1pON2Rla3VOcHN6MmJDbS9Cekh4T3FiNXhOdHVuZjJMdzVEUHlzUytYeTcx?=
 =?utf-8?B?eXI0OTdnNERxK2ZFY2NvSnhiYWJPT1BPQjYwZERUb0lsSkFITkp0UWgxNDE0?=
 =?utf-8?B?RnNIOTVJSERMTG9FQ3orbG5tNmp1M3VWVURvci9mWFVlcFJOZWFQb2hEMVE2?=
 =?utf-8?B?d2ZBdWJ4VjlXTHVDSDByYnM1YUliMFdwVDBXMFdjQUZtTWxEOE9aOHhDNTBU?=
 =?utf-8?B?TTBYb2xyOTF2QVR5Z3BLbFNuMFNrSk45ZjlIaHBYaDNuQ25rRmVhT2JRQ045?=
 =?utf-8?B?dW1LV1BnSFZNME1zRTgvejdsOHVJZjZ4YXMydzExZ0VQMkJpMzFpY041RGcy?=
 =?utf-8?B?UUtXLzNHTzlzckh6cC95U1ZodkhMVXpNWG41d2VXRkZ0TVJ2a0xKMjgyRFpy?=
 =?utf-8?B?azhvNkt3WVgvdS9uOWhjVXBmUVBjaU9GS1BXd09Da09ReEhyZzB0ZEFSWldQ?=
 =?utf-8?B?YWlFM0IrZDNLK0IrcytwaytuWUV1THhuUVQ2SWs3NFhNTjMwRXJlblAvQlli?=
 =?utf-8?B?eEtYcVJDREhrRHRQbjRidCtKV2JVWkpBcmkvc0ZFQ3NkMlIzWERyanA1dmJ1?=
 =?utf-8?B?WjJKY1d1emdyRzVNV1pUVzRuTWFQdGxuOUhwMzdZRTJWMCtUZWd1cG01NGgz?=
 =?utf-8?B?ZktpWktYc0xyR1dhUXFEMDIybEhIaDhSWWRaRVJtQXFYcmw0TFk4MWJNWU04?=
 =?utf-8?B?U1JIODdTa2JHMkpiSzEzaE1WVVRZalJwVXc5V01sUW5NQzJkbEp1QXppZVBv?=
 =?utf-8?B?RzVRbzJkTU5vS2JNQVZGc1FHY2hVT2pDbE95ZUhMaFhqbytQSnJlNGttWmpU?=
 =?utf-8?B?NTBQMTMrWmUwbHJCZjF4U1NNM3RLVEFSa1RIS1BKVStFRTVXN1RSSTN5eGtB?=
 =?utf-8?B?RjBxS1VoUXJndVRGRm1uSS9lSWVaQkxncVBPaHBuOTZvMW1rTEZJeExTTG5D?=
 =?utf-8?B?WG5HYlVWSCs5MWNwRk9raC9kc2tVNDloSU5mdzl1ZXNmSi80SW92RWRtMlha?=
 =?utf-8?B?Z21FcUtXNWhpV2VzV3BveGhiZXI5bDF5T2JXa1VRZDE3WEpINkZISW9IT21O?=
 =?utf-8?Q?ZtgPhIMND1d2T4c1g8?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47b9b0ca-7c52-4559-0dbd-08df3fd496c2
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8147.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 09:17:20.6313
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vHLEhe1VTW4Z6nV51ZNpRMye8H5JYpZKBmU0seO5C6lq3Pw/wfN/ad3bvn7jysGt
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4338

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
> - [Critical] RX buffers are freed and unmapped while the MCDMA engine
>    still owns them, so incoming DMA lands in freed memory.
> - [High] The RX path cannot deliver any frame on the in-tree Xilinx AXI
>    MCDMA provider.
> - [Medium] After an MCDMA RX channel error, RX on that queue stops
>    permanently while the interface stays up.
> - [Medium] A partially armed RX batch can hold received frames for an
>    unbounded time under sparse traffic.
> - [Low] ep_rx_refill() decides whether 'at least one descriptor is armed'
>    by testing ring_head != READ_ONCE(ring_tail) after…
>
> --
>
> net: xilinx: tsn: add the endpoint RX data path
>
> This commit posts RX buffers to every MCDMA RX channel on open. It reaps
> them from the dmaengine completion callback and passes MAC1/MAC2 frames up
> the stack with __netif_rx(). Refill runs from the completion callback, with
> a retry timer for a drained ring and a closing flag plus a per-channel lock
> to serialise refill against teardown.
>
>> diff --git a/drivers/net/ethernet/xilinx/tsn/xilinx_tsn_ep.c b/drivers/net/ethernet/xilinx/tsn/xilinx_tsn_ep.c
>> index ab3d6d8cb9440..0a13e04d40575 100644
>> --- a/drivers/net/ethernet/xilinx/tsn/xilinx_tsn_ep.c
>> +++ b/drivers/net/ethernet/xilinx/tsn/xilinx_tsn_ep.c
> [ ... ]
>
>> @@ -112,6 +135,181 @@ ep_get_desc(struct xlnx_tsn_ep_dma_chan *xchan, int idx)
> [ ... ]
>
>> +static bool ep_rx_refill(struct xlnx_tsn_ep_dma_chan *xchan, bool arm_timer)
>> +{
>> +	int avail, i;
>> +
>> +	scoped_guard(spinlock_bh, &xchan->rx_lock) {
>> +		if (READ_ONCE(xchan->ep->closing))
>> +			return false;
>> +
>> +		avail = CIRC_SPACE(xchan->ring_head, READ_ONCE(xchan->ring_tail),
>> +				   xchan->ring_size);
>> +		for (i = 0; i < avail; i++) {
>> +			if (ep_rx_submit_desc(xchan))
>> +				break;
>> +		}
>> +		dma_async_issue_pending(xchan->chan);
> [Severity: Critical]
> Can this give RX buffers back to the allocator while the MCDMA engine still
> owns them?
>
> On open, this loop posts CIRC_SPACE(0, 0, 128) = 127 descriptors in one
> batch. xilinx_mcdma_start_transfer() only reprograms the IRQ coalescing
> threshold when the batch is small enough:
>
> drivers/dma/xilinx/xilinx_dma.c:xilinx_mcdma_start_transfer() {
>      ...
> 	if (chan->desc_pendingcount <= XILINX_MCDMA_COALESCE_MAX) {
> 		reg &= ~XILINX_MCDMA_COALESCE_MASK;
> 		reg |= chan->desc_pendingcount <<
> 			XILINX_MCDMA_COALESCE_SHIFT;
> 	}
>      ...
> }
>
> XILINX_MCDMA_COALESCE_MAX is 24. With 127 pending, the threshold keeps its
> previous or reset value, which is well below 127.
>
> When the first IOC fires, xilinx_mcdma_irq_handler() calls
> xilinx_dma_complete_descriptor(). That function only checks per-BD
> completion for AXIDMA:
>
> drivers/dma/xilinx/xilinx_dma.c:xilinx_dma_complete_descriptor() {
>      ...
> 	list_for_each_entry_safe(desc, next, &chan->active_list, node) {
> 		if (chan->xdev->dma_config->dmatype == XDMA_TYPE_AXIDMA) {
> 			...
> 			if (!(seg->hw.status & XILINX_DMA_BD_COMP_MASK) && chan->has_sg)
> 				break;
> 		}
> 		...
> 		list_add_tail(&desc->node, &chan->done_list);
> 	}
> }
>
> For MCDMA, every active descriptor goes to done_list, and the tasklet runs
> ep_dma_rx_cb() for each of them. For every BD the hardware has not filled
> yet, ep_dma_rx_cb() unconditionally calls dma_unmap_single() and then frees
> the skb.
>
> The S2MM engine's CURDESC..TAILDESC chain still points at those BDs and
> buffer addresses. Would the next received frames then be written into
> freed skb memory?
>
> The descriptor segments are also recycled, and the next refill rewrites
> them while the engine is running. active_list is empty by then, so
> xilinx_mcdma_start_transfer() also rewrites CDESC on a channel that already
> has RUNSTOP set:
>
> 	if (chan->has_sg && list_empty(&chan->active_list))
> 		xilinx_write(chan, XILINX_MCDMA_CHAN_CDESC_OFFSET(chan->tdest),
> 			     head_desc->async_tx.phys);
>
> The same thing looks possible in steady state, whenever a small refill
> sets the threshold to 1 while other descriptors are still active.
>
> The commit message says dmaengine "delivers one descriptor per callback".
> That assumes per-BD completion, and this provider doesn't appear to
> provide it for MCDMA.
>
> [Severity: Medium]
> Could a partially armed batch hold received frames for an unbounded time
> when traffic is sparse?
I agree with this scenario. We will address it in a separate MCDMA
dmaengine series by adding IRQ delay support and processing completed
descriptors on delay interrupts as well as IOC interrupts, while
retaining the per BD completion check.
>
> This loop can post between 2 and 24 descriptors in one call. That happens
> if dev_alloc_skb() fails partway through, or if a callback refills several
> slots at once. xilinx_mcdma_start_transfer() then sets the coalescing
> threshold to that count, and no IOC is raised until that many frames have
> arrived.
>
> xilinx_mcdma_irq_handler() only logs the delay interrupt and reaps nothing:
>
> 	if (status & XILINX_MCDMA_IRQ_DELAY_MASK) {
> 		...
> 		dev_dbg(chan->dev, "Inter-packet latency too long\n");
> 	}
>
> No delay timer appears to be programmed for MCDMA. ep_rx_refill() returns
> true because the ring is non-empty, so the refill timer isn't armed either.
>
> Would low-rate traffic such as ARP, PTP or control frames sit in host
> memory until enough further frames arrive, or indefinitely if traffic
> stops?
>
>> +
>> +		if (xchan->ring_head != READ_ONCE(xchan->ring_tail))
>> +			return true;
> [Severity: Medium]
> What recovers this RX queue after an MCDMA channel error?
>
> On XILINX_MCDMA_IRQ_ERR_MASK, xilinx_mcdma_irq_handler() sets
> chan->err = true. An error-only interrupt completes no descriptor, because
> completion only happens under XILINX_MCDMA_IRQ_IOC_MASK. So no
> ep_dma_rx_cb() runs, and xilinx_mcdma_start_transfer() returns early while
> chan->err is set.
>
> The outstanding descriptors keep ring_head != ring_tail here. The refill
> timer is never armed and nothing new is submitted. The only automatic
> reset is in xilinx_dma_tx_submit():
>
> 	if (chan->err) {
> 		...
> 		err = xilinx_dma_chan_reset(chan);
>
> That reset needs a new submit, and none ever happens.
>
> Does the queue then stay halted until ifdown/ifup, with the interface up
> and no driver-level counter showing the problem?
I agree that the error only interrupt path can leave RX halted
without invoking an endpoint callback. IRQ delay support alone
does not resolve this issue. We will address the error notification
and recovery path separately in the MCDMA dmaengine series, taking
into account that an MCDMA reset affects the whole core.

Both issues will be addressed in the separate provider series,
rather than in this endpoint series.

Thanks
Srinivas Neeli
>
>> +
>> +		if (arm_timer)
>> +			mod_timer(&xchan->rx_refill_timer,
>> +				  jiffies + EP_RX_REFILL_RETRY);
>> +	}
>> +
>> +	return false;
>> +}
> [ ... ]
>
>> +static void ep_dma_rx_cb(void *data, const struct dmaengine_result *result)
>> +{
> [ ... ]
>
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
> [Severity: High]
> Can any frame reach __netif_rx() with the in-tree MCDMA provider?
>
> For XDMA_TYPE_AXIMCDMA, xilinx_dma_probe() installs
> xilinx_mcdma_prep_slave_sg(), and that function never sets
> async_tx.metadata_ops. DESC_METADATA_ENGINE is only set when
> has_axistream_connected is true, and that flag is only read for AXIDMA:
>
> drivers/dma/xilinx/xilinx_dma.c:xilinx_dma_probe() {
>      ...
> 	if (xdev->dma_config->dmatype == XDMA_TYPE_AXIDMA) {
> 		xdev->has_axistream_connected =
> 			of_property_read_bool(node, "xlnx,axistream-connected");
> 	}
>      ...
> 	if (xdev->has_axistream_connected)
> 		xdev->common.desc_metadata_modes = DESC_METADATA_ENGINE;
>      ...
> }
>
> So dmaengine_desc_get_metadata_ptr() looks like it always returns an
> ERR_PTR for these descriptors. The error comes either from
> desc_check_and_set_metadata_mode() or from the NULL metadata_ops check.
>
> If so, every DMA_TRANS_NOERROR completion is dropped here with "Failed to
> get RX metadata pointer". ndo_open still succeeds, so the interface comes
> up with RX dead.
>
> Wiring up the existing hook wouldn't fix this on its own.
> xilinx_dma_get_metadata_ptr() casts to the AXIDMA segment type and returns
> the app words, which start at BD offset 0x20:
>
> 	seg = list_first_entry(&desc->segments,
> 			       struct xilinx_axidma_tx_segment, node);
> 	return seg->hw.app;
>
> In struct xilinx_aximcdma_desc_hw, status is at 0x18 and sideband_status
> (TID/TDEST/TUSER) is at 0x1C. The "[0] = status, [1] = sideband" layout
> assumed here doesn't match any get_ptr in the tree. metadata[1] would be
> an app word, and the TUSER port_id filter would act on unrelated bits.
>
> metadata[1] is also read without checking meta_len.
>
> No patch in the series touches drivers/dma/. The same code is still there
> at the end of the series, in "net: xilinx: tsn: deliver endpoint RX frames
> to DSA user ports".
>
> [ ... ]
>
>> @@ -305,9 +523,19 @@ static int ep_init_dmaengine(struct xlnx_tsn_ep *ep)
>>   		rx_allocated++;
>>   	}
>>   
>> +	for (i = 0; i < ep->num_rx_queues; i++) {
>> +		if (!ep_rx_refill(ep->rx_chans[i], false)) {
>> +			dev_err(ep->dev, "RX channel %d: no descriptors armed\n",
>> +				i);
>> +			ret = -ENOMEM;
>> +			goto err_free_chans;
>> +		}
>> +	}
> [Severity: Low]
> Can ep_rx_refill() return false here even though a descriptor was armed?
>
> ep_rx_refill() decides success by testing ring_head !=
> READ_ONCE(ring_tail) after dma_async_issue_pending(). ep_dma_rx_cb()
> advances ring_tail outside rx_lock, before it calls ep_rx_refill() and
> blocks on the lock:
>
> 	WRITE_ONCE(xchan->ring_tail, xchan->ring_tail + 1);
>
> The callback runs in the provider tasklet, possibly on another CPU, and
> spin_lock_bh() only blocks BH locally.
>
> Suppose only one slot gets armed, because dev_alloc_skb() (GFP_ATOMIC) or
> prep fails on the second slot. If that frame completes before the
> head/tail test, head == tail and ep_rx_refill() returns false. ndo_open
> then fails with -ENOMEM and "no descriptors armed", even though the frame
> has already gone up through __netif_rx().
>
> Teardown after that failure looks safe. closing is set before
> ep_free_dma_chan() takes the lock and shuts down the timer.
>

