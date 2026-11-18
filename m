Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.193.140
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795009052;
	b=jV2lCprkd78H+AkE29GJX3Y4yR3wAv8nrQpocwK9JACzh1A3JswFm29XbeiUcYm0S94E
	 bpOxEOxSsoR0JJvbiXUM0qx+SjOCwPNDOnc4VSMfsi/mk8YFfzZH4QwXcL31tsyO/EUKv
	 FidHeqI0hN40f4ZddNFV2mOjdtNAf1KjenpmQplN7ZHamVV2X9T20riLcdWuuhO+EpN5Y
	 b2m/ith1LPhTjI841jh3HQSDakCkZY6/wjTuBy/IwiO0p5eCItUWu8SFTe3h//gqb2rjm
	 Yo6eYJbH3koK/rM4EBtHkXcCxeAOISxNZvGoB5WdyPhXLg18ezsKw/ybO7bYIvUpGwg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795009052;
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
	bh=WpeR6k0qQ2gItIFKdESRFdGSd9F3Ovp4zIDmKUjLT5M=;
	b=h+NJLCMOvS5otEU0spHLMgHkQ4TqbmR5PuAQajcTNCO+6aH4dWPN/Cjcl3M9Jt+55TN0
	 nJnQD3Rab8+WzCQcDZJMatOw4AjOv2dCmio4WBFU8x5Aa/uM6sq3gbhP3f1hICwb8dTpq
	 waBySx57iaWCqNkwBoi94GmUedcG78dura8sbPu9aNmZClhOojLFDRKVHLgoR3BX5NiOc
	 8hfxA3kaqTzw+F8wM7+DiRdCj5I7/ckMfCECQh7I3QObPA/d5HD73fUTY2ngRJ1umX6Nw
	 P3i+gXQUvDCY3T0iSOBcqGzB2JvmZ4EhD8ngfwQKvvpJtjFWtbgUVD2zRo2t7RP1NJA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=efficios.com;
	spf=pass smtp.mailfrom=efficios.com;
	dkim=pass header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=selector1 header.b="KwnBa/0H";
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.193.140
Received: from YT6PR01CU002.outbound.protection.outlook.com (mail-canadacentralazon11022140.outbound.protection.outlook.com [40.107.193.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A51D6606A320;
	Wed, 18 Nov 2026 13:37:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A51D6606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=selector1 header.b=KwnBa/0H
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Muj/14kRX8t02ak6yi8/8seCM79SExrETNl+SRDeEp/HtdJwMDyzR0uT5saOsFkhkNrOMUWyyu6O2z12sWZshOgyNSV6lmqIoXY+a2ELq2ofx+NrQb/EfXWOv8EW1mF5ZOIfw39gVd052STOXd/83XUjUFzcDJlJd47aE4CrjYEGw55WSs/6dAYMK3xpjRyLIaYEsuZVuSfUehrWHCVz3cY0CGwq8mtLrKnrBPn22qM99MPohoAK1/erG3bbUlUc+5QZR7H03AFM3E3Ke1VoEv2RlOTWARYyHfUWFJO9zDv72wBcnSuhp4rI+EH/DunjdCeJBrDKITQitcxWWUBe9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WpeR6k0qQ2gItIFKdESRFdGSd9F3Ovp4zIDmKUjLT5M=;
 b=bJZThOtL+sUKksaoDMew9bzWad3WZOGluiwNhZiZjy4b2WjzjrAmPFXS8R/RiBjoSumLF1LXJyO7tY4T3BTflYcPlTokE99vXis93+XpI35NZk2QSVT3DahpEvUWa8PoIwyL2LdNTWC1tgLr9dC6dTd2RKKYjVCYZ6D0J3rKekONpCAZh/OaeUZN1iTxtK+vuOMQ82waBgIDsAg/Pq03fXHyWlJfOsEwBR/BK/+S43U9zQ0EJu0l8jgB5cVowOkneIR4BdpmHCaMiKL8XZwzjGMOTfdvgJw8rO9e0MR76jTzNGoNIURx26wtwn5U6wrCDBgidoh+vxDpC7VnPrC+4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WpeR6k0qQ2gItIFKdESRFdGSd9F3Ovp4zIDmKUjLT5M=;
 b=KwnBa/0HBdy4RnQZfmFTPBysS7ryNt/IByv/Vbebqr2rYMciQhBnQ29q7iVRjWTJFGM3S+dHswbIlG6xeXIukP8CAG1hbGKPymsYR9h7h0Q5uRYYalVL9rEkQOKGLP7oZYvnKntzozpUh5aesQNO5HHPVRjBw38SXnJKvi2ZT+0H/2ncEQBTctP6aruBNm9b2zRacA6vK2FZQRwYo6yZowpRjgm9sPPuwb+CY99t8RCVEIcTnhsTbRWh69+dglWqbVnZj0gxBsXJ04UmSxgnjwOW0qEEnHJLWTOoRfbftGqb+XDitrtdMJdsmQyRxwGDQywCnw6vGqhCP2Mn+R0tDw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:1d0::10) by YT4PR01MB842743.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:188::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Wed, 18 Nov
 2026 13:37:28 +0000
Received: from YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6b9e:a901:67c5:7ddc]) by YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6b9e:a901:67c5:7ddc%6]) with mapi id 15.21.0615.013; Wed, 18 Nov 2026
 13:37:28 +0000
