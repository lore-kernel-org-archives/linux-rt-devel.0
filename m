Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010003.outbound.protection.outlook.com [52.101.69.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 691EA471242
	for <linux-rt-devel@lists.linux.dev>; Wed, 19 Aug 2026 11:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787140022; cv=fail; b=qnz36AJOUWqLQc/aEaW9r6EomiOywyXWyJ8XRyFjRXGlCanAB0QjVLBB5EPEoX0MlTxsbqvs51Wv+WkzdsRoJYML5Q25l9DO5yvg5nwfXujVhmEGa4KvX83M8ngnVZpd8QI5sHKp8/+/AHYs3ewE/z3G9vrpRDRne/C1UzRAXtY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787140022; c=relaxed/simple;
	bh=STE4+MwHi+mPHy9FLZdmvb30CBaO3K4HSFHZVSLUvU8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=SkU4oqc8bf+T3M4/C5C1ZMy+3rSUllAV1ubbefj9hTE/BFVH05vg/KMnMEMirgwn/n7O7CMEz5kWIk0z9x7quz6ScDc2uigcOpFkloNV160Zuqn80A10nK56fH8pxdIuiOcm+Rjjg+xxCIrk5Dr+ot/beP5Y8nCxSLvzIZoCH9Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=JUQxLees; arc=fail smtp.client-ip=52.101.69.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="JUQxLees"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kz3nTqy3L5AGPzybhdqIXHyFG3034NTSwx8ajDCg6fwvF/eBvLdLM7r0EgD62T2w7R5ylVx3nJE6Db71TPhoBDfUtbvj+nvH972wFzdvY+ueyt8eFHQnyklbqquDtj5SdTqDK85WQIRnES52Dr0QiU7CQhdwyM3twdyO7mlBloGZ1D5ParUil0HMl9q5azZ+E8YJbqXzbVInx+ce3kjx+3rH6qzGMFkMC17V3PEExqQg+CVOv9R06LbyddV1SXKaxOxtGQZeb4J47YNUtrOIzA8yYIHJfw6uoyvxIeLzv4VxLChcFHcJAiftVtZx5tTqE6nnLs/KYy0kPFw5fbf3GA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PjL/xXwJpyAI63gt4ecdIbM+gaGk4YHjtBgndKEVhZg=;
 b=VWn0ea1jbh6uLCValUfBcwO0XcrwPoPYQAaGiGJl4XhPX6k8hpVCLwQa/qAUOcGWK6VOsOi/MJsQq5Ph5Co0ICpnpFkrhO3bnK/tkPvfE919p5FWNHPDxDkfa5mYOqeHa7FLoIE/X7L6SEhY35COAhwEdR7G8KYTczt34cTJcuqVemsPg0tQhtaYvspVhmWWVzpglsz6Hd0IDqNkCszfOCXqhIIGU8dvE9pk5gW7yVo02M4We2s01HVFaB4lDpY6aLLhdXxzLMzSAYiCbhniGZxBcMcs6SfOBx6ukWDC4wl3+5BZaJUMuKwHt/UuPfZjbl97F4+H27Hxd5MyH1PhHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PjL/xXwJpyAI63gt4ecdIbM+gaGk4YHjtBgndKEVhZg=;
 b=JUQxLeeskah5eWeDs947qdZe4WSSSJqeGerrozAesFDfB4I9lBfNGYSVuUD9dEZvfZR9CqbAVetsaLdZ351LvSK0kAOOsWi4RKI5NeqoYYcncmdqDArZnuaQueKNuVt2JckPy50ON48JssgHNY1QZOAHT4LaELP+6w/h1IOmd7COOS0P6YgG6Sk1KnIHqhDEWqAt/NgVFE42h2QsnamL7btO23CAmggOo7bC9e/DH+gr6QL0NNTFHuzO3xi1HwTcSIYnqIMFTrvWhwEUhZO5yOYQ67giQchDlVrjlcj7DB0OxFDrPl04MIDF1PhFZqy0/9Yj7slA/dgc9NAkMcOYoA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by VI0PR10MB9836.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:30f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Wed, 19 Aug
 2026 11:46:53 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%2]) with mapi id 15.21.0339.007; Wed, 19 Aug 2026
 11:46:53 +0000
