Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.208.35
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793714172;
	b=vcoN9HVf3nrrzuaReQryJkmjT3YbKGaQskAUMmqs9/MNip/c/NqdC48JOL+8K4fEZDA2
	 uNflWwZagfMdXf+HIrghN+kWv/IlZW99O4A7DVHWjWqfptYOdC3bhjrCPexfO4Wfqh7i2
	 J+mTjeTSIOCSjPRmFg0IFRq4nkbMblzj0ocS3O1j77phd5liGWlLk+mxaltwJPL0w4oPx
	 v6ztaplGW3ou+c4L71K2F0sdEjmL+L9f7u1zRVgEy9rrRzDnQNT+vfSSdVAnWpSrqh0Ic
	 YUZRAu53jze66mbmXwo7AQYNwXYdKBCB7x8rMyS/7Y/I9KSgBqCo8MeuCFUesZ8chmg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793714172;
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
	bh=trCDAkt5ny3pX+tgfc3uLUlbiTJgt8LIKzS3+7yv0ow=;
	b=h+4KrjVlnf+S+aArv+R/kC2prjMcw6SCk4BuikB/oCKYhJLJtTIty1XM36yAIvtwcqgL
	 QLyYhkBn8BRgo2KMY9ywq4VfWFmGZKozOWrlT/50KUWDsP9AvMwwjuKlP2m/RrHsPpwU7
	 w5yhOZO3FQdFsGGY31jKakB76+BTm6IBxpnk4YgIy6A7iuDUhDYF832I5VBJE6Xd+eif3
	 FE2DAQcD4Eqy/Bzjv/mivK6bQPObYDEgt0wlYb6Z0DST8HVq0wAYQJ4al1vSX/8zKt2Cm
	 s9YiACP0tei2MCGnwSz/WA3vZqa80OdFmNJNLqzPvzen4Feal1xJxqSJpjTKthsactA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=nFEeCWJ9;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.208.35
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011035.outbound.protection.outlook.com [40.107.208.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BEB1606A32C
	for <linux-rt-devel@lists.linux.dev>; Tue,  3 Nov 2026 13:56:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3BEB1606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=nFEeCWJ9
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DpI3GlUph949nG826yzyd3hCZEztzSK5N1/Ti3FUTNy0CEUtllOdzftj+FTAVXjoZTWq6VoUtqJn9LBx9lYFEZ4l6olgNpVJ4o7Q0kNQXQhTyRAEEZG5GSbxSvUoFputbwvHlTZ6c2roRExOBHb9/ILwN6iupH6+7kFHEGPZxj1Cuhe+sB5965Z0VUDGvNUMb8xDl52He5JBy5G45GLPe5ck/FgBxtu9AwweCo5toZA82UzXG9Xj/p7it1BVJFpGPrM8dGLuOCbRjcp0xK7lb8NtUYWclk5tS0R4NDTvavUUUppFo6XlHKJYihjT0Yu29SFRwdXpkKAljWEGDgNGIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=trCDAkt5ny3pX+tgfc3uLUlbiTJgt8LIKzS3+7yv0ow=;
 b=NbQUGZOnw+eaEu44+vrh0lloU1mJ8XQB7dfxLQNgYwgBhYyG+BQ46DcCcJ8C/cYWc+y6Yh5jE213QTeXRAURJRoIHAABOAIPIoKMTj/Hy6gQy0qQYhWOlOVM5fDZyu1E9o0D+utQguhu1OWASnSuTFhMw4E4merpGbZSv5igqge9QalMQXBmEWYDFmGoW7M1wkmY77bxtAaJgjms8gp4QjCw3e6X0PlHLhLm7uEUva6JVFiXPziG3O8R/z8KUCyvTB6vzpaxrNISMTRhTJjhJxo9EDgkFp6bomwUz5uDC4zqQma55k+0ryMVMtTF4YZ8wdtpTcE4/VKDswMyuBUyzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=trCDAkt5ny3pX+tgfc3uLUlbiTJgt8LIKzS3+7yv0ow=;
 b=nFEeCWJ93jxjhE/9nDrDxNonWBWmwTVO5iDMwb72+a3Uu0lUwP2cntD9sprJaabeGgCULDE9zr76Noy7xDBdYscCBceeMErhosdr8BCdIEATC5SLI1D3IqSNY9Uw/GnbUOTN/UILHuK2+uy96574JAQdCpCrUc6iWtqzgC7EhsU=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SN7PR12MB8147.namprd12.prod.outlook.com (2603:10b6:806:32e::5)
 by PH7PR12MB6562.namprd12.prod.outlook.com (2603:10b6:510:212::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.8; Tue, 3 Nov 2026
 13:56:07 +0000
Received: from SN7PR12MB8147.namprd12.prod.outlook.com
 ([fe80::3923:c1a4:778b:56f2]) by SN7PR12MB8147.namprd12.prod.outlook.com
 ([fe80::3923:c1a4:778b:56f2%3]) with mapi id 15.21.0592.007; Tue, 3 Nov 2026
 13:56:07 +0000
Message-ID: <add4f327-6d01-474c-b2e2-74b32cc8543b@amd.com>
Date: Tue, 3 Nov 2026 19:25:56 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 5/8] net: xilinx: tsn: bring up the endpoint
 MCDMA channels
To: netdev-bot+sashiko@kernel.org, srinivas.neeli@amd.com
Cc: nagadheeraj.rottela@amd.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, richardcochran@gmail.com, michal.simek@amd.com,
 bigeasy@linutronix.de, clrkwllms@kernel.org, rostedt@goodmis.org,
 edumazet@kernel.org, netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rt-devel@lists.linux.dev, neelisrinivas18@gmail.com, git@amd.com
References: <20261016-patches_v2_external-v3-5-e33d3960ca1e@amd.com>
 <179249749885.3135.15584191069467566874@kernel.org>
Content-Language: en-US
From: "Neeli, Srinivas" <srneeli@amd.com>
In-Reply-To: <179249749885.3135.15584191069467566874@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA5PR01CA0259.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:21c::6) To SN7PR12MB8147.namprd12.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: SN7PR12MB8147:EE_|PH7PR12MB6562:EE_
X-MS-Office365-Filtering-Correlation-Id: bf663589-b92e-4cb8-f48f-08df39b2350f
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|23010399003|1800799024|366016|4143699003|5023799004|11063799006|56012099006|261009223027099003|261102123227099003|261022105027099003|261022075727099003|261021121427099003|261028144727099003|261026140227099003|261026121527099003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	IGRtZNkmjgjmdjlcuZHba8haYvuAzbGsd+3jPeXdcys0+Q2mJdp+Ir7cm/iVyonZtQtL4GMckIj4e/0oOQq+fGQJ1HNXlaPk+QlHSZRozkAqLgmUPldYDA/e9XCg7EfdVdmHGQUJRyQzo2j+i4IVlkXOyj7fgCDDiwP+8RE4INPMucoz9nSoinGi8kJ79x4TAQ/cPLS8SbcWHT/mkXzT4zMrdzvnT8kaq9+zgqbAWLjtfI/iHYH78vsx3vBaZRLjemotc79TOSHn1x4Jj+z7Y8K1xA7wN991UuoioEWrBgkz1uvJeBKERThSAQBMaU2r/5nOdU2GnzfpbFTZyJZAx9CoPn86jsBVC2e0b5vtwdvBLOWZJwd5fTqkRj8om/DYFJQrZdFFTTeD+TP3X1yc6Hhcq5u8Yt4X4Tk1w+MaCuhP+KSnWt6YyhQnBqKB9IUtzqYddMxhOcdr4318568nPfhKOiaHWMubkQkD9WuQX06oyXCCYI4gcy3DzGW6hQKGoAGArqqDWuBC87uvU4h+2nmgtx5rfkxRZasMgFgGjeuughngCXBT0ZLDhB8RwAJu82H+DN9qdYC6Qjwr51iqU/XThJWNxMc8z92nwoOnYyumd1MvQXzRTTVq++MKKuljEdYr33Hx+LwTgajsoVZ3W0VsXv9xH0naJg7/0V3SiOs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8147.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(23010399003)(1800799024)(366016)(4143699003)(5023799004)(11063799006)(56012099006)(261009223027099003)(261102123227099003)(261022105027099003)(261022075727099003)(261021121427099003)(261028144727099003)(261026140227099003)(261026121527099003)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WENPM2pCYTA0WU9oSGhySDN3NnRwMlgxYmFrQVBJQ2d0ZEYvWi9ma2wxYzJ4?=
 =?utf-8?B?bXBweHc3ZC9VaUZTTnljTGtrUzFGY0N5WjlldC8vdHBRQ0dETlFjb3J6QmZt?=
 =?utf-8?B?WGhGbmk3Q09pUWtaZ0FORHB3UFlrbm45cnUxUlF0YnN2aFhtbUVmOHhqbnp1?=
 =?utf-8?B?cTdSWEZlU3E4Nm9JN3NlSER0Mnp4d1hpbUJtMTJjUno0bmZQK2lWZzkwVFJp?=
 =?utf-8?B?U0NZVjZvMDFacGYzUThCbExSM1ZUVzJVQWVtc05pSmVveUpGOTNGYk1lbmJP?=
 =?utf-8?B?dHZPNitUaGVZKzkyR1Blb240anF4aXdSb3Vxd0xyaHdqYXcyMEQ4QnhCSmpK?=
 =?utf-8?B?anRaaW01TUxURVUvc3VXbnJYUFBpUGNRYmxwRG1IcEkwOG5lMldMbjdWWVNh?=
 =?utf-8?B?aGx4YytoNnpqelRiYWdFdUhwTk1ETC9Md0VVbFhNTDhIdWpseXZuN3FwdlVY?=
 =?utf-8?B?RWNRcU5QN2NCSklhS1piZmNvelVBODlOMUdNcU42S004U0lEMDVBN2VCQ2RB?=
 =?utf-8?B?ejkva2wwRlNrM0Q4NU02aktrc2xFZU1ZVmdOUFNzb2QxbTFMYlVQR3BFVkZh?=
 =?utf-8?B?TmxoZTJFVllyM3pBakJtRWpkT2ZmbGdvemE3Sm12c0IxbUtSM3Q2Y1hDVjYz?=
 =?utf-8?B?eWlva0NlcGU3OGU0eGZtSjNpZzJsMGNLbnI4b3pWdS9RT1pFNlAvK0M2d2Iv?=
 =?utf-8?B?Z2lnTmVPNUN5TVNVMjZoR2g5K1g0SU9JcFptNnZSTGFyYnBSVjV6eHhtaWNP?=
 =?utf-8?B?b0ZWU0crS3Z0aFA5YkFlMk5EZHllM21wWTdWbTNPWWlNMkYxVk9ybnBvL0hH?=
 =?utf-8?B?MDBQNkx6WVdqNENqUjlNSFBaZmh0RmVXZVZTeTNtS3R5RWowbG40bGs4amF1?=
 =?utf-8?B?VmhiSWVOSWtSQkFzVnIyL0RMeDN0Umw3VGZxOGYwMGZYd1BNWHJHaWVsUGpn?=
 =?utf-8?B?eHR4cW1ncklzM2tHM1V0NVErUk5lZWY0cEpYc3hoU2N0QUVmeGNsSU5zTFlM?=
 =?utf-8?B?TXZnNGRGRTZjckk4Qld6SldvNkhWZ1JBUGVmbFZ4ditBMERhbmJST2h1YTN2?=
 =?utf-8?B?M0xNTzhyTkVRWndnT3pWRkRjckIxV1d0WWhoaEQyQStwYWl2U01IY2VnWWY3?=
 =?utf-8?B?VlI0SWFTZzUwbFN5RWl2a1RiYTNEcS8vSlNZUm9QS0xmNWN2S3pwMjU2ckFI?=
 =?utf-8?B?OVgzTGMxWWx0cE15NXkyUDd5Z2FKdzdzRG1nZkhMN3VvcUFSeVorY0lKcHE1?=
 =?utf-8?B?OUZXM3VOWlZDd01NRmxKZlcvOS9ndGtLSmcwbTdzM1FYSDRMb3pTOEFrcTRY?=
 =?utf-8?B?cHZBTjR6aGNjUDZvdnpNQ3MzSDd3T0R2WkFOR05NMUVxbk5uWER1SGQ1bUdG?=
 =?utf-8?B?QmRnY0NXK0NBZURMMnNSdHdDR2JvcXo0di9xZGI3dlBxWllTM0c5cDIyZHJK?=
 =?utf-8?B?eEVhMjFMRFVlTnArODZnVUVna3h1cHFJS0k5czVCbHJNQ0VPL0NMaUVpUHRj?=
 =?utf-8?B?Ym1EaS92MTZFVXhGcE9PM3M2RXRXK3QxaERsZ3NlRDJuUlpBK3lJSzhvMmYx?=
 =?utf-8?B?a3gwZ1pnUGtoNkRtK0hGbVRHbDBuVFpYdFAyOUF2a1ZLc3pzeXNCT05XSWdy?=
 =?utf-8?B?aUg0d0IxZ2lZM1pVOFVFeDBiZm82MHdiR295Um5RaGl5Vzh3cFgrU3o0TllK?=
 =?utf-8?B?SHZUVFhtQzFYWlZtZ2N5RzF3WEZRZEEwM24vNndHZllQQXovWUFBSGhiQWVQ?=
 =?utf-8?B?bjF6cnQvS0ZRL2xwbWcweTdRR1VlVmZwaSs1T3JnZ2x4dGIyR3lrUUJObWcx?=
 =?utf-8?B?WHArWHBFMFJHNVJ3MnVBaGNIUjNZL2FRRUE0M3VNQ29ZeVZzeG9sTm1JYXBn?=
 =?utf-8?B?ZGh6ZkhMVXJRWWlrNnpmLzdERmpRVlptOWlTaUxsaHpPMXZsMUZ4ZDdsaEcz?=
 =?utf-8?B?UWN5dFRkZTZVbUZraGI0Smoza1lLYzB5NGtHTzRuQUxoSFEyekNZdGFhRGRl?=
 =?utf-8?B?NXRCd2RUNCtzWXBrUzIvUDdUUUlKMVdsNFBEaEMyaXMySE5aOHFQVWc5YXhW?=
 =?utf-8?B?V3AwQUI5TzZSWFZDbTJkYkFXT3pWSGdzNmFiUU9xdVhRb01HdzZyUFpmaVZ0?=
 =?utf-8?B?U215U0lzUkVoOHVWcitqZDcwRjY5S3ZsWmUvNCtoSzlqaXMycHBlS2s4TzRQ?=
 =?utf-8?B?VEo5c1FOdkxmeDhXUDYwMTRxdnhCNzgxTCtxSzk5SkZGTFdEQzJSMXhHakdh?=
 =?utf-8?B?dE9zTDVQV3N0ZUcralJNV2NEcTN1cFArTXVRc2tYdUhFa1ZDUmh0ZVJPcHpQ?=
 =?utf-8?Q?4wF3/Ny5/3ogH/70OM?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf663589-b92e-4cb8-f48f-08df39b2350f
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8147.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2026 13:56:07.0612
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5FzzqzG/HmRHf5+OFTD4W1Dh0RKSwP5UEiy2yhf1io9qDQ/l1AcipvAjcKEv8Bg/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6562

