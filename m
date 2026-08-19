Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010060.outbound.protection.outlook.com [52.101.84.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDBDE43B3F4
	for <linux-rt-devel@lists.linux.dev>; Wed, 19 Aug 2026 10:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787136309; cv=fail; b=Y3Il/S6iD7x/MJEpO4vjh/KlZKofShH9jWNVjypfcWjr+lctQO3yd4bggT6nxc/BVGNMmaXuYj+NdTOiA2+1A+Jl0sB7rEB0WDUg+pQss0J7WB+c42oz+nAptSZSvWCToIMMzJn2GvvdXGB2wGB8sn2M7quBkju4NBJOA+fjiJs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787136309; c=relaxed/simple;
	bh=HRsAPdGZgWUDP3IlXGjoXEma9LHRPltUhioUW9KK/mI=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=gg7Sk0UOy6fsY8pUN4Yic6qeRkdXABnZfRVYkFeln/t7aFF4UVhKrPW6/DYeFVrdSYgt0OEkUJjGf3wNIjCLjH7WHwjJUhV6E0dqni33m+/QCS5JG4WYGHMCNR1I6D7expS3d4U3cuxsgRyGWwgS7gA18eU65FE0LqjUFe3ComY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=H5isGNXn; arc=fail smtp.client-ip=52.101.84.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="H5isGNXn"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c9zoQrMIxXHMmLI2bmkpQOnoBlyHiNuRP98yOAJ6vVHPhs1qHMyzDfBPNcEJUSagQFEivdSLX4GkllaqKEFzwGMlj/2dfCbICr3yYRUsfK9ccuP7PvgvL5RDrCdObfHHY/o/i9hdDJN9pn0HzfGrqaEQh7XPxep6eIRHwMT2lYqyYxjh0vESOpzSH7Z0mrgbL7QEV5f04cF57yYeN55921X7Yw0FQi0gDfresn85JvGpiN9c4iu2rLPhMS9Qy+2I6l9oc7jUvdNSaW6Djby7u/HorjnDMqNJnyhtRBp+8Kz0NbhKNstArAZP8lXFj0hXmOZRGz9cNSkjldzng6QaWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qyr1U8fkhOv9ra9fRE2m4yga5b9+sLqaw/WAdl07QF4=;
 b=AORRgjmifNgH2l3Lud8sxM95y0T1Ra3aACUbp7OYr5cMPtreZxvxaKrtMPBxEZ8J9r+soAge80nbnDT6CHTRTTka6dRBxkEsJs3psyDQN/6RXWNAahGhtv+SjuPdEsjE8FDizQRPMccKYmOSDVMg4cQarYsE2F2N6qV4M36V0Whmx5aUsj8iwWyr9PNBW8BB5r1Uok9Uq10KAgZYQwLU2rktDKPDbuMdC4NtF5Tnx1PdgeCKdEO8eXkkn/O6AxOkT6TvKHYBeeCAqlmU51h/VuWzXgeAmJyI8VxUADqDGpzlguXVCkLK2rWONyGq14Ji/PjMaY4TkyBZHhnwllVRIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qyr1U8fkhOv9ra9fRE2m4yga5b9+sLqaw/WAdl07QF4=;
 b=H5isGNXnW//o4rant0PO5wf4zJPz3VofiHtvynptnv5m7BuVvHhJDGFNu8Ba3oMov3DBLwYxoY0/3Bk3JriRyg7g1xAW14d4RuVwFDrD5Yw+oApkaSjIccvAGgUSh1lRq4lMAQC0WdhvpihK4hNvsJNdQgZYUfz+U5+P8hWlHOQAm3k4YJOit20lF3wW+T4h6Tj7hnTUw6eRCBRHbcW1aTms75efvd8WhjkHjvvOZ6Rvzh/WLMKaMc6E/tFibHQBre182FRxUUx8XptY4NALMhaHJ9TAvKvrNTxFhu+6FubkAC+aB9IsYzub3gS+EBW6MAcFf2NeKTzaCHhTN4E6fA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS8PR10MB6339.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:53d::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Wed, 19 Aug
 2026 10:45:00 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%2]) with mapi id 15.21.0339.007; Wed, 19 Aug 2026
 10:45:00 +0000
Message-ID: <16fda1b1-2c72-4d05-b1c8-f424ac2848c6@siemens.com>
Date: Wed, 19 Aug 2026 12:44:57 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: Re: [PATCH v2] irq_work: Fix use-after-free in irq_work_single on
 PREEMPT_RT
