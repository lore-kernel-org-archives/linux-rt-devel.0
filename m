Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795812296;
	b=x//u/33VVcVMfFX2zMfr0DvRIJ4t0+PKIulvwpJPcI+O6tvfT3/15OW5GxcTnaLyu+7n
	 D/WaH9BgiPz3KSzwm92/KR/AprXj7HYZDXEqDGGM0sIsf5Ddi+k7/5ygMaCA9CnEwwm0M
	 0X1/cgpPCin0/eXX2y4dX3LBgqR+HZgzaKvYcfZM1zAUkJl4oVEc6rz8hD1/MmYsVzzSq
	 z3e/jCjSrjOyJiqTihLU6j8hota+hOm4CLens5r1COnX73IfrAEfILuk3M9zlpzgnbycY
	 xXwQ136W+cCj0plMnrC+FaEZY2hBVyA0peGQAqSOFZKcfAOz+pw2xdHVv4F6EsCiRuQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795812296;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:Content-Language:To:Cc:References:From:Autocrypt:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=8oIwSCYAsSdf1LAvWDTBKjlpUCVHpz4kl7MW/c3JRPs=;
	b=ZnlZNvpOQrsYTD0WBap1b87D9wHDBAlnjf/jsqNNbP71dkWd+Q2wWK+CJRGyjCSQvgDF
	 yvjLcbzkdeJ9ocU5pEPdcFg0VNt8UkPJSggivb4qye+MVqav7jaSz4ZIIs4V3kaU+gG4+
	 R9NqEHlWs6Dd4FlfCi3kypiBSgPfSPj0Q+2njyhQHAf6D4QU0ZiP87XQnxu465kEWEamI
	 tMb/412ZdDz1ps+C9/CyJIRLN3EDYaVJoAakJwLv38IAC30/4Vu6UN9VXYQ6jhUaI5Y4n
	 ihOEZcfCtjatkLKrESrLwDsbDhMC78Q5Z06srmkyLviEFtnMSCvznO0dHOS5n99uz/Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Muc9qVc0;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 924C6606A31E;
	Fri, 27 Nov 2026 20:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Muc9qVc0
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC9831F00897;
	Fri, 27 Nov 2026 20:44:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795812295;
	bh=8oIwSCYAsSdf1LAvWDTBKjlpUCVHpz4kl7MW/c3JRPs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=Muc9qVc0m3CeIAByLTfPnCpj9zdn9rHzKJ1WhMggzvtRI76teDyeDumWZhYXZrDyW
	 SNP5SG+f7Fym/eXHLelXXxvSj4sAgoouB3Wk+o2++jQuLcREFJz/SNsS7Y275xOAUL
	 6XxxzG4GfbTfAsQx2pl8cIPdjleFCi54ZTcNqhnhfi+nUWlDT3cWf8ytMY/3CUcHiu
	 zrdbCWavYJagU2m/+hH8KtsxqZdUhb/BzCWv/Ew5t+GUnnccd/LEIwWETxSmuDK9WE
	 sn+URm29xaOz7UEfDZlJLUPPzRs50oKeUJsei/9uhPaJ4Pex1UiXLpCh/3NBlxIhCO
	 9PyofcLNyXdlQ==
Message-ID: <5c553fca-3a7a-4bd6-b41a-00594f854440@kernel.org>
Date: Fri, 27 Nov 2026 21:44:52 +0100
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Post: <mailto:linux-rt-devel@lists.linux.dev>
List-Help: <mailto:linux-rt-devel+help@lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
List-Owner: <mailto:linux-rt-devel+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] irq_work: Fix use-after-free in irq_work_single on
 PREEMPT_RT
Content-Language: en-US
To: Jan Kiszka <jan.kiszka@siemens.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Harry Yoo <harry@kernel.org>
Cc: Jiayuan Chen <jiayuan.chen@linux.dev>, linux-rt-devel@lists.linux.dev,
 Steven Rostedt <rostedt@goodmis.org>, Clark Williams <clrkwllms@kernel.org>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 linux-kernel@vger.kernel.org, Florian Bezdeka <florian.bezdeka@siemens.com>
References: <20260330073234.303732-1-jiayuan.chen@linux.dev>
 <16fda1b1-2c72-4d05-b1c8-f424ac2848c6@siemens.com>
 <20260819105259.7ENaDrl2@linutronix.de>
 <60887e69-ae28-495c-a6d7-7d0a94fd1aa8@siemens.com>
From: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
Autocrypt: addr=vbabka@kernel.org; keydata=
 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
