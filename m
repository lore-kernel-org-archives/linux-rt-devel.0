Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.189.125
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795182747;
	b=ul+8F7fVJDBIJios2xvZfq6zrwy2Qd9h+K6ZQ8IaNPwKCWtLk5nteGlkgN13Dm8NrUHx
	 YI1WfDKbiT79ZF2wB5GSjBFP2DJew71XEYl7mxiGkHotZq36tr3J8o/g9hwku2Mx65qKX
	 dzZINcW+EVwk4iOt0ZkelquheM69K5fjd878tRaUKMrDD0p3zx/2PamDVuODeyvHZ76KB
	 kBi1eZ/eIwcVCAoM66ARHp+hs6J12Uu9POuEwV7UdsAkMXCYOxcW5Ef/uo6cHGUt9sD3i
	 lZ57Mgji1Mi9RZwMuONlyNfMijE3IqYj/dyK3cSOu9e/0dlPtm2FRdPpZC6lb431jFw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795182747;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Message-ID:Date:
	 User-Agent:Subject:To:Cc:References:From:Content-Language:In-Reply-To:
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
	bh=EqCU6udiuRxSOwxjPLuQZWmjmluutnK4c3jN5/UZ9eU=;
	b=NlIYNn4TSB6Z4emErebHWTfIJRMDXSEHJvqYx01XLENjUZUZFWgZvtWUXPmnBd3JMBWl
	 dHvC6pM9tNRYeyZkBDlXFYLbCOU/28i5vgD3zfpjcRQ9IljGdsk/CwPCsIpOWV7OPlgK3
	 aS4yb3KW1ucO3hQuvEx/o3J+Pn5/jsQNw3DK+wnll6v5VsO17nyNZxJEifxUyb066l+zd
	 39kDgx/RvMAakoEefD3F6nBoLbjGbTvctxv7KTLW4juAUvX5Pp6gwfqBUZVdtBWZU+EFy
	 2wBkKBJljvabs22Yc2JRqj/nq3uOGsgj2DL1F4jqUn1T9T/r/bm9SXc+luereKIh9Vg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=efficios.com;
	spf=pass smtp.mailfrom=efficios.com;
	dkim=pass header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=selector1 header.b=hb+eZPVs;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.189.125
Received: from YT3PR01CU008.outbound.protection.outlook.com (mail-canadacentralazon11020125.outbound.protection.outlook.com [52.101.189.125])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32AA8606A325;
	Fri, 20 Nov 2026 13:52:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 32AA8606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=selector1 header.b=hb+eZPVs
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M4BkYmVKKTaLti1SUm968EUV7Ruh7LldjAXbmypwou4fPykBLepgiDqmz4YRTIh2rl2guodt8EbwoeCjW55O9v+dkyejaiwdF9jFs6MCmTCepHICOBbFRnnOKKV3/ZDqHC96A3hQzQUqrvM5hABE5yTzWBKDDgu3NVZ173gMVeibyp0WBVpkkqpjQ3uvBLV/iJdeBIB2bKIYgFwR1e4pX9cRPa2qPD3VS1V/RNd8ak8ncFNtCcePHo0Jb9BtUj5fSsyCXkJ8cHTZ1rEugUy7gHkCP4FN5HP7WA2/fGhW4WSFXickQJnGMrQxTGfdbbPeUvawfTmd0xCE2ewuEvV5BQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EqCU6udiuRxSOwxjPLuQZWmjmluutnK4c3jN5/UZ9eU=;
 b=LB/VEmtocwWo9XWD2PUvrY3+k+DJrscvSuCGtd1MMTHU94TT+FhDBcmgFqrEIVThp4qGIwaPxPNv/NuVKShukcNtGiG3Y0d/46bNJcDHfUvySQXSn9YKtB4qqD4whsW0TLBrU0+WiHU0YU4uH2cG+1Q9GkrcJuD/5U1Xqgq3Ev36TnRg+GHXszrmG1+ifhCt3ax4DuQ+5icr+2mT5oJduRBvZ8aEu4eczuHJ0OJFKVj9yDl46QKI5Y4BWHQZ5ivrtkHUZI2pxNbsksvdZgexSs6Zf5f94P6Pe87Ch9pMvgh9KffnwXPsA0vSmqpyeBtsQC/uL1Y4cAIiQHJ9cq1GiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EqCU6udiuRxSOwxjPLuQZWmjmluutnK4c3jN5/UZ9eU=;
 b=hb+eZPVsu2Z1MZDmL9+UVtqnv96N7gmlXRsno/CDmqnRv+9VQQ+x3f5XWtZgnGJxD4ZcYIkOs4GWJcHtCFfGxp/VIs0tY/5l4q40ONVcEv5La28ec0ORxIKi364+l72pShPHAYK7kLeYGTZEDMVrukwlAU+Nn0OEnv3PCYLIlcD+Hr6ISBqke9E/3bi1hZMRfCUubdC3yBcM1Z6708FvnO7/R5jadRA4T44cIc/HPbLUsZz9CTimc4i6WV6rj85SAEUiq9CZ7ib+wgowq+1HqxfqtOSE4toN7hN6ReOQ0LK8ivnRz4PyVa3Oqt5ELVf7PqQw7TBHbmfU4C0FGik36A==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:1d0::10) by YQ1PR01MB11587.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:a2::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.12; Fri, 20 Nov
 2026 13:52:23 +0000