To: Jiayuan Chen <jiayuan.chen@linux.dev>, linux-rt-devel@lists.linux.dev,
 Steven Rostedt <rostedt@goodmis.org>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Clark Williams <clrkwllms@kernel.org>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 linux-kernel@vger.kernel.org, Florian Bezdeka <florian.bezdeka@siemens.com>
References: <20260330073234.303732-1-jiayuan.chen@linux.dev>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20260330073234.303732-1-jiayuan.chen@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0245.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f5::9) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS8PR10MB6339:EE_
X-MS-Office365-Filtering-Correlation-Id: bba9fe2d-50e4-414a-515d-08defddeeaf2
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|23010399003|10067099003|56012099006|6133799003|55112099003|22082099003|18002099003|11063799006;
X-Microsoft-Antispam-Message-Info:
	QnBbCV7nS2NkyCQKiEpj7Jk/9HvbZnZluKreWCrkZrq2+26X7+vA/sXassvho9/UT+pNR85SsbOnuCWO1zT8701kLhMSWLAS9VEUQ7AVuPMCB2P6ATvdY/tyJ8yzse1pX9XYmPNR0xOzEoH3tN7/d60xLppdljlCMTZh00ANEC9/NNo/WemGAIb2zlLseXExdVvSbpYGlktiAKeDZGYbEF8JRTQO2CPB+po4xQCLMdK9/J4pbZlOJBSyo34GNJshYYrQDAIFDdb3J7jWm8oNbkXOs2ib0zsMcBKaR7WW0xOZr75iUaFsgMOdU7hX/XCBCNxxEjyh9YBge37Ff/dgHQWZtx+E83LpVgH2UFiQfXTu0Zs5/Y3vZwSSmmID0UXWsmHDmEuOxLTZP+/wJN8eMcCH/rkwy6H7r6foODANHoomSITL+fEDcmulVD1FZ0yYLSAU3+FDU6gwR/u8NyDS42x93+L0qx6jnrmySMGuU04xOr3rEc1bjitPZF/Sdll582iQyiN5STUa83SxLNem/zEFoT1DIW2IzuVURXeS7X9u9tRA6l1ClwPrwyakDsdvcUib1VQSsHLnEmCdIB4iUhTXmLljr2nj37K4+9zG8t8bsNcUuxS6/I/CtGYxsm4NLf5T6lD5g41tsMgYKwLI6BNdpQgxdW5KOlT/N/+OZ8A=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(10067099003)(56012099006)(6133799003)(55112099003)(22082099003)(18002099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Q0Q3bCtYQkRHTWZMYlpaNlR4STcrcmIzV0E3eUl2NXJzL0RCb3VFTWpZcGZV?=
 =?utf-8?B?WHE1NCtacFRLaHUydlhwcTZjZ1VuMWNubFNneEhlZDErSm10ZmtFT3JUVkt2?=
 =?utf-8?B?UjREU0lRek9FbzNycHZ6VHRLNTFWZGVnaEVqUXVNZWRhL0JUNzJKRUI1dk02?=
 =?utf-8?B?TlhzMGNyVHQ2TUdOMEZBWVNhZ2RnU3IyaUNLQm03Rk1YWjV0bmp6S2dHN2VB?=
 =?utf-8?B?azhBNUw4cGgraXJOdE5YU3VRN2drM0k4YjZ2ZnZHMlZLRU9EMkY3OXpEMC9K?=
 =?utf-8?B?SG9sd0R6V1lOUktyS3Q4bnNzRVM1UmdoVDlZVER5cC9OdlJYOUVWQWR5ZmR3?=
 =?utf-8?B?MkhHOVI5K0FlSjBHUzVhbWFxS0JnVmhCS1MvTEN2WHpTVGhsKzNuZmpGVUdH?=
 =?utf-8?B?UTJLSWIzYTc1N3lYd2Vvc3llcllQU1JMYU03a05VQ2NyOFowdUtDV0ttNGpq?=
 =?utf-8?B?ZmUxdGs5Yzg3c3lpTDJBMWNvNFRYVTl1enptWXlsbDQ4Zkd4QUhuRmZXTUV4?=
 =?utf-8?B?QmNGRnlzUG1LbEgyOGptcm80NWxqM2x1b3RhS0VxOStxamdoSFh2dk9hSXI0?=
 =?utf-8?B?clZXZnMzMFpjdDhFdFZMNWJSNTNaS3VxR3c1L2tIblJHdHpxUEtyK1hiL2pG?=
 =?utf-8?B?cTBXb0VTN1hYYmhhRi9GaGc0cXNZWmxoYkNYUXBLY2RCelNhM3Uxam9tZldE?=
 =?utf-8?B?K3ltcm1QSmVNMTRsZFlIMnkvUUQ5UjJpNHM2ZXpMU3FuRnFLUCtNbW1rTjVz?=
 =?utf-8?B?RW81cmhDTTlsQUo4VSswZGs4QVJYdS83QlExbzk0T3JkZCswNVlTMU5JMnNT?=
 =?utf-8?B?aDZHY1dBU3pzZXVUZ2lFQnkzU2x6ZlZVWEM3UHgzTC80NWErR29XM0o4Zk1Z?=
 =?utf-8?B?UTZHcHRHSVRON2k2VU1sOVE4aFFpa1pDRTRFSGptbEhLRUZXcFZySndUeEwz?=
 =?utf-8?B?UWljS1BFaEhjTkowaHd6bTltOTJJVkR4V2F4elZZakZEbTZDRzlTV3BNYnZS?=
 =?utf-8?B?ak40VllkbHE2YnVoaHFNSEhXeHE1b2ZsVURVY2F1MXE4dW5IRERuV2hjd0VP?=
 =?utf-8?B?RlM5WDlMUm5oSXI0cVVMNEozdEdxKzcxVTloYXRlZDY1L2VhZnBkUnh3NHVp?=
 =?utf-8?B?NGNPYnU5QjlLdzlDZTNoN3U1Yktad1QxWmJpbWQwend5T3l6cFVaM2lWalV1?=
 =?utf-8?B?Z0xIT1htNVF4Qk5XSzV6UFhJSWZvVjBXQmdodkIzVU9UaDFJWjZNeEdyUzR5?=
 =?utf-8?B?NiswZkUxMGZMVWo3TmNSNDRsVzlCdDBWdWFObHg3Z09GNE14NVVaL2cyb1hz?=
 =?utf-8?B?SDY4REFyZTlZZWo3T1BDVlk1QWJHV1ZpU2MxZTRjWi9IbDlrQWo5WFkwa3FW?=
 =?utf-8?B?Z1owdHk2WXpaZGo2WVRJV2tmekNjcjNJU0lNYWw2TGdiTjVMUmVqa1duN2Rx?=
 =?utf-8?B?eVRQbS94b01icjh1bGV5Z3dVRU5SY2UrT28ya1BCUksvRnJmUlJZUzRTREFn?=
 =?utf-8?B?NmRyNVArRGw4TFFBalNOT3RIemJ1VGdrZUJHMkE4cFhrWG4rRTM5VUM5OW5q?=
 =?utf-8?B?d0dZeDdhSjZSYXNNenphcG9ENVp1bHVldXhNOHdDZWJST3huZXdFTllLOStw?=
 =?utf-8?B?TVp0d0pXdzU5YkVjYzRWRUV2ZExnL1VPd0FKRFlyK09lVzlETFlMYjA2UjBy?=
 =?utf-8?B?Y0d1VXRGeENxRFExTFQ4NkRSNlRnN3VpdmlIUExOUDJHMytpMlphM01zVnQ3?=
 =?utf-8?B?VHRYTGRtSFJ5Y2VpaUt2QmNLdW80U2k0M0NYcUttcnRIOEdsbmxxRmQ3Mnkr?=
 =?utf-8?B?Ri82b0dxUUh6SXhKUkZHeGlMck9VVCtWdEVHQmRPNzluMUx2RFc4b1RKcm8v?=
 =?utf-8?B?RGNxWDBjak9MLzRqdUVDNDdTUmFqbTcxbkZNdUJaSURoQkVrYWZrTDI1bmtk?=
 =?utf-8?B?a3BZK0w2U0paWlYxKzZxMWxFbENnUEVwbThKQjlTMEphVmNPRHVCYk9jQzZE?=
 =?utf-8?B?dE85NThYL3RGQ2VhNkl4VTF5QXk4T3ZEVG9qK0pWd3BqN3M2MUJvQkx4c0pD?=
 =?utf-8?B?eXNYUkE5dzZ0SHhjSnlPUDljTzFiM2Z1eEZUNzd2NHhWU1J1RlRYTUZqZW5M?=
 =?utf-8?B?Z0ZyemsxSzFoT0Y3c2N3aXNkL0o4eXA5MmttRkVBVHF3dGVibUFRVWxBUktp?=
 =?utf-8?B?MmJ2RTV0WkxLMHMwMC8waks4ejB4UkFJNWtqc1pvZ0JSZHEvSWJEVTQvV3Np?=
 =?utf-8?B?T3BsMlgrdW91MVFpQXRscHhYQ0ludXJqVVVNV0wwOGdxY2NNc1EzMXN3WU5S?=
 =?utf-8?B?TnZiRnlEMndMcWJyZTY4N2JlUmIwWGhmbXQyTGNMMGoyckRkTmtNUT09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bba9fe2d-50e4-414a-515d-08defddeeaf2
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2026 10:45:00.6518
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U/eXVfMYsiNrX2JnZ/Zu6cPl5p8JLKFTOlItTIsovYpnpxi2iGPlW3IjXhuN7uxZZfJpPMSRSh+oelTFmbCO+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB6339

On 30.03.26 09:32, Jiayuan Chen wrote:
> On PREEMPT_RT, non-HARD irq_work runs in per-CPU kthreads via
> run_irq_workd(), so irq_work_sync() uses rcuwait to wait for
> BUSY==0.
> 
> After irq_work_single() clears BUSY via atomic_cmpxchg(), it still
> dereferences @work for irq_work_is_hard() and rcuwait_wake_up().
> An irq_work_sync() caller on another CPU that enters after BUSY is
> cleared can observe BUSY==0 immediately, return, and free the work
> before those accesses complete — causing a use-after-free.
> 
> Fix this by wrapping run_irq_workd() in guard(rcu)() so that the
> entire irq_work_single() execution is within an RCU read-side
> critical section. Then add synchronize_rcu() in irq_work_sync()
> after rcuwait_wait_event() to ensure the caller waits for the RCU
> grace period before returning, preventing premature frees.
> 
> Fixes: 810979682ccc ("irq_work: Allow irq_work_sync() to sleep if irq_work() no IRQ support.")
> Suggested-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> Suggested-by: Steven Rostedt <rostedt@goodmis.org>
> Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
> ---
>  kernel/irq_work.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/kernel/irq_work.c b/kernel/irq_work.c
> index 73f7e1fd4ab4..bf411656c316 100644
> --- a/kernel/irq_work.c
> +++ b/kernel/irq_work.c
> @@ -292,6 +292,12 @@ void irq_work_sync(struct irq_work *work)
>  	    !arch_irq_work_has_interrupt()) {
>  		rcuwait_wait_event(&work->irqwait, !irq_work_is_busy(work),
>  				   TASK_UNINTERRUPTIBLE);
> +		/*
> +		 * Ensure irq_work_single() does not access @work
> +		 * after removing IRQ_WORK_BUSY. It is always
> +		 * accessed within a RCU-read section.
> +		 */
> +		synchronize_rcu();
>  		return;
>  	}
>  
> @@ -302,6 +308,7 @@ EXPORT_SYMBOL_GPL(irq_work_sync);
>  
>  static void run_irq_workd(unsigned int cpu)
>  {
> +	guard(rcu)();
>  	irq_work_run_list(this_cpu_ptr(&lazy_list));
>  }
>  

With this patch, arm 32-bit, and a single-core SoC, I got a noticeable
slowdown of irq_work_sync. Reverting the patch resolves this. So I dug
deeper, found out that things were even worse before [1], but even with
that, I could still see up to 2 ticks delay per call. If you combine
that with an unfortunate loop of irq_work_sync calls (mine is
out-of-tree, but I see something even "worse" in bpf_mem_alloc_destroy),
there is this impact.

While this patch is motivated by PREEMPT_RT, the condition to enter the
modified branch are not limited to it:

... || !arch_irq_work_has_interrupt()

arch_irq_work_has_interrupt() is false on some archs, either always
(very rare) or under certain conditions. On arm, it's false when
is_smp() is false.

If we "only" need the synchronize_rcu() for PREEMPT_RT, should we limit
it to that configuration? Or do we actually need otherwise as well?

And what could be done to accelerate irq_work_sync loops? Practically, a
single synchronize_rcu() at the end could be enough, no?

Jan

[1]
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=78370df5c3574cdc5c6de7844481b4dc0ef4f172

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