Hi,

On 10/20/2026 5:28 PM, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential
> issue(s) to consider.
>
> Critical: 0 · High: 0 · Medium: 1 · Low: 1
>
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwork
> know by including "pw-bot: cr" as a separate line at the end of your reply
> (one such reply per series is enough).
>
> - [Medium] ep_reset_dma_controller() resets the whole MCDMA core at probe
>    through one channel handle, but the driver does not own every channel…
> - [Low] In drivers/net/ethernet/xilinx/tsn/xilinx_tsn_ep.c, the kernel-
>    doc for struct skbuf_dma_descriptor calls @dma_address the "physical…
>
> --
>
> net: xilinx: tsn: bring up the endpoint MCDMA channels
>
> At probe, this patch requests every TX and RX MCDMA channel named in the
> device tree and holds them until remove. It also resets the MCDMA
> controller once, through the first TX channel. Each channel gets a ring of
> preallocated SKB descriptor slots in ndo_open, and the rings are torn down
> in ndo_stop.
>
>> diff --git a/drivers/net/ethernet/xilinx/tsn/xilinx_tsn_ep.c b/drivers/net/ethernet/xilinx/tsn/xilinx_tsn_ep.c
>> index 2adee07f6f51c..ab3d6d8cb9440 100644
>> --- a/drivers/net/ethernet/xilinx/tsn/xilinx_tsn_ep.c
>> +++ b/drivers/net/ethernet/xilinx/tsn/xilinx_tsn_ep.c
> [ ... ]
>
>> @@ -30,6 +35,47 @@
>>   #define TSN_MAX_VLAN_FRAME_SIZE		(ETH_DATA_LEN + VLAN_ETH_HLEN + \
>>   					 ETH_FCS_LEN)
>>   
>> +#define TX_BD_NUM_DEFAULT		64
>> +#define RX_BD_NUM_DEFAULT		128
>> +
>> +/**
>> + * struct skbuf_dma_descriptor - skb container for each in-flight DMA descriptor
>> + * @sgl: scatter-gather list backing the DMA mapping
>> + * @desc: dmaengine descriptor handle
>> + * @dma_address: physical address of the first sgl entry (RX path)
> [Severity: Low]
>
> This isn't a bug, but is "physical address" the right description for
> @dma_address?
Will address in next version.
> The field is a dma_addr_t. ep_free_dma_chan() passes it to
> dma_unmap_single() as a mapping handle, and in the RX data path patch
> ep_rx_submit_desc() fills it from sg_dma_address() after dma_map_single().
> If an IOMMU sits in front of the MCDMA, the value is an IOVA, not a CPU
> physical address.
>
> The same wording is still there at the end of the series. Would something
> like "DMA address of the first sgl entry" be more accurate?
>
>> + * @skb: SKB owning the buffer
>> + * @sg_len: number of valid entries in @sgl (TX path)
>> + */
> [ ... ]
>
>> +static int ep_reset_dma_controller(struct xlnx_tsn_ep *ep)
>> +{
>> +	struct xilinx_vdma_config cfg = { .reset = 1 };
>> +	int ret;
>> +
>> +	ret = xilinx_vdma_channel_set_config(ep->tx_dma[0], &cfg);
> [Severity: Medium]
>
> Can this reset stall channels on the same MCDMA instance that belong to
> another dmaengine client?
   The MCDMA instance is not shared with any other consumer in this design.
   The whole instance belongs to the endpoint, as the binding example shows.
   If a future IP revision provides per-channel reset, we will use it here
   so that only the endpoint's own channels are affected.
>
> The commit message says:
>
>    "An MCDMA soft reset resets the whole core, so any channel of the
>    instance reaches it."
>
> For MCDMA, every MM2S channel uses ctrl_offset 0, which is the common
> control register. The call chain is:
>
> xlnx_tsn_ep_probe()
>    ep_reset_dma_controller()
>      xilinx_vdma_channel_set_config()
>        xilinx_dma_chan_reset()
>          xilinx_dma_reset()
>
> drivers/dma/xilinx/xilinx_dma.c:xilinx_dma_reset() {
> 	dma_ctrl_set(chan, XILINX_DMA_REG_DMACR, XILINX_DMA_DMACR_RESET);
> 	...
> 	chan->err = false;
> 	chan->idle = true;
> 	chan->desc_pendingcount = 0;
> 	chan->desc_submitcount = 0;
> 	...
> }
>
> The hardware reset hits the whole core, but software state is only reset
> for tx_dma[0].
>
> The endpoint only requests the tx_chanN/rx_chanN entries in its own
> dma-names. Nothing in the binding or the driver stops the other channels of
> the instance from going to another consumer. Suppose one of those channels
> is mid-transfer when the endpoint probes, for example after a probe
> deferral or a module load. It is still marked idle == false and has
> descriptors on active_list. Its next submit then goes through:
>
> drivers/dma/xilinx/xilinx_dma.c:xilinx_mcdma_start_transfer() {
> 	...
> 	if (chan->has_sg && list_empty(&chan->active_list))
> 		xilinx_write(chan, XILINX_MCDMA_CHAN_CDESC_OFFSET(chan->tdest),
> 			     head_desc->async_tx.phys);
> 	...
> 	if (chan->idle)
> 		xilinx_dma_start(chan);
> 	...
> }
>
> CDESC is not reprogrammed and xilinx_dma_start() is skipped. Doesn't that
> leave the engine halted, with no error reported to that client?
>
> I could not confirm that shared MCDMA designs exist in practice. The
> binding example gives the whole instance to the endpoint.
>
> Is the reset needed at all?
   Yes, but not for the DMA channels themselves. On this IP the endpoint
   logic is reset together with the MCDMA core, so this reset is what brings
   the conduit registers into a known state at probe. Without it the
   endpoint would start from whatever  previous state  driver left behind.

Thanks
Neeli Srinivas

> The provider already resets each channel in
> xilinx_dma_chan_probe(). The MCDMA path of
> xilinx_dma_alloc_chan_resources() only allocates BD memory and does not
> program the hardware. So the endpoint's own channels look clean already,
> and the only visible effect of this reset is on channels the endpoint does
> not own.
>
> Calling dmaengine_terminate_sync() from ep_free_dma_chan() on ndo_stop also
> resets the whole core, through the provider's xilinx_dma_terminate_all().
> Any MCDMA client that terminates a channel causes this, so that part comes
> from the provider and not from this patch.
>
>> +	if (ret < 0)
>> +		return dev_err_probe(ep->dev, ret,
>> +				     "failed to reset DMA controller\n");
>> +
>> +	return 0;
>> +}
> [ ... ]
>
>> @@ -286,9 +587,17 @@ static int xlnx_tsn_ep_probe(struct platform_device *pdev)
>>   	if (ret)
>>   		goto err_free_ndev;
>>   
>> +	ret = ep_request_dma_chans(ep, rx_dma_chan_map);
>> +	if (ret)
>> +		goto err_free_ndev;
>> +
>> +	ret = ep_reset_dma_controller(ep);
>> +	if (ret)
>> +		goto err_release_chans;
>> +
> [ ... ]
>