Message-ID: <2b589346-62e4-455b-a3aa-a73782f6b679@efficios.com>
Date: Wed, 18 Nov 2026 08:37:27 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 18/40] sched/deadline: Record the root domain holding a
 task's bandwidth
To: sashiko-reviews@lists.linux.dev
Cc: linux-rt-devel@lists.linux.dev, tj@kernel.org, hannes@cmpxchg.org,
 mkoutny@suse.com, linux-kernel@vger.kernel.org
References: <cover.1794922146.git.mathieu.desnoyers@efficios.com>
 <81044090393551a0c264a8f3a7d1c3c22321c395.1794922146.git.mathieu.desnoyers@efficios.com>
 <sashiko-outbox-219040@kernel.org>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <sashiko-outbox-219040@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQZPR01CA0042.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:86::27) To YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
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
X-MS-TrafficTypeDiagnostic: YT6PR01MB491026:EE_|YT4PR01MB842743:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c392aa5-5c77-4966-8717-08df45791698
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|366016|1800799024|261022075727099003|4143699003|56012099006|261026140227099003|261028144727099003|10067099003|261022105027099003|261026121527099003|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	sVNbrkceWmCUQyHQENNLULvud4vqH0jxG+U0PJQBlDs2AfuooIGpeXiexHMAYwI/C4jN4CKrsjj09U5enb89rhZ4NutdyF5t1qAtgTIYmPwEHndepHMsx0jAygtVORQ/9rbyVDmnfL4gGnrBycQ5UXegVElPlfIVPp9ZMpqiUiO7773LJQ96wi7N6O+qlEniwN1hLchLzB6Ry91HZYBgUkyxCaShyXsyKPF8IIhQ69sv3IO46MiTpEW6zFeAK41lZaR+5Vk0vRuuhgbJCNAzWkRKGtf3UeSB7TsaXPHf45SKF4k54x+siCYvIWt/66yTS+JqhBcXW4fDeJWFMJSEfLGjZT/0CRqL0NL8GSsPqEBwMKGYzkWVAHA4tb0RXSUUyeoBySyTIW9DoLnjsTiRHGmLZJjLzzRUEs+g2YEDUhibCM4nQ9eAVY1xZzdbELonAGKafsyI3uN3KwvKopf7deKtZARP/nWTGj20CMmIGhYkr3h296OmexTeNGwHwmtX/8YDwiIeAva/70luux955bxe7EgEFIjClspqd0Jr/FDUoAiAKNqtez5mFOMQxXHON9IdrhBXTZmFDo4lbhjXFy3Wdvj5VNC7jCvUcg4K3vo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(261022075727099003)(4143699003)(56012099006)(261026140227099003)(261028144727099003)(10067099003)(261022105027099003)(261026121527099003)(22082099003)(18002099003)(3023799007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VzAzNklxVzJ5UkpEeGtwenBuNnNid1czcDBFTDl6SUVhdlcycGc1R1c0L2Ir?=
 =?utf-8?B?VVk0SzBibUtmL3BZNWxIUEJCbzJmMnB5U2RHZm5OV0dQR245S1dWSyttazRU?=
 =?utf-8?B?WnY5WC9SdVVlRTh4VDY0eWNhdG9mRjJ5eTFSRDdxeWpOdGZSdzYrdHZuTlNF?=
 =?utf-8?B?a2lkSGsyczgvTXRiVVZGZVBObVRWZkRpdXhkeTF0d2psRzVqWHU0bTMyYnRq?=
 =?utf-8?B?em8yWElXVlNhVnBsbGFuRFNkOFRjOElYZjRsVnphN0JYMVFTZ3JjSXFIcUZ2?=
 =?utf-8?B?c3ZwRmhTUXBwVnNuekM0OWIzWmE3Ly83RWJ6T3RCS2VZQUhCVDVxcHFmR29q?=
 =?utf-8?B?QUlYaVVzMnZjY0lwVXp1VTNXeGhYV3g4bU1OUCtMTi9YM3hSaGQzelFSazg3?=
 =?utf-8?B?VWFUb2JKeFk5T0txSG91WDJTZzdlYjVjQXBHOXFFZFVnd0hMWldaRFc3NSs4?=
 =?utf-8?B?WUJOVkZEK1FSQ3V2a29jWmZkT1NjR2V0d0xsU0tUM1BUb2dOaERFMjJWa0xO?=
 =?utf-8?B?VVV6Z29RWWwwMTBkYVEySlIwU0wyODBHeExLVnlDRHRKOFFaSHN1OGtKVlgy?=
 =?utf-8?B?MGZ1SVh2Mk56dGxlUG1SWUQxQ1RtL0pXUWpBYUxyTWVQbExmN1ByNHB3NWIy?=
 =?utf-8?B?dGg4aWIwOUJyNVZBUEl5MVRYRGFmQkRtYXhObmxIWEp0bC8xK1FyTENoRlBo?=
 =?utf-8?B?YzBWYXk1eEFDM2xHL21Jc1R0WTlwd0hHNkhzby95OEtkUkdva2dlS05jekwy?=
 =?utf-8?B?UUZKSHorNFlwTzZ5NGZFcm5vQnJ1R0xYRGk0TWorWnkwNnhkWG4rOWVHaWFF?=
 =?utf-8?B?YjNGRVRQM3BRclhGS3l4alo2dXBEMWE2TU5DRThnZkxBSUFoNm00Vk54czNV?=
 =?utf-8?B?d2VQTWRyNDNYYWxLV3RzMkd0SnFhOW1qQSthRE1yWkpRUnRDSTZZempXNTkz?=
 =?utf-8?B?SjNFN2ZTZ2trdjRDditBUXpMOFJ2T05aRTlwL2hLL0xINVhsd1FxWG1rYlpN?=
 =?utf-8?B?RFYrT3VMT000aFZBZHhON0hhTWxYWXhZeUM2RmUxSVQ3Q25oR0xFdE8wVmRP?=
 =?utf-8?B?Nlp4dTRwTXpvMmRBTGVBRXJ5NkU0K3U5L0FCSXRBNGxtbERXNTBVMndJbkNz?=
 =?utf-8?B?UWZYcEJ1QVhMRUhnMXozeGpoa3ZiV1cwVkpHTzVXNDdwcm1iWW1Yb2lob2xV?=
 =?utf-8?B?NjBCUC9GVFlLc1ZxK2JHaVA1dlFXaDYvbTROQWh0SDF4WHV5Mld6SmI4cDRh?=
 =?utf-8?B?Y3NBZ1JBb0VnbjNPOUZLRVRWcjVFOU9tU3VZU3pwcFBETnp3eHZhUUVySmRZ?=
 =?utf-8?B?VW1maUNhWUg3ZFBhRHFWd3ZxYW0zNUlaTFFjUTZYL3J5aU9yRGkvYlVZS1dM?=
 =?utf-8?B?RlBFOVYzVWFFbTh0RlIrKyswZ0xocW9hMStNS3VUaXhMSGF4eUFTalgzMlVx?=
 =?utf-8?B?VVpPaWhET2dVcnZhdmJMZmM3UldscmtSaW5tMDQxUGwweEl0QlVpVzlneERm?=
 =?utf-8?B?QzBTZ2RWcGIzNnJlb25ESVA5eUROcTJwaHQxa1ArcEVxM2xPNzlFeXJQMEFB?=
 =?utf-8?B?YjlnNzRIWElQMmQ2VUNoQ0UxYjlpcFhlclkzM2MzeE5nNHFrUTJmSk9DUXgv?=
 =?utf-8?B?eGcvWHlHVGdJQ1U3OUp4QjZ2dVRmRUpDbVdZbjB4c2JKQmE1dTJLQXMxNytN?=
 =?utf-8?B?QjhFQzFodU0yczZRU1VUdTE5R0NKYmJGRXF6bjg0ZnIvZ0UrbjFjZUcvQno0?=
 =?utf-8?B?S2Jjek01NDVRTjBLQmcwdWQvdDZ3T1hSSy9KVkN3VjlUM3NxMGVnOHExNHgx?=
 =?utf-8?B?VEVUcGtDRFExYldObC81M1UxWHRFbWl3S0VGTzk0d1hTdW1hSFVyYktETy9r?=
 =?utf-8?B?aklkakNWRFlHQlVRWDBKVGZQY0hDaGVHVnNUTXJ6eC9SWGo2SGIrU2JtYTV0?=
 =?utf-8?B?UjdWTDFHTU9hK29MSVZCL0VGOGQ5UHVyUXdNRUNqVTFoT0hvSE9rQ01BRFlx?=
 =?utf-8?B?YmVTdmhvZXM0T0JTNFh4dHF1cEJsSXh0NVJLRkpFdUFxeEZPdnBaNFRvVy9L?=
 =?utf-8?B?eUVmdmdVUUJQc2RSMEdqbWVOeDNJNzU1RVFsbFJpNVJDNWFEcmVEalg4ZjlK?=
 =?utf-8?B?Rmtqam4rUmxXcDRWNlFVTW80ZnJ5bGVybWRSSXhwU1N1YkZyazN5M0tuQUt4?=
 =?utf-8?B?TGFPTDRZOHVFK0dQczlQeEhXVmllYXV3MEU3R1k1c3hvako2LzV2NnEvWkt3?=
 =?utf-8?B?WEpFK0w5SndRQUNCcUJacEhYYWpJYUpmL0h4YXREc1YyV2I5ZnQ5NG5oUXM2?=
 =?utf-8?B?OUE3V2R1bDcvOGtybmtYSCtPcFQxOE9EeXZCMytiQlVMN0pZc1R5TjVwcjRz?=
 =?utf-8?Q?pz85cgvJn6rucYe+CzlOfDDBMjcF7br4rZ+cc?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c392aa5-5c77-4966-8717-08df45791698
X-MS-Exchange-CrossTenant-AuthSource: YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2026 13:37:28.3042
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JF7PVLF/ZBLhNorcgYSAX0TJ5TYeTa6hyuyrnq2fXP1vNlvX1C7Bm+WnfjIb3DwSpZjp5THMAZAGJC+4GvWw6oQAASfMciGXszjqLNOxMgY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT4PR01MB842743

> Should __sched_setscheduler() also use the root domain recorded in
> p->dl.dl_bw_cpu rather than rq->rd when validating a deadline task's
> root domain span and dl_bw.bw?

This repeats a point from v6, and the answer is the same. That EPERM is
the baseline's affinity check. This series does not change it. It is a
gate only. The admission test is sched_dl_overflow(), and it uses the
recorded CPU. So the gate can refuse wrongly, but it never admits
wrongly.

Patch 23 needs the refusal. sched_setattr() can make a task a deadline
task right after a cpuset move. That task has no recorded CPU yet. The
CPU it is on is the only one the check can use.

The hotplug case is the same check, with the same effect. Once the task
has run on its new CPUs, its parameters can be changed as usual.

The v7 cover letter lists this under "Not changed" for the partition
move. The next version widens that line to a task asleep on a CPU that
went offline. All of this was checked by reading.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com