Received: from YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6b9e:a901:67c5:7ddc]) by YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6b9e:a901:67c5:7ddc%6]) with mapi id 15.21.0639.011; Fri, 20 Nov 2026
 13:52:23 +0000
Message-ID: <8eb93fce-0161-42a2-afb8-373ee3f1bcaa@efficios.com>
Date: Fri, 20 Nov 2026 08:52:22 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 23/33] sched/deadline: Reset the donor's runtime at a
 deboost in the class
To: sashiko-reviews@lists.linux.dev
Cc: linux-rt-devel@lists.linux.dev, tj@kernel.org, hannes@cmpxchg.org,
 mkoutny@suse.com, linux-kernel@vger.kernel.org
References: <cover.1795116790.git.mathieu.desnoyers@efficios.com>
 <a6b2af72b10e67a5865158280c3955e4f8169a24.1795116791.git.mathieu.desnoyers@efficios.com>
 <sashiko-outbox-224059@kernel.org>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <sashiko-outbox-224059@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR0101CA0270.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:68::7) To YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:1d0::10)
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
X-MS-TrafficTypeDiagnostic: YT6PR01MB491026:EE_|YQ1PR01MB11587:EE_
X-MS-Office365-Filtering-Correlation-Id: b58a9c62-235b-428e-f7dd-08df470d8100
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|23010399003|5023799004|4143699003|261021121427099003|261102123227099003|56012099006|261026140227099003|261028144727099003|261022105027099003|261026121527099003|10067099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	2oXfhvCCGXaCawAueJodxfomo2I3iWkvkR7K6mHFDpqfvxKqXpNcWU+wmWOljsITDzCNGp8D9XXgB4w7bmsa10B5+Ri/4xW77QkYXh+ONjUHa2NDctThfqsk/Q2vjAgbwFuvnlt2fzFZLtpvHBCu3Ipj5dihBQA7h/K5sGslPwoXvBqF3nllnS7ajucmG5mVyvM75BII2TmT1Qv73SVarR4ZpDyjdhBRle2gdSVAbUZcBIhlC1EBuVxwnk5U5SPClJnb+b19C3MgPlTWHDESKGChnQOd9+uhLB/3EYxNweJ6Ytpk1JoCUky7hxKFVaNPlV/4JI6FN6PD2Zs7JXtZdgBeb5y9JfmdS54lit5lJD1NBs5XZUWUrArt3DMw84foVkc9ZG+74wosqX9JbMGft7LHkVy6AIL2VvLZ0WFOIrdu7dPZqUMhverIrXYgtbuAwIXFmHGsNuU6YpKqTquUQqtCMz8teqSUT7t4+2EQkfYf6Vzyw+l2KoXr1pLr0sVcF5rDOObpgBeF0UsWGPhWlj9XPMGW/WOLIX59m/AWmZm4ir/J4OMAyP9dh7yBqS5VTiJ2SXyjJkEqocshAD0zFsisZpxQK8F5p/wVl2NH70g=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(5023799004)(4143699003)(261021121427099003)(261102123227099003)(56012099006)(261026140227099003)(261028144727099003)(261022105027099003)(261026121527099003)(10067099003)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QUs5clE2SmtGZStyQmo1MU9vdHV0VzdBWTRiME1ISjVUZ2lFNkNiZWR6RFI3?=
 =?utf-8?B?a1pNUjNnWDA2a0F4UThSbGFnOGo0d2d1d1ZvMnhZdC9zYWdlL2Izdjg5NHAr?=
 =?utf-8?B?V2w5RURvRUpQU3AxVFlMZVBVU3djWXV6YmUzU0ZvbFgvU0FqT0xNT3NtN0NU?=
 =?utf-8?B?QzFMZWpXTVcwTkRrOUhSNUQxRE8zT1NiWGdPbGNvYXhXdnczS1Z2VFZaVFYr?=
 =?utf-8?B?NlRYUWtQTjVMekpFeEJCR0E0RmxZbzl1MkpHTlU0NFlvSmIxd1BWTE9yZkt2?=
 =?utf-8?B?aG9rMzFpdlJLNzROTXhNd2FPeHd2akZuQjRRLzMxM05GZEZDbDlIKy9sK1FW?=
 =?utf-8?B?ZkRRblh2dTlscXBieWNtejZPUDV2NVBzaW4xSVJnY3RadGwxZldwUEd2a2Jm?=
 =?utf-8?B?bmxuWDdqNlV0NktxbnpmZ0R3WEtRY0pRYjU2ZU5FZHNmWkYwRDV4M1dUd2xM?=
 =?utf-8?B?UHVSVXU5RUdOY3ZPOHhvTEgzV2c1b3NNY0Y2YTBFYmUwS2JaNlZGZ2FqVXZI?=
 =?utf-8?B?elorNC9HalE5WWpvOWZBa0ZzTENMUjROZFdYaFdYRy82aDZ5TGZQVGdVU0pV?=
 =?utf-8?B?K0d2RmFFZlBlT25Ic1hRZDQ0Tk5ZSDFqMlo1ekQ2dWUvaTI3clpwMktjYm1V?=
 =?utf-8?B?TmhmQzJtK3RpbFowa2pIaEdTL3N6ck90ZHdDdk1scDE0NERJR2l0QktFenRD?=
 =?utf-8?B?cFlzdUdFaTBKU3ZHV2V1blIxMFZQczhXMHl6OWFzV1dlVTVLNlliR05LR2g5?=
 =?utf-8?B?NzZLUTJkSVdKVERNc3Z1aStmYUF4V2tsaGFQR3dpV0c4bGJveWZDenl1emJZ?=
 =?utf-8?B?bmdQVW5mdUg5NVdQbjYrVk5aOVdwV3BIS1dsWVYvRG1EOWVpeUFGSFEzbERC?=
 =?utf-8?B?cjJsMDNqUkJIVmhlNUJXNUVFYWt3a0FhdDNyZk9RNG54bnY2czhFZ3k4N1V6?=
 =?utf-8?B?RUM4U1JPMEhYSis0ckJTNmpYY0lMT2pZaWp2ZlhBT3oybkpybmVTb3BvU2FG?=
 =?utf-8?B?RzRHRG92QWNhbjhkeVdOaXVtaERYWktwajVya1NqdHZQWGpPVWU5ZVNVcXZ4?=
 =?utf-8?B?a2pHWFhJbnRINlVPcTZyRW1OUUlsV1hpV2tSOFlhL0h2YjRsRnRSTlhubXdT?=
 =?utf-8?B?SjNUSTRveW1HajloeG1ZN2k5WjZzd0M2bUgyVzVQQUFxdHZra2lXRHVQTDI0?=
 =?utf-8?B?WkNsTWp4Zkx4dGRpMUZXTTZyZ083ZjFTVjFpOGVzVmVzdDJUellkMHZ0dEVr?=
 =?utf-8?B?STFMcUZBN0ttc2QyQStIdWVpN2RGL28xQmhvcjdwTTUySVVVTjFyWHVjeXNz?=
 =?utf-8?B?bnp5Mmp6NVllMFZDTWhEL1ZNcXFqTEEzbmtDT2U4VUxzY1hLcXRpUTJ6Y1or?=
 =?utf-8?B?Y2pkbGdQMTNEZ1I0QWhORHQ2dHovSnV4UUV1b2kxT2JvSmE4N0ZPT1M3cmI2?=
 =?utf-8?B?b0Vrb0U1c0lJNTUzZFlVSmxMRWJtWlF1NEcwVThlOU1uMTU3M1diUzJra3VF?=
 =?utf-8?B?ZThZQzdhdWh1VlZ0TlFLWWZvSTNrTHlmbTQ4aGtRLy9ha2YveTYyVGFKdGtn?=
 =?utf-8?B?ais0V212b0JEZ2Vud0hya2FUWTIzbDE0cm52RlNXNE14S3hxeFFZbHJPMzZN?=
 =?utf-8?B?YjlUSmM2azQrbStrNzgydERTQ2JJbjJtc3FTb09SWEFBSzhUY1J6RFJoWDFP?=
 =?utf-8?B?dzdMSmtXZUVsZ1grcGllVVRDYk1lV3J2ZlFpSjRXNmVUckdiUzVVL1hZM1hu?=
 =?utf-8?B?VXlVK3hkTWVucnYyNjR6Y3diNnlTRnIyNlpValhUTXg5QlArMk12OE1kbWsz?=
 =?utf-8?B?bFJLNlVZTDRndU13UER2RU11NXBkU0dVOVQyM01yR3M0UjRnSlUvS2xLWFU3?=
 =?utf-8?B?d25mTmdDOEFUZUp1czI0OFJhR2FRTHhsRXo4RmQ1Vy9id3pQelNCTm9XWjRB?=
 =?utf-8?B?Y0UrcDdtRldNL0JTTldwVTQ5Nm5KSGRLVnlZNnNWalZSSUozQ2NnT25Zb0dF?=
 =?utf-8?B?TGwwSktTd1EyQXdFUXgxM1lTbzgveG04U2tZRXJGby82b3J5RVJOQlJsNG5k?=
 =?utf-8?B?NXN6dzhsaVRTYURGc3loWi9pcDIwSmt2TUlrNzV0cHRqQ3VnT3doVldNSENE?=
 =?utf-8?B?Um0zWDkrRDlmQmk2bk0vdHZrNDJpaFNoS2Jnc0hWeDVFcjU5WTJMblhYT2xm?=
 =?utf-8?B?bmZyNXdjSDRsdElPdlR4ODBTWXRKSnBodnVjUGI5MWpZK1NTUnhJZjlaQWNI?=
 =?utf-8?B?OEFEaHdnbXRuQmVoZlRpZEIraXdpM2NEMU9RUlVVQzIrQ1UyQkZOYStQdExR?=
 =?utf-8?B?cXkybGVEVjg0WlpRa092Q0FXanFzRlF3Vm1VQ0lDSHRuRkM1MDNrcEhtWiti?=
 =?utf-8?Q?0GDsJ/hO+7JVR7Tq16HRGbjCUfqlqGJXC3zrR?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b58a9c62-235b-428e-f7dd-08df470d8100
X-MS-Exchange-CrossTenant-AuthSource: YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2026 13:52:23.5054
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 56EjDUhuJjrUMndeJvC38gcw+zbM3xhGv+aaXmrGzW+ChjklgaT8yyD+UL4jXMtuAc1xUwDQnZ7HitllMRTn9gXM+x/LT9SGwoWkmjXPwGc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YQ1PR01MB11587

> Can a SCHED_DEADLINE task keep a departed donor's refilled runtime and
> deadline when switching to another deadline top waiter?

Yes, and v7.4-rc2 does the same. While boosted, p runs on the runtime
left from its donors. dl_donor_refill stays set, so the final deboost
starts p's own period. Nothing of the first donor lasts past the end of
the boost. A deboost at each change of donor is possible. But it would
give p a fresh period of its own at each change.

> Should the (dl_se->runtime < 0 || dl_se->dl_yielded) path also call
> dl_note_donor_refill(dl_se)?

No. That branch refills nothing. It sets to 0 the runtime of an entity
whose own runtime is spent, or that yielded. If a donor refilled p
before, the flag is already set. If not, the runtime and the deadline
are p's own. Throttling p until its next period is then right. Setting
the flag there would give p a free period at the deboost.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com
