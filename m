Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.53.101
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794246247;
	b=JNV1br58DV9FkeKNBVWo45f9kEuJS1ra+SMxQALeLzg9x5az46qsidnQsxH05M3uWdFK
	 mOHESm8WaWe1XVRqMfaFZmYndPxEM/u0tjoihedai2GAvcsdiIWx4Fz8RVtY2l2eWNaVp
	 n+vp+4TWaXb70ZUhO6Pfun6+kBxMNouwAzcNsaDoB2N/i6bE5nE3bEuFSj9er6djX2eqa
	 ezcOzdvITMfPqIGLaF5AUOd+S/Rtuy92wTO0EhbDq9fOVfOenbSSCtSgqlMbRNP6GTzeP
	 KCSp70vcUvjX2KOvwK2U9pzi4TWoWDIP5OhQqrT6U72swsafJSMVYWVSOstWvRuBdhQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794246247;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-AtpMessageProperties:X-MS-Exchange-SenderADCheck:
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
	bh=78RtkPNrMtZ8rzNlAppkaqjA324Rek7vwYrwpnS0kVE=;
	b=tO3+80DH9hRRfYEn7aMMH/MKCv774nU3x0FKxdMwDFCZwK8tD8plUL2cF4cMdSrhsq4E
	 kBNneko4qnv3H1XBeBWzWu8nHGdY44N24d16PTGgzM+gcjjUsgEIMUUniJCtR/t9XZFw1
	 41wWctFxadYzaKvtdSLIBsbHYExHqWtmBlLhntQ0/9MlSZgZ1w4FBi5O/Zk1vTxetIAuX
	 Tt1CXm8Nf9nwcUa9N9//aH/ofuhJA1E1sGhJGKtLegLvLz0Kv0X1vps0b6S/xHiki+mDR
	 OOkSL7w2Fs34PA6bT5UuTtOIgivg5iAY6L4HqYAt9LUqM+XocSRzFASZPw6eqaPIhvg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=in-advantage.com;
	spf=pass smtp.mailfrom=in-advantage.com;
	dkim=pass header.d=in-advantage.com header.i=@in-advantage.com header.a=rsa-sha256 header.s=selector1 header.b=IinES69u;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.53.101
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11022101.outbound.protection.outlook.com [52.101.53.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DEC3606A330
	for <linux-rt-devel@lists.linux.dev>; Mon,  9 Nov 2026 17:44:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7DEC3606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=in-advantage.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=in-advantage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=in-advantage.com header.i=@in-advantage.com header.a=rsa-sha256 header.s=selector1 header.b=IinES69u
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yYeSTItRrYCyFdTs4fIGWMx7gBakn4Salm4jxMp5ebHzDvsp8Ss1ufQmT38XRiQ8/w8/BhGVPyp6m/dN9Y68tbVB8Un1tPN+IQkGm9lLORyG8bC2umnk9bwTn9BI5Kv4gYOBMEJ/GTpUU05MdnAhRFXZSlfqb1nZdShQZmwizGWEjHG95I1GGxB7vA/17jNNzk4YBcwRFBsmlGaT6new94sRkqLuLcTmDo/6EYesLfsJ37fsMosWKJN9/gQjfwO3SbWvPjz2TxGJ9DuG7zm0gm6krfHV+Hqm90AFVVAz1fy1/PFbaaKtjanp4UrC+NLJXcUwa/+hRMbTfg6O4XPAMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=78RtkPNrMtZ8rzNlAppkaqjA324Rek7vwYrwpnS0kVE=;
 b=TrH649pnM6pd5cBSL1z+2ur6x1Zml8DRL7E1T2KSdWhGfOh25XGS4Zt1L4/6Ac2Ar/O+KloYynZfOb4wL98f0oo8SrUDePmnhJA13qUOk8suPh1RfwBqsBCdmxtv5shKd/z+iGTQc9uNl7OP7iqo0e2iRCqllOkL8437mfGBsjTrgR3AbJa3utFL37DRDZcwacx+whTewkdYoXpYaADffpPxaby9LFb59eDkR3QNZnJejQjbddl9e9EbEmnpZFI+zOHdAQOxu4QQUOY8CBhP9ikvtQxR/o5jJzoBtZB4uWI3ZfC3EGfw/La8Urw4hst5h1nZtHE6GoPNgaoDFrRUIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=in-advantage.com; dmarc=pass action=none
 header.from=in-advantage.com; dkim=pass header.d=in-advantage.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=in-advantage.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=78RtkPNrMtZ8rzNlAppkaqjA324Rek7vwYrwpnS0kVE=;
 b=IinES69ui86uKYH1BfOaArtzCC0bBve4B57rK+tNIQi3FANje1yNegn3lUGb5WOQKtRHv0Kn6iiU4D4gQbWKdpd90FYl+Vl/Oc2whisaJPmuiFR29tcB/9CkzOgzOOjuOFwsSXBTcwj2T19uM5MJkeLrsvCYY3XB3YauRS+dsxE=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=in-advantage.com;
Received: from CH0PR10MB5290.namprd10.prod.outlook.com (2603:10b6:610:dc::14)
 by IA0PR10MB7350.namprd10.prod.outlook.com (2603:10b6:208:40e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Mon, 9 Nov
 2026 17:44:02 +0000
Received: from CH0PR10MB5290.namprd10.prod.outlook.com
 ([fe80::fd87:b9a4:818d:5ef5]) by CH0PR10MB5290.namprd10.prod.outlook.com
 ([fe80::fd87:b9a4:818d:5ef5%5]) with mapi id 15.21.0592.012; Mon, 9 Nov 2026
 17:44:02 +0000
Date: Mon, 9 Nov 2026 11:43:58 -0600
From: Colin Foster <colin.foster@in-advantage.com>
To: Jens Emil Schulz =?utf-8?Q?=C3=98stergaard?= <jensemil.schulzostergaard@microchip.com>
Cc: Linus Walleij <linusw@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Horatiu Vultur <horatiu.vultur@microchip.com>,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	Lee Jones <lee@kernel.org>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH 2/2] pinctrl: ocelot: do not use the chained irqchip
 behind a sleeping bus
Message-ID: <avIGXp9jPG-I94nz@colin-ia-desktop>
References: <20261109-ocelot-pinctrl-irqchip-fixes-v1-0-9d2d8fcd58f5@microchip.com>
 <20261109-ocelot-pinctrl-irqchip-fixes-v1-2-9d2d8fcd58f5@microchip.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261109-ocelot-pinctrl-irqchip-fixes-v1-2-9d2d8fcd58f5@microchip.com>
X-ClientProxiedBy: BN9PR03CA0544.namprd03.prod.outlook.com
 (2603:10b6:408:138::9) To CH0PR10MB5290.namprd10.prod.outlook.com
 (2603:10b6:610:dc::14)
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
X-MS-TrafficTypeDiagnostic: CH0PR10MB5290:EE_|IA0PR10MB7350:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c0bea55-caf6-4764-be92-08df3e890a8a
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|366016|7416014|376014|261022105027099003|4143699003|261021121427099003|261022075727099003|261009220027099003|261009223327099003|261009221227099003|261009223027099003|261009221727099003|261028144727099003|261026140227099003|261026121527099003|11063799006|10067099003|55112099003|18002099003|6133799003|56012099006|22082099003|261102123227099003;
X-Microsoft-Antispam-Message-Info:
	zlA0x18GMeBpztrRfS+hptOHTmItT7nvFEg7dD1+Uw37JhcC2xUd8+z/YzeGttYf0qEsIheaCxaLl30NZuFWYr/fh6oi3ZKGiJC4KDCEi/k/amyQVcieR1fX5st/PrELw0lNYRTlZ/5ehjG9lyBAjZ+RZ3WISfzsYoZS7BPyaO5sOLyUjwMyxLYbT6vGPfF61E7eEjU6EqLjTogIX1CiM2RnCaXvD1yNPPN/ydPkNvCmrUjOPamcjLieBXr7lQlKYtUKEKN8lMb5U6ZLj9c5NMxAAU29JZ1GesKZePvBborocmpKEj7FmrFj9mHMcqJnlB4jmO52U27Cu6xE/fXZAgOe+2vH/4sIvwerNTKVLCNPOn89u6LhNSOT2ickU+Joli4tD7ZcpMgPJDqrxsuKZgNNys0pd+qWnypFx8j7AyMKOTZPIhOdcd2t8r3sJ/LTKaADiAhF7mRWgEwB3+FP+nC5pNv6oLFRAOGX795ked+FUJNdWbRso7577mS/EjsqPZEmSPXDyt9BFLUsbaPdYi2gFunxODt38WMaxbBMieAIfrd8mWqoE7+NJf7uCgxDp4NzzkyjO3VwR5Sz18+vBRcFFtNRtdMhhnu/VR93IrO6UCj5q8H87fAv190aqqobw7VDSxGiYHNDdB67YzrQ2j54yqKqD1Ni5aG2inA9hgk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5290.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(366016)(7416014)(376014)(261022105027099003)(4143699003)(261021121427099003)(261022075727099003)(261009220027099003)(261009223327099003)(261009221227099003)(261009223027099003)(261009221727099003)(261028144727099003)(261026140227099003)(261026121527099003)(11063799006)(10067099003)(55112099003)(18002099003)(6133799003)(56012099006)(22082099003)(261102123227099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Rzloc2VobDkwQWJBVEt0c3puT2ZHSW9FQzFBNHNML3k5Rld1S3QwMkYxcXhH?=
 =?utf-8?B?THpSVm5uZCtyTXkxUEpRSUtxZE41N2JudHpnTFBVazVwS3UwYWcvVHBUdkhk?=
 =?utf-8?B?TVdFTWREUnRJWjlxK085WEhodUZ5TlVVam1KY25RR3dpV2s3R0VkcW0xdyty?=
 =?utf-8?B?RnFGQlNobVJsd1N3NEJqaHV0MEY0Vmx1eWNvOW95S0tEaVlzalhKaVplSEZu?=
 =?utf-8?B?RmU4OFB6WkdTTmpqSFZ5OVM0VEFZdlBJVm56MXlaSDdmU3JlRUNBS1ZiZTZa?=
 =?utf-8?B?ZTlLSUJVeDkyNHp2dlJENlFlbldXOG1oY3Zib1R0bEh0Y1RGNmNLcDBqenRV?=
 =?utf-8?B?ZUI2YnovcSsxTlhXbDVyY1UyaGRZekowTGM2R3JBMThNM2pWbUV3ZEttZG1Q?=
 =?utf-8?B?MXdJVVozbVJ1Um1TakZMYXZJOFBuWHJrRkk1UFRIZlpWRTYxVmNLWEF6eFRw?=
 =?utf-8?B?YThXK09UYmEvNW9DbGZCT2ZKR1lDSUp5b256VmNvMGFpSEgrSkpoSnU2b3Rs?=
 =?utf-8?B?eFNBcng3bjVTbjVraHJFK2I1UjV5cU5VOHFoL0FnQzVBRkVBVFY4OFp4OHF6?=
 =?utf-8?B?MXhkZURYcjBwYzVFeDJBNE82eS9MK0xycGVobE5sVnRPTEwwdkkzMTA4RTg4?=
 =?utf-8?B?bm5jWWxldzI4cGhJR2QwUXFWY0JRaVZwWExsQzNadENTcHd2M1ljQzBGNlRi?=
 =?utf-8?B?dkplSHBVSnZwNm9hOEd4aW1JQzRuKzNaek5XL0p2TEdVWUxJNHZ2QzY5RkZt?=
 =?utf-8?B?T2laZlZ1VCtnYjk4VGZOUkZKQ204TEIwWDcrVkpQa1MyNm9EZ05WS3VmLzd3?=
 =?utf-8?B?RTNiR0ExRzdjWURhTUN4WGQwYXNmOW5vUFJGRU5JVFdhNC93TFVEeS9vdFI1?=
 =?utf-8?B?SGNvUUJFZmlBZHJPMXVWc2NPcEROaVRlYUVhdWxzTGx5YUgvcFFndk4yeDB6?=
 =?utf-8?B?VmE1blNFNVNsSEdtenQyTUFBajBFS0o1bHlFSkVSdUZUNnUxaHF0bjFSMTg0?=
 =?utf-8?B?QWFUeFJ1VFpHVU04Sm0xWHRLWHZQUWdMN2hPN0JHdTJGMHZCMXU2a2o5bFVr?=
 =?utf-8?B?eUJ6MDc0TWFrdmFmSm0zWGNvQUJnWkdGdmt3WE4vSDEzZXREWVo1YkIzZlFW?=
 =?utf-8?B?YWRIa1VLZ0hPSi8rdGlraWQ0dlpkKytZbVBNaG5PNjI1UDgzQXBEYW1RazE3?=
 =?utf-8?B?aUxUbG9SMWJ6NkUrZ05DRVVIY2xvd2NZYklpSS9WOGYyS0EyMHFBTjNYTGli?=
 =?utf-8?B?Nk1pRUo2SVVLOTlUNjNJdWNuMFRmbW1jVWw4Z3Zrc0lYU0gxOS9JTDlnNWJB?=
 =?utf-8?B?SHkzcVZGWmRmQzhzLzJ6Y2JjN2F3c0hrWkZ3VzBlUS94R1lRR0FrbGVJa1l5?=
 =?utf-8?B?UGFzMVJQMllnckcwUlFnTUhDYWZJOW1CUU5BbUV1UWY0Sk9hd0xiUEVseGtT?=
 =?utf-8?B?QzFCVnlZeGJjazkxUHNDQ1VKME44UTdpUEtiKzlGMk9oS3VWd21SdDd1Uito?=
 =?utf-8?B?RUdtVVBHcHRwQnFMS3ZMSEFnaFU5SWNvSURVSzVnZ25ydHpET2Zsa1VNVUlD?=
 =?utf-8?B?VjZnelFYZ1JsZTZjMTUvcDhrWEtDMDhGUTErRzhaejdXZSt4VGdjQk84TzNG?=
 =?utf-8?B?WU13TytSYlAxdjlkMmZtWGlXcUR5bGtNdFNOSnN1M3g1VE5oVlVIVFltVzdq?=
 =?utf-8?B?TWNzbmR3YjlCN0JxMU5SVTFiVHBKVjNlNnZlMTBWQlZVYkliSnVBQlBiOG9B?=
 =?utf-8?B?Z3dscHdjSWxNSnQwSzd4cGMxQzJMODR2bXRrTnNsVE8rNjhEOXVPMXhIU3Rh?=
 =?utf-8?B?bmpWR09hQ1lWUE1QaERsTDZPSlIzdyt5WmhlQm1ZcUZlTlVhR2FjVXY0NE0z?=
 =?utf-8?B?YkEvOUcvekdUNER0N0JPWExndkg0NHBaME92bTR5aDlqMVFIWEhTZnZjamZ4?=
 =?utf-8?B?UFVuSHhhaFE3UzgrZnF4cjM1aDhXWVlrQTB4MEJCb3o3R3JkeGxlaXg5bmlM?=
 =?utf-8?B?Z2RuaDFsS1ZEbGtITU4yODZubEdjWGtIMW5JckJoV3NkUW4xczJ1d2NMQko3?=
 =?utf-8?B?MTNTQ0NaaDM2VUI2b3QvT3hBYkluZUhEdDdhdmd3N1ZBc2k3UHBJU1hTS3Fz?=
 =?utf-8?B?ZGFMZ25halFCb3BZclJDbDA4WXpYMzhuZDNhNVM3YjZ0MFROSDZ1UW9YYlFB?=
 =?utf-8?B?NDBHa3l0dFV4TGNVNExkTEt2YUl6WXdVWGpob2FZMTlSaGFEUjRvbDNiNjdh?=
 =?utf-8?B?QXZSVERJV2hMRDJVZWtTZjhFZW1RU3hoMW5pZStrdjc2dWVmbGorVGJvcStY?=
 =?utf-8?B?VDdaM1FybnJSM0NtK0xBMG1IYkdzSEF0TGlLc0NWMDUyUEVVR2hlY3dJdDdL?=
 =?utf-8?Q?5Iptw/iPCeNepKEM=3D?=
X-OriginatorOrg: in-advantage.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c0bea55-caf6-4764-be92-08df3e890a8a
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5290.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2026 17:44:02.0355
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 48e842ca-fbd8-4633-a79d-0c955a7d3aae
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a4qvNEFCrmD+ZxgCKvECEUiXw+zZuuIerE7d4IV83FjpKXpPmi0CbCILq/YCnO8oBNIELZWzPdPntLC5mLXt9AACC2FnHIgM9nXGgaQpxMo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB7350

On Mon, Nov 09, 2026 at 02:50:42PM +0100, Jens Emil Schulz Østergaard wrote:
> [You don't often get email from jensemil.schulzostergaard@microchip.com. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
> 
> Since the driver can use a regmap on a bus that can sleep, as for
> VSC7512 attached over SPI, it still registers the gpiochip as not
> sleeping and adds the chained irqchip when the node has an interrupt.
> The chained handler and the irq_chip callbacks run in atomic context and
> access the registers through that regmap, and consumers may use the
> lines of a gpiochip that is not marked as sleeping from atomic context.
> 
> Mark the gpiochip as sleeping when the regmap can sleep, and do not
> register the chained irqchip in that case.
> 
> The issue was found by code inspection and reproduced on a lan9668
> board (pcb8385) with a lan9645x attached over SPI, whose pinctrl node
> has an interrupt, by requesting an edge interrupt on one of its GPIOs
> through the GPIO character device:
> 
>   BUG: sleeping function called from invalid context at kernel/locking/mutex.c:623
>   in_atomic(): 1, irqs_disabled(): 128, non_block: 0, pid: 420, name: gpiomon
>   preempt_count: 1, expected: 0
>   locks held by gpiomon/420: 3, last CPU#0:
>    #0: 84463cd0 (&gdev->srcu){.+.+}-{0:0}, at: lineinfo_get+0x13f/0x140
>    #1: 838bbd30 (request_class){+.+.}-{4:4}, at: __setup_irq+0xe8/0x5c0
>    #2: 838bbc70 (lock_class){-...}-{2:2}, at: __setup_irq+0x104/0x5c0
>   ...
>   Call trace:
>   ...
>    mutex_lock_nested from regmap_update_bits_base+0x1c/0x80
>    regmap_update_bits_base from ocelot_irq_unmask+0x42/0x80
>    ocelot_irq_unmask from irq_enable+0x1e/0x80
>    irq_enable from irq_startup+0x64/0xc0
>    irq_startup from __setup_irq+0x38c/0x5c0
>    __setup_irq from request_threaded_irq+0x86/0x140
>    request_threaded_irq from edge_detector_setup+0x1d8/0x240
>    edge_detector_setup from linereq_create+0x3e2/0x540
>    linereq_create from gpio_ioctl+0xa4/0x240
> 
> With the fix the lan9645x gpiochip is registered as sleeping and
> without the chained irqchip, the request fails with -ENXIO instead and
> without lockdep reports.
> 
> Fixes: 181f604b33cd ("pinctrl: ocelot: add ability to be used in a non-mmio configuration")
> Signed-off-by: Jens Emil Schulz Østergaard <jensemil.schulzostergaard@microchip.com>
> ---

Thanks for the patch! I don't have the hardware setup for test right
now, but for this patch:

Reviewed-by: Colin Foster <colin.foster@in-advantage.com>