In-Reply-To: <60887e69-ae28-495c-a6d7-7d0a94fd1aa8@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 8/19/26 13:46, Jan Kiszka wrote:
> On 19.08.26 12:52, Sebastian Andrzej Siewior wrote:
>> On 2026-08-19 12:44:57 [+0200], Jan Kiszka wrote:
>>> With this patch, arm 32-bit, and a single-core SoC, I got a noticeable
>>> slowdown of irq_work_sync. Reverting the patch resolves this. So I dug
>>> deeper, found out that things were even worse before [1], but even with
>>> that, I could still see up to 2 ticks delay per call. If you combine
>>> that with an unfortunate loop of irq_work_sync calls (mine is
>>> out-of-tree, but I see something even "worse" in bpf_mem_alloc_destroy),
>>> there is this impact.
>>>
>>> While this patch is motivated by PREEMPT_RT, the condition to enter the
>>> modified branch are not limited to it:
>> 
>> It is not motivated by PREEMPT_RT. All the lazy-work has "this" problem.
>> It is just on RT most of the work is stuffed into the lazy queue.
> 
> I was suspecting that already, but the patch description still reads
> rt-only.
> 
>> 
>>> ... || !arch_irq_work_has_interrupt()
>>>
>>> arch_irq_work_has_interrupt() is false on some archs, either always
>>> (very rare) or under certain conditions. On arm, it's false when
>>> is_smp() is false.
>>>
>>> If we "only" need the synchronize_rcu() for PREEMPT_RT, should we limit
>>> it to that configuration? Or do we actually need otherwise as well?
>>>
>>> And what could be done to accelerate irq_work_sync loops? Practically, a
>>> single synchronize_rcu() at the end could be enough, no?
>> 
>> Let me look into this again…
>> 
> 
> Thanks!
> 
> I was meanwhile considering to backport the synchronize_rcu accelerator
> commit. Seems to be straightforward for 6.12, but older kernels need more...
> 
> Jan
 
Hi, 

for slab we recently got proposed the AI fix below. While it seems correct
to me, it feels wrong to do such an ad-hoc workaround. I'd expect there
would be other cases where the work is static and no UAF can exist. Can we
accomodate them in a generic way? Thanks.

----8<----
From: Chris Mason <mason@kernel.org>

On PREEMPT_RT, or on an architecture without an irq_work interrupt,
destroying a slab cache stalls for two RCU grace periods per possible
CPU. kvfree_rcu_barrier() stalls for one grace period per possible CPU.
Tasks that do either at the same time also wait for each other.

deferred_work_barrier() calls irq_work_sync() on the deferred work of
each possible CPU. kmem_cache_destroy() calls the barrier twice, and
kvfree_rcu_barrier() calls it once.

Commit 91840be8f710 ("irq_work: Fix use-after-free in
irq_work_single() on PREEMPT_RT") added a synchronize_rcu() at the end
of irq_work_sync(), so that the caller can free the work afterwards.
Only the kernels named above have it, since irq_work_sync() sleeps on
them instead of spinning. Before that commit irq_work_sync() returned at
once for an idle work. Now it waits for a grace period for an idle work
too.

But the deferred works are static per-CPU data that nobody frees, so the
use-after-free that the grace period prevents cannot happen here. The
barrier also runs its whole loop under a global mutex, added by
"mm/slab: serialize deferred_work_barrier()".

The fix used here is to call irq_work_sync() only for a work that is
busy.

Fixes: 91840be8f710 ("irq_work: Fix use-after-free in irq_work_single() on PREEMPT_RT")
Signed-off-by: Chris Mason <mason@kernel.org>
Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
 mm/slub.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index 3b8ac5310d07f..3318e94350947 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -6624,8 +6624,17 @@ void deferred_work_barrier(void)
 	/* irq_work_sync() may use rcuwait that requires serialization */
 	guard(mutex)(&barrier_mutex);
 
-	for_each_possible_cpu(cpu)
-		irq_work_sync(&per_cpu_ptr(&deferred_percpu_work, cpu)->work);
+	for_each_possible_cpu(cpu) {
+		struct irq_work *work;
+
+		work = &per_cpu_ptr(&deferred_percpu_work, cpu)->work;
+		/*
+		 * irq_work_sync() may end in synchronize_rcu(), for callers
+		 * that free the work. Ours is static, so skip it while idle.
+		 */
+		if (irq_work_is_busy(work))
+			irq_work_sync(work);
+	}
 }
 
 static __fastpath_inline
-- 
2.56.1


