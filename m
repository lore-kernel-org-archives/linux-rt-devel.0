Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010029.outbound.protection.outlook.com [52.101.193.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7F8A8635D
	for <linux-rt-devel@lists.linux.dev>; Sat,  3 Oct 2026 00:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790988659; cv=fail; b=kybA27wJFwGqie+sZyTYIraY8K7nrArcv19VxqMEErbuCLnZ/LGNICxnldDAcm/fCbYs1XBsZf7/yFkMX/CtHoHeWr9WQAArmFNsCE4nMwMFQ9tN1hS4y+kRywiKEhAVtiwiZPMEc/sCDQN/1kq2gQN294JwL4XpBRm1TqbwLmw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790988659; c=relaxed/simple;
	bh=oLP3wAM0QaJyq37zx5g3R9x7yeBx8EwmfQFvu8tf+fQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=K7Jyrm8XLHsaPlfh79fRoLAxvt6svT0ZSGwRjbdH/BnNu1nivaAqkUx9B6K/G59FDDfrtH4wd2xWrtvb3KHXJKA++n8h9LxSg8FkKvASH1doH6v0k7Z5saXaAQLl/tvZGfCdb2mysd1tGgWHdhctBQM0t8fkBO3FOoT2JVn2CfU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=fbZoUFyh; arc=fail smtp.client-ip=52.101.193.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="fbZoUFyh"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cTdMxwVsyQahp8TKXStjOXAQg8jb5lSQqUPYHWGtWuNXR5bKo5dfJbzpJRKdrEIT8lKFl2w0ne7kdlOj756iME+7gttraaI25uDMFcZVZRldqnwAex8UnWHH1wThYQOoGHdknhBc7GPWmtu8hX8sq3D0DOItl5Y25Gresofxq5QGO2ndRrL5Xb2YkeR4VoRZgNIm4BISDEeeWcf7bWIcqFJ5ILIUJpaTN7/0dcnAt+8Lq9Dwa9v2UydqZG9yF/tFV+994srUIWAU/gxXKzKAQ/8+6RhRAkAEW2nJqBWmNx4xBPvwsAiYfdJk9bEZBy4xZXaW9rfAZH/YSsAK5sNDMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C0rA21nyr+/R45+iLsqYv6BDhTxA70BxAEc53F8ZQrU=;
 b=fEeoFdEaGxrNQfuUqAqp6OXQ2T7xE4GeWef0uJd+3bvBUnBQ0zWkBPkTUwtIWClWctp0DgcVoFheZN3hm5vtjaL+utSx5SY/qRAunezs0yi1jRkCqgawNEey3nD1O/nYVAl/7pvVNAa7IaK4D4CBFjJvMllk7Lo9/dCNUfSfSfVOkmk5QpLcoFaWVXjQTY+Z7mIsbj0M2K9b0u/7HGsZ7FrWVl8qLdHy3ubrxsU0BWtrgJXWGFznMN3EVNhab2P9wdhFjnkHRhmc/csng3dwgkQo6tAw3dCX1U2KZtFjbCleVlJa4axnvI6p6/x6W0Lqz/yZp1c39QYRtkXqgX86Ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C0rA21nyr+/R45+iLsqYv6BDhTxA70BxAEc53F8ZQrU=;
 b=fbZoUFyhZfdYf/muSXX3q9YjR/N9caY9SlJ15o2GMpbXHjLPKKQw1lb86CN3s0JPZSHcNNhPE3FXvMiGPYpevAEa36I1R8cXIthY5caMEf7lX6SazGSuzeZLnYvielCJqf/hKVGcrrZ1aI8gZb3Rf906Kb1nf0mfyLJSCSskEG1aBYbumF6dtIrmkVrrbizWGO13mTOnRkjHYMS/DgEyet1FIACp247rKGMAAKY6yRpq5KbZdwtTSFDLiVuA3Ysi0S9aoJ04Cp6NSgzRvti2QVwhmBXxVBbS+rbMmAxwFIutG1tuXJ6ZqV2dEIajPZQBQYPEVeLYbE3KF2v1mZBsGQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6479.namprd12.prod.outlook.com (2603:10b6:930:34::17)
 by CH3PR12MB8755.namprd12.prod.outlook.com (2603:10b6:610:17e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.16; Sat, 3 Oct
 2026 00:50:41 +0000
Received: from CY5PR12MB6479.namprd12.prod.outlook.com
 ([fe80::229a:704f:1349:5056]) by CY5PR12MB6479.namprd12.prod.outlook.com
 ([fe80::229a:704f:1349:5056%4]) with mapi id 15.21.0472.015; Sat, 3 Oct 2026
 00:50:41 +0000
Message-ID: <fe301e2c-504b-42dd-954e-a133a54aa0ce@nvidia.com>
Date: Fri, 2 Oct 2026 20:50:39 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] softirq: Preserve interrupt context during IRQ exit
To: Karl Mehltretter <kmehltretter@gmail.com>,
 Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@kernel.org>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Frederic Weisbecker <frederic@kernel.org>,
 Clark Williams <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
 Boqun Feng <boqun@kernel.org>, Lyude Paul <lyude@redhat.com>,
 Alexander Potapenko <glider@google.com>, Marco Elver <elver@google.com>,
 Jonathan Corbet <corbet@lwn.net>, Bradley Morgan <brads@mainlining.org>,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-rt-devel@lists.linux.dev
References: <20260930191432.62760-1-kmehltretter@gmail.com>
Content-Language: en-US
From: Joel Fernandes <joelagnelf@nvidia.com>
In-Reply-To: <20260930191432.62760-1-kmehltretter@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR05CA0057.namprd05.prod.outlook.com
 (2603:10b6:208:236::26) To CY5PR12MB6479.namprd12.prod.outlook.com
 (2603:10b6:930:34::17)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6479:EE_|CH3PR12MB8755:EE_
X-MS-Office365-Filtering-Correlation-Id: ab51deb8-5b29-41cb-71e9-08df20e8593b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|23010399003|366016|1800799024|376014|10067099003|56012099006|5023799004|6133799003|18002099003|22082099003|11063799006;
X-Microsoft-Antispam-Message-Info:
	TC7E60qeBeu1zDZ6zt6ylsywlEVDkJW2dSdUrb+LnWfrYjHtI0OFQ1VothDn0YIBuki3+YuUqJrKexlG81RQPQqtHiFDWHzvtuG00Me9E/0ju0N2+1SW+HTn3+TCHF93VytqWMqq2/1TLt3NRm7g7S1qiDNMnZYT+Y0rnKun6ZLoROQkDjd+MSjTOnbsyklGYSY+ltDSEGlc9/y1/XAy+s+81KecX8FSCg7OWvLu9s9YKyIaVCbnJMtAurlW1hRYJLhM4TKrtzQzkz9n6L9BWB9oT2bE0acvEVzQLpkiOPK+XHf0n6VcchM6Bbz30Xj/mCg7WjZKv/YygBm+7kBp5RAqvmO3rlbyqOFEMclPCVkpfpEDndTixPzPXRm0YOILMorrUA91CCayNAPNjlil0b35drQCPdwpOI8wkrW2QawHPsmKp8tc1DROSRzqVAYq/Mtdz0qNAoucwY+GgdnS2fWyGXrWzxNNOPtHPzyNBl9RbP3xv8RIkpOWQCExgLPd9W1rD4AUWo6AD8610vYxz1ByQLaiV0QA70UrmeU6ISLxvL6UW4u3GWUP5Z+Bu0yge2Mpen8/CRLxYv5tIo0O2SM4DGU7xl3RwFQqMsFPz6eLxEFJ/4CE4u32ZZgWIeTNud0+NrM15O/l3rvCbvNWmSELErHsKNzCbx2NEcrSwGI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6479.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(23010399003)(366016)(1800799024)(376014)(10067099003)(56012099006)(5023799004)(6133799003)(18002099003)(22082099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dlo0QVF4bnVOZGlHUkhENGtSSGFzS3pzL0JocHpZRUxDU0lCTXBUVFMxN3d0?=
 =?utf-8?B?dm5TYmVmSGpFeThZay9KaXM0eWJkTkdIVHBlMHM1dXp6OGFMMHkwWnNUTXkx?=
 =?utf-8?B?NGlqeHo0ZHp5SGtQTmh4bHVuR1hhOVNmMGxOazF6SkNrUUZOV2UxUVhWNnhh?=
 =?utf-8?B?K3IwS3BLVFVkdWpHaS9kQ0RoN3gzYmxWcDVWTWNQWUhpd3hYWWlZM3Uxektm?=
 =?utf-8?B?SC9mb21xd0gxZ2VNd1NZQmR6WWc5K0hlYTZ5RzVYY3dzVGc2Sjd3ZnFCelpn?=
 =?utf-8?B?ejh2M1JzaDIxbjRHL1c5cUJEenhvcndqNzRDeHF0SlRhTGNBNXhRWFUzNXUv?=
 =?utf-8?B?SG1CZU1xMWhxZzlVT1Q2bWlJR1FxNElzSkJjSWtEUEtwdndueERFOE9vT241?=
 =?utf-8?B?SFpmak5yMnExMFV1SURrTDhjd2t4ZmcyVWJGNCtYUURQWjRZTk1wcnNzdHNN?=
 =?utf-8?B?NUpEZFZ3M0FGVGpCc0NWTHJDLytsMHJiazRxdHdvVUF0dGZWM2cwenhVaExW?=
 =?utf-8?B?Z091NURLYWdpd013R1ZHZUZsVHVKMWt6c0oxejgvK0ROeE90ME9RbDJzbFRo?=
 =?utf-8?B?UEE4SGhvam00d1dYbk1XbnFEbGxzcXRwNlpPeDk0VGMwbzZTd0ZxekdHLzFU?=
 =?utf-8?B?TE53NE12WExNSS9zaUdYdFlWaGh1MFNCSUZZVmJTY21PRnpieG5qcXRPc0Jo?=
 =?utf-8?B?djh3cUNPMUxnUkhvVTVGNXJrbVVJdUtuNi9kMGx0M1hwK0NQZjdXUU5iNUJ6?=
 =?utf-8?B?ZEdQYytrVnF6VXlFbFVTTkcxZnFJYUorM1NwQlVzaGNTVkROR0xjSmdoMEpG?=
 =?utf-8?B?aDBZUEpKekNmR0srS1RBUzFHU1hoS2NEMzNVeHY0RG9kUHpIVWFsMzZ4bU52?=
 =?utf-8?B?VFRRcHdkaHFBZDhRYThLU0RPYzhINjdackZtUTFveG1TRmRnMEdPTTNMb3R6?=
 =?utf-8?B?YngwcHVKeEZ5T3czTm5vOGNTdlBKUVhNTE45K3E3NktXRFBid0hGY0N1RGRM?=
 =?utf-8?B?MzdLTVhrOGdPOUQ3c0hPdTRjVU5jWVFydXIrcXdOcnNwaFl3ekNaU2Ziclor?=
 =?utf-8?B?YXFLOStvd3JQWi93c0VEcDZ4Q3VkL2N6bHlMeVlRUEM2ZmoxY1JTcm1KS0lS?=
 =?utf-8?B?RzBhS3IraDlZQ2NEWkhUM0VTaStsYUk0eTl4RHBRUGNRTGEvOUhCTE1PV3hS?=
 =?utf-8?B?Yk1FNUpJVWlBNG1RcXZmbExNSGlhVmZFSGl0WkcwTzZZWCt2eHUwUEM1bzdr?=
 =?utf-8?B?YnlHTWtEb3MvSnFNaVZSMlBwcW9tZWp2ZTVEcVQzNnJFWW1lTWNoR0srRzJh?=
 =?utf-8?B?SHZqOE1WSTUxRFEvSmFVcGNZbUdIZVAxUHVwVUV1Q01XMVZ6M2JpdWNZcVNJ?=
 =?utf-8?B?NjVlOGVHVzJxS24rVFhMME9lQUZCSDd4dW5FbWd4WDY2TzhJMEZrVENyYkdK?=
 =?utf-8?B?WkdGUUs1M0FHZ21NZ0pDZ0tnSVlreTE0eC9RbExrMm9XSXZLSld3Kzh0aC9B?=
 =?utf-8?B?c1hHaXNDUFUzNzRnVW1VaWlTQ2JLbm9iWG5mZW1IcmJuSXJXZnUwQzhMR1g2?=
 =?utf-8?B?U0JKQ2F0SnFXNVQ1SlBZMzF5VlVueHp4V3VaV1FOSlczRFpDZlBTZDBCUDhN?=
 =?utf-8?B?MlpMTW82UmtHQlE4eG9wOHd5b2s4a3FYZnY0b2daZDAyNmprZXZZVytQc1l0?=
 =?utf-8?B?Y3dhSmVtdkkwaGo5cXJOb2FiY3Z4ZHR0aEoweWYyVmFOckJEN1hZVTFyeHkx?=
 =?utf-8?B?WDNkNTJ5VEhBUW8zaFlYVGJKbkVsL0RiREVMR2JtNGZKcFhtekI3Q2lMV3NH?=
 =?utf-8?B?U0hIMS9UdUcvRytNUTVjVXZZaFh5d3dVRkxMbVB6Y0dGK0VQVEttcWVQRUli?=
 =?utf-8?B?NWN3dHhKaEg0MENxd2NTTjV3NmVCVlVyZHZXT3AvYXNuZmw4WE5YYTJBYTV2?=
 =?utf-8?B?TnFEVnFiWjVGSk9yQUFHSE9NbWllMEVHMmczdUh5MHFjRW5MQTVKbnRwdE9O?=
 =?utf-8?B?cmxFbzNmcVB1eVp4djRNdXVHYTRHbUVhOVZvOHlUN3FtT0VXdzVRQXRuM3NW?=
 =?utf-8?B?QjMrcFBDZml6bk5ZUzAvMTQ2emltak1KVnNselN1bEQvdXZpR1c4ZG1oUlFC?=
 =?utf-8?B?SXdCdFVvUzRlWmtjMW9id09GMGZFa2dpRk85aS81eitKV3BZMnVxdkt3TEM5?=
 =?utf-8?B?VzRFMWIwOHFmb1hzelh4UWFzajFMb1J6SVNubEQ3R21TTnZUcDVrVC82UWs1?=
 =?utf-8?B?UnJyV3FYTnZ0MTBNMzhndGttQ3ZUNDJmbDV5NU9YWXRhM2Z2SzZPdXpleVpW?=
 =?utf-8?B?ZmdQSkFYeksya0U1SWNyL0pPd3pIcDRTYWZMSXNVV2J4S3EzekhpQT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab51deb8-5b29-41cb-71e9-08df20e8593b
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6479.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2026 00:50:41.2949
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mmoOlnpDHPs3YuJm7kaiUEISncS+ZsCbmfLYVkXs7x8xGxreaqJ7KfXEKU4AgTHIQYsDAeXlPH5Y++CnTe5h7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8755



On 9/30/2026 3:14 PM, Karl Mehltretter wrote:
> On the return from interrupt path, __irq_exit_rcu() removes
> HARDIRQ_OFFSET from the preemption counter at the very top of the
> function. Everything after that reports the current context as task
> instead of hard interrupt. The code in the function itself, such as
> invoke_softirq(), is aware of this and does not rely on the counter.
> Everything else which derives the context from preempt_count gets it
> wrong in that window:
> 
>   - ftrace, perf and the ring buffer record task context and use the
>     task recursion and context slots.
>   - KCSAN attributes the accesses to the interrupted task, KMSAN uses
>     and changes its state. KCOV and the printk caller id see a task.
>   - On PREEMPT_RT can_spin_trylock() and local_trylock() reject hard
>     interrupt context to avoid interfering with PI when the interrupted
>     task is blocked on a lock. That check does not reject calls made in
>     this window. BPF programs attached to sched_waking or sched_wakeup
>     can reach it through kmalloc_nolock().
>   - An oops kills the interrupted task instead of ending in "Fatal
>     exception in interrupt".
> 
> Tracing and the sanitizers see the wrong context in this window. No
> failure caused by this misclassification is known. The early removal of
> HARDIRQ_OFFSET predates git. lockdep is not affected because
> lockdep_hardirq_exit() is the last operation in irq_exit().
> 
> Keep HARDIRQ_OFFSET until right before tick_irq_exit(), which needs
> in_hardirq() to be false for the outermost interrupt. Softirq handlers
> must not run with HARDIRQ_OFFSET set, so softirq_handle_begin() replaces
> it with SOFTIRQ_OFFSET and softirq_handle_end() reverts that, each in a
> single raw preempt_count update. The raw operations keep the preemption
> disable location recorded by irq_enter_rcu(), and lockdep is updated by
> hand. softirq_handle_begin() detects the case with in_hardirq() because
> __do_softirq() is reached through the stack switch in
> do_softirq_own_stack() and cannot take an argument.
> 
> The checks run before HARDIRQ_OFFSET is removed. !in_interrupt() becomes
> irq_count() == HARDIRQ_OFFSET, as in irq_enter_rcu(). The timer thread
> check becomes (in_nmi() | hardirq_count()) == HARDIRQ_OFFSET. It does
> not test softirq_count(): the timer thread must also wake when the
> interrupt hit softirq processing or a section with BHs disabled.
> A softirq raised in the timer thread wakeup is handled by the timer
> thread, which handles all pending softirqs.
> 
> A softirq raised from a tracepoint on the final preempt_count_sub()
> waits for the next interrupt exit and can trigger NOHZ tick-stop
> warnings meanwhile. That is not the normal path and does not justify a
> check on every interrupt exit. A tracepoint on tick_irq_exit() already
> behaves the same way.
> 
> The number of preempt_count updates and the interrupt time accounting
> are unchanged. The preemptoff tracer now reports the interrupt and the
> softirq processing on top of it as one section, and function graph with
> nofuncgraph-irqs also skips the interrupt exit work, including the
> __do_softirq() frame.
> 
> Suggested-by: Peter Zijlstra <peterz@infradead.org>
> Link: https://lore.kernel.org/r/20260813130826.GW687043@noisy.programming.kicks-ass.net
> Assisted-by: LLM
> Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
> Reviewed-by: Bradley Morgan <brads@mainlining.org>
> Reviewed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
> 
> Notes:
>     Changes in v5:
>     - Timer thread wakeup: merge the NMI test into the hardirq test,
>       (in_nmi() | hardirq_count()) == HARDIRQ_OFFSET (Sebastian).
>     - Add Sebastian's Reviewed-by, given on v4.
>     - Rebase on v7.3-rc5. The two touched files are unchanged since rc4.
>     
>     Testing: v5 differs from v4 by that one expression. Both forms agree
>     for all 2^32 preempt_count values and at the real site on every IRQ
>     exit in four QEMU boots (arm64, arm32; plain and threadirqs; 1.1M
>     evaluations). gcc 15 emits one conditional branch less on x86-64,
>     arm64 and arm32; clang 22 on arm64, and 16 bytes less on x86-64. On
>     v7.3-rc5, base against v5 in QEMU on arm64 (virt, SMP, lockdep) and
>     arm32 (versatilepb, lockdep): boot and stress, nothing on v5 that the
>     base does not show.
>     
>     v4: https://lore.kernel.org/r/20260926143505.66024-1-kmehltretter@gmail.com
> 
>  Documentation/core-api/entry.rst | 16 +++++---
>  kernel/softirq.c                 | 65 ++++++++++++++++++++++++++------
>  2 files changed, 63 insertions(+), 18 deletions(-)
> 
> diff --git a/Documentation/core-api/entry.rst b/Documentation/core-api/entry.rst
> index 79fdaed954d9..ff3df997b151 100644
> --- a/Documentation/core-api/entry.rst
> +++ b/Documentation/core-api/entry.rst
> @@ -197,8 +197,9 @@ return true, handles NOHZ tick state and interrupt time accounting. This
>  means that up to the point where irq_enter_rcu() is invoked in_hardirq()
>  returns false.
>  
> -irq_exit_rcu() handles interrupt time accounting, undoes the preemption
> -count update and eventually handles soft interrupts and NOHZ tick state.
> +irq_exit_rcu() handles interrupt time accounting, handles soft interrupts if
> +possible, undoes the preemption count update and finally handles the NOHZ tick
> +state.
>  
>  In theory, the preemption count could be updated in irqentry_enter(). In
>  practice, deferring this update to irq_enter_rcu() allows the preemption-count
> @@ -207,10 +208,13 @@ irqentry_exit(), which are described in the next paragraph. The only downside
>  is that the early entry code up to irq_enter_rcu() must be aware that the
>  preemption count has not yet been updated with the HARDIRQ_OFFSET state.
>  
> -Note that irq_exit_rcu() must remove HARDIRQ_OFFSET from the preemption count
> -before it handles soft interrupts, whose handlers must run in BH context rather
> -than irq-disabled context. In addition, irqentry_exit() might schedule, which
> -also requires that HARDIRQ_OFFSET has been removed from the preemption count.
> +Note that soft interrupt handlers must run in BH context rather than in hard
> +interrupt context. irq_exit_rcu() therefore replaces HARDIRQ_OFFSET with
> +SOFTIRQ_OFFSET in the preemption count while it handles soft interrupts and
> +puts HARDIRQ_OFFSET back afterwards, so that the remaining interrupt exit work
> +is still attributed to the interrupt. HARDIRQ_OFFSET is removed before
> +irq_exit_rcu() returns because irqentry_exit() might schedule, which requires
> +that HARDIRQ_OFFSET has been removed from the preemption count.
>  
>  Even though interrupt handlers are expected to run with local interrupts
>  disabled, interrupt nesting is common from an entry/exit perspective. For
> diff --git a/kernel/softirq.c b/kernel/softirq.c
> index 5d02c36c40e3..288e9e37b806 100644
> --- a/kernel/softirq.c
> +++ b/kernel/softirq.c
> @@ -350,8 +350,8 @@ static inline void ksoftirqd_run_end(void)
>  	local_irq_enable();
>  }
>  
> -static inline void softirq_handle_begin(void) { }
> -static inline void softirq_handle_end(void) { }
> +static inline bool softirq_handle_begin(void) { return false; }
> +static inline void softirq_handle_end(bool from_irq_exit) { }
>  
>  static inline bool should_wake_ksoftirqd(void)
>  {
> @@ -481,15 +481,40 @@ void __local_bh_enable_ip(unsigned long ip, unsigned int cnt)
>  }
>  EXPORT_SYMBOL(__local_bh_enable_ip);
>  
> -static inline void softirq_handle_begin(void)
> +static inline bool softirq_handle_begin(void)
>  {
> -	__local_bh_disable_ip(_RET_IP_, SOFTIRQ_OFFSET);
> +	bool from_irq_exit = in_hardirq();
> +
> +	if (!from_irq_exit) {
> +		__local_bh_disable_ip(_RET_IP_, SOFTIRQ_OFFSET);
> +		return false;
> +	}
> +
> +	/*
> +	 * Only reached from irq_exit(), with HARDIRQ_OFFSET still set.
> +	 * Replace it with SOFTIRQ_OFFSET before handle_softirqs() enables
> +	 * interrupts. Use the raw operation to preserve the preemption
> +	 * disable location recorded by irq_enter_rcu(), and update lockdep
> +	 * directly.
> +	 */
> +	__preempt_count_sub(HARDIRQ_OFFSET - SOFTIRQ_OFFSET);
> +	lockdep_softirqs_off(_RET_IP_);
> +	WARN_ON_ONCE(irq_count() != SOFTIRQ_OFFSET);
> +
> +	return true;
>  }
>  
> -static inline void softirq_handle_end(void)
> +static inline void softirq_handle_end(bool from_irq_exit)
>  {
> -	__local_bh_enable(SOFTIRQ_OFFSET);
> -	WARN_ON_ONCE(in_interrupt());
> +	if (!from_irq_exit) {
> +		__local_bh_enable(SOFTIRQ_OFFSET);
> +		WARN_ON_ONCE(in_interrupt());
> +		return;
> +	}
> +
> +	lockdep_softirqs_on(_RET_IP_);
> +	__preempt_count_add(HARDIRQ_OFFSET - SOFTIRQ_OFFSET);
> +	WARN_ON_ONCE(irq_count() != HARDIRQ_OFFSET);
>  }
>  
>  static inline void ksoftirqd_run_begin(void)
> @@ -605,6 +630,7 @@ static void handle_softirqs(bool ksirqd)
>  	unsigned long old_flags = current->flags;
>  	int max_restart = MAX_SOFTIRQ_RESTART;
>  	struct softirq_action *h;
> +	bool from_irq_exit;
>  	bool in_hardirq;
>  	__u32 pending;
>  	int softirq_bit;
> @@ -618,7 +644,7 @@ static void handle_softirqs(bool ksirqd)
>  
>  	pending = local_softirq_pending();
>  
> -	softirq_handle_begin();
> +	from_irq_exit = softirq_handle_begin();
>  	in_hardirq = lockdep_softirq_start();
>  	account_softirq_enter(current);
>  
> @@ -670,7 +696,7 @@ static void handle_softirqs(bool ksirqd)
>  
>  	account_softirq_exit(current);
>  	lockdep_softirq_end(in_hardirq);
> -	softirq_handle_end();
> +	softirq_handle_end(from_irq_exit);
>  	current_restore_flags(old_flags, PF_MEMALLOC);
>  }
>  
> @@ -748,8 +774,12 @@ static inline void __irq_exit_rcu(void)
>  	lockdep_assert_irqs_disabled();
>  #endif
>  	account_hardirq_exit(current);
> -	preempt_count_sub(HARDIRQ_OFFSET);
> -	if (!in_interrupt() && local_softirq_pending()) {
> +
> +	/*
> +	 * HARDIRQ_OFFSET is still set. Only the outermost interrupt handles
> +	 * softirqs, and only if it did not hit a softirq or BH disabled section.
> +	 */
> +	if (irq_count() == HARDIRQ_OFFSET && local_softirq_pending()) {
>  		/*
>  		 * If we left hrtimers unarmed, make sure to arm them now,
>  		 * before enabling interrupts to run softirq.
> @@ -758,10 +788,21 @@ static inline void __irq_exit_rcu(void)
>  		invoke_softirq();
>  	}
>  
> +	/*
> +	 * Wake the timer thread even if the interrupt hit a softirq or a
> +	 * section with BHs disabled. Only nested interrupts and NMIs are
> +	 * excluded.
> +	 */
>  	if (IS_ENABLED(CONFIG_IRQ_FORCED_THREADING) && force_irqthreads() &&
> -	    local_timers_pending_force_th() && !(in_nmi() | in_hardirq()))
> +	    local_timers_pending_force_th() &&
> +	    (in_nmi() | hardirq_count()) == HARDIRQ_OFFSET)

Heh, I reviewed the v4 and started typing the same comment as Sebastian's only
to realize its already changed to what I was also about to suggest, so great! :)

Reviewed-by: Joel Fernandes <joelagnelf@nvidia.com>

thanks,
-- 
Joel Fernandes