Message-ID: <60887e69-ae28-495c-a6d7-7d0a94fd1aa8@siemens.com>
Date: Wed, 19 Aug 2026 13:46:51 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] irq_work: Fix use-after-free in irq_work_single on
 PREEMPT_RT
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Jiayuan Chen <jiayuan.chen@linux.dev>, linux-rt-devel@lists.linux.dev,
 Steven Rostedt <rostedt@goodmis.org>, Clark Williams <clrkwllms@kernel.org>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 linux-kernel@vger.kernel.org, Florian Bezdeka <florian.bezdeka@siemens.com>
References: <20260330073234.303732-1-jiayuan.chen@linux.dev>
 <16fda1b1-2c72-4d05-b1c8-f424ac2848c6@siemens.com>
 <20260819105259.7ENaDrl2@linutronix.de>
Content-Language: en-US
From: Jan Kiszka <jan.kiszka@siemens.com>
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20260819105259.7ENaDrl2@linutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: GV0P278CA0011.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:710:26::21) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|VI0PR10MB9836:EE_
X-MS-Office365-Filtering-Correlation-Id: 18c316c3-b9fe-4405-c66f-08defde79018
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|23010399003|55112099003|22082099003|18002099003|56012099006|6133799003|11063799006|4143699003|10067099003;
X-Microsoft-Antispam-Message-Info:
	IcI9MPhXxnluZWDocmve3WEf/XPrEbM2M57g+zvtLeBq+VIw/OZeIefLvyA7NiUKPHhWyG8AD+0k3WgsZ7CKDFGc+AltjaYSFjK36otKOpQqm4KERdDmGcLSI7uUX547cnXRDHPZiNuS4jqQTZ3iZIB5t+AaiFHPJnbi6qN3aU+sXU+MHzeodBJRG5VaZ4t+hXK/VR29lvCPM9P5VnFIftsk/ovqaLXz8Qy2vxbk1mkixh62jX86wp2ckkCV9FV1sdG7zvRx7yke6PRt1tnys/I7f7CSCtymzeDMua0dsGzY2NZsgPhyj7yppIO3L47ow9ZVqKWsOykVJgqiwugP37n2rLh8Lhxws4M/bz2ZCYRR/+x8WD5NkfT5GEiEOReXPOvn2Z9yy2HIADfuNGtjzSpwRrXBiF+GZDpHPuO0CaQKaMhe4Zehl5gDYanoZjyThl/dP/OMEXMipRM4p3XqcUsEeYTRRaN31hL9jzouaG3QZ+hx+drI6G0vas3S56VRs0HKX8C5abC1cBGyIfKLlmjRxnEiNn+wI4psPb5JPz9xg9Sc2YhaQP5ezD4k8OHU4eor0/+ERKE5afMX/68r+GsNcX6RQL9LApV/rPVbPLIlh4pq3sAlbRnWv29Q1qVyaYru/w/nNTa4eJvRgm+122h5Yvh6y4JHlyLvsbNwij4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(55112099003)(22082099003)(18002099003)(56012099006)(6133799003)(11063799006)(4143699003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VlFiVnZuR0YwWXVlQitBWHlJbThwNUhsN2V2dVZ5ckNSQ1oyb2xENjhRMWZ4?=
 =?utf-8?B?MHMvWDErZS8wS092U3V1SDgxazg5SXpjSjBhSXlpZld2bTM2c1dWTUVJYVJ2?=
 =?utf-8?B?cmlUbGVReUpWRDltODY4V3A2bXdaeEZIYkhMNlVBbWtMRFZlMWNUS3dIY1FG?=
 =?utf-8?B?bHExN1BiRWtYSFA1RWU0aVh5YkxXVytibVpMcW5HcDE4cXdMc0hSbjdaUUxj?=
 =?utf-8?B?d1V3Q3BVWS8zTXdqMTRuMXBSOWI2WllKbEt4bkQ5eWxXRW9McmErRk9VWitM?=
 =?utf-8?B?WHo5MXZhSDlxY3UvR0lybUY5VmZnbWVyaFB4VVdyM0ZBZkVKMGVNVFdxekpE?=
 =?utf-8?B?amNnN21aRjE2Rm9qTDAvS1RrWlF1QWxUbExrL1pIaEdXZmpTUEZnckZVWExX?=
 =?utf-8?B?ZzZMa3RpdHg1UVhESlR0OFdvdFp4RU5FTnlZTUVpcEUyUVRXLzNyWi9XcWZ1?=
 =?utf-8?B?bzdzL3d2M1lYZjNyVnhqZXcxRmtTRG9mejRzRmt0L2IrNFR5cjdDaUJGSkJy?=
 =?utf-8?B?NEt5b0t4OS9MSmZiWGpOWHFGSGM4TUx0Y0dmTkFXSVp2amhTUFNXVDhHc09L?=
 =?utf-8?B?N2dhdVBUWnV2ay92UUwzQjd0alFXaHloNE15K0ZCQkhlaUVLTzVEbGdGN0h0?=
 =?utf-8?B?ZGw5WWZ3QXY3aEJPZkZ0RHFjVmhwT0RpbUsvanY0OGhGQzY1TE9mdXBYUVBn?=
 =?utf-8?B?Q0xrb3RWZ0l1TVdwQnVRQjJjb1NURDR0SlMvRmUyckJHTm0zc3lhbmh0dXM3?=
 =?utf-8?B?aFdudWx0eTF5Qi9MVzd0eHZGOVZ2bmkrbkkraUVLT0YxNGZUVEV2Nm5CYzAy?=
 =?utf-8?B?UXVxQk0xelROVk92Ym9mZW5CTnh3Q2VkeWxHeklacWZhbjdhTmZpOVh4NUpV?=
 =?utf-8?B?ZHdSa3czWDJNNVBMaDZIM0RQTU5FcXNZNFRqbk9PQjQvTElEekFLRkRjbXJL?=
 =?utf-8?B?NjF5ZWkzYVhtZklIbXNoUFBzYU1uMVNBVkdwdFZZSExRT0FsbE5zcjNxbVB1?=
 =?utf-8?B?YnhURmZ4N1ZuNWkwKzlRZU9leFp1MzMyVzQrNGR5cHEzbnZsZkt1VWdZNy9Q?=
 =?utf-8?B?MXY1OUlwVDFNNW5KS1pRWWQ0SlRzWlV2RVU5YWpWNFZDQ2dva0U1V1NqZkVm?=
 =?utf-8?B?NjBaV3VXK1BwV1AyL0NEc3djOUFVY0JtTzRVZmNCajBZT0ZOa1hjclpGOUhk?=
 =?utf-8?B?cW1JWlI2akVuSytGc3JCMlZHNTVlaWFIWXh5Rk9VV2UzSGFrbHNEenNKMFU0?=
 =?utf-8?B?QmJnckRyVVhDem9USHpNY3VHVmw2MTk2R3E0NXVESkx2N3hiRzM4QVowL1FT?=
 =?utf-8?B?MGNXLy82RzBOK2FaRnN5ckVNMjZCcStPdXllclRETW9zSVhHR3JRWGVZWXha?=
 =?utf-8?B?UG1JYllVSnhKakt4ZU0xWlJPMlBBb3o3ajVwM2MrY1RYQVN0NUNBM3lLa3VQ?=
 =?utf-8?B?d0FYMS9hdm1KS3JBdmpBZU8wKyswZXp5VkF4UTF3OFhjeGt4K2lqRnI5cEp2?=
 =?utf-8?B?SUFKYmdrbnovQW5XeDd4RWVGQjZKUS9EaGVESU9Vdi9wM1IrZGozWWZnUG9q?=
 =?utf-8?B?akNHbE9yVzcvcnppdXo1UzEyMXlFZUlBVk1LaFhwMEprSlg3Wno1M1Y5VFVk?=
 =?utf-8?B?V1VXeThsTUtRRXlHYzhjZWFLVEE2QmNhbDBnYzV0OWExMkhLQndob0tnK0tT?=
 =?utf-8?B?N2MyaTJxVFAwNFcwSFVyMHNybW40N0ZaM0RuY1pTWHVyaTNGQWlOOGFmNXFP?=
 =?utf-8?B?SmFvSVpVUnJMTHpjR1hYVVpGNDNJSHhGZGc2NHNXRU85VTh4TkpORWd4Mjh3?=
 =?utf-8?B?U0U0SjlOa21HakZLMHR1ZDdoeVpxY0VOLzdIVG8yTVBkWHY0YzhjZGFFMWdM?=
 =?utf-8?B?T2VhUzV5OVlobVUxVGFWeDZ0eCtZNFFscllHRmpsRS9ERjNLazZoNnFFNFBi?=
 =?utf-8?B?Vm45U1NaOTRta1ZyeFBNam5kOTE0YWhUbGE2WVNMaHBscnk3bjdVYldud2dh?=
 =?utf-8?B?SXU5a2Z1ODZrQ0RtL2Z0TkJEaWx0TFpYMEpGdmhML2lRUFhETWhHc3RCdExv?=
 =?utf-8?B?aHhvQmZ1cnluZkl3OFBZMUFiQkFGZm5VU1pSeWpJbS9vaTN6TnRiNWhMYWdt?=
 =?utf-8?B?NExKaFJRZUg3SWZrNTRtRnFGUERwVzB5R2l0Q1h3QTI3L3lOS2F1blQ5b2JK?=
 =?utf-8?B?V3k0T3RhRUJDU3RuKzV4OFQrVzJnOEdkSEY1MDA1em02R0JZQWNWQ3p6ZFdx?=
 =?utf-8?B?bXdhTDk5V2dOcHhiU0w5VVBCbFdtZm5FaGNHSWtyTEdWSjlWTmM0dndJU2M1?=
 =?utf-8?B?R1BLWTVnNWNjbEdjb0I2eitmRXhvcGZkOUVXcHc4ejA5Wk9LZlphZz09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18c316c3-b9fe-4405-c66f-08defde79018
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2026 11:46:53.1874
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iqgWnXr8KPbN3oRM1MJE+XxyCTn7FjadiVkUJhDql+CrSAfMr4CDH3uG1ycE9t27R/bK/VhU+1bemgWU+gyiVQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR10MB9836

On 19.08.26 12:52, Sebastian Andrzej Siewior wrote:
> On 2026-08-19 12:44:57 [+0200], Jan Kiszka wrote:
>> With this patch, arm 32-bit, and a single-core SoC, I got a noticeable
>> slowdown of irq_work_sync. Reverting the patch resolves this. So I dug
>> deeper, found out that things were even worse before [1], but even with
>> that, I could still see up to 2 ticks delay per call. If you combine
>> that with an unfortunate loop of irq_work_sync calls (mine is
>> out-of-tree, but I see something even "worse" in bpf_mem_alloc_destroy),
>> there is this impact.
>>
>> While this patch is motivated by PREEMPT_RT, the condition to enter the
>> modified branch are not limited to it:
> 
> It is not motivated by PREEMPT_RT. All the lazy-work has "this" problem.
> It is just on RT most of the work is stuffed into the lazy queue.

I was suspecting that already, but the patch description still reads
rt-only.

> 
>> ... || !arch_irq_work_has_interrupt()
>>
>> arch_irq_work_has_interrupt() is false on some archs, either always
>> (very rare) or under certain conditions. On arm, it's false when
>> is_smp() is false.
>>
>> If we "only" need the synchronize_rcu() for PREEMPT_RT, should we limit
>> it to that configuration? Or do we actually need otherwise as well?
>>
>> And what could be done to accelerate irq_work_sync loops? Practically, a
>> single synchronize_rcu() at the end could be enough, no?
> 
> Let me look into this again…
> 

Thanks!

I was meanwhile considering to backport the synchronize_rcu accelerator
commit. Seems to be straightforward for 6.12, but older kernels need more...

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
