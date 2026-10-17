Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A28B2DB78C
	for <linux-rt-devel@lists.linux.dev>; Sat, 17 Oct 2026 06:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792219920; cv=none; b=nefCKCDKGxZrzfvVvghUe6TLpHE90rSTH7o32j8J4e1bsWEx9io2940/ON5nmhe129OBg8iplNI0mP1m4klo4P2KpdFOcJYxzmr+4A/2HbtrrihtOzdeNxS8RSaXDLzwUEakbfkRrvnxka2UbU/li6Fk2hh8o6yw3lBsUzJfujI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792219920; c=relaxed/simple;
	bh=+RGs98OKR+8RSYTh9cABiWdooY/6GYJQl2ugTgDhC/g=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=HLKWGgIa1kJuG7O4+5qXFWBIPg51loiTSLHiZRFAJAzXvnua6bc9pJg1EUcWr4WY2QZ8Khz1pBlvLLl0OB7OVdncPNp5zVmfxq6g2BA5c+xiwFwMnKyXmdjX5i88fFripIi877WuRxTW4R94VNYSZ8zqke9pvC/TbLpKQCrT7O0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FvAZVgri; arc=none smtp.client-ip=209.85.216.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FvAZVgri"
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-3ab2395f104so657958a91.2
        for <linux-rt-devel@lists.linux.dev>; Fri, 16 Oct 2026 23:51:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792219918; x=1792824718; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hLRycCYqFI0sJDL3wNe30VNcaI33OzZwjCiyocKoV9g=;
        b=FvAZVgrigADKtP5J6EWD711ZxzWxuFQ+/YtePkX2BXrKclOJMDy7L9F8EJHWezrT8H
         L8vnWSTlfP7iKSUFy4u7tpidwdPX7/nF4zNsk8HU5QPzryQ28RjHL85n3+PiB7EIEJTJ
         3+Mzrqu0SnYUx0ghW2jMUqJpYNwV4Nr2ap/uVjg5WLJshh+JJ8swYZqXwcKqyr9kB7YG
         nf6khwYq9dcMdbyAfZ2lwQ47X6OBNjs3eAYIcLHMRIutcpSoO6NcPOwPDpiJbIbQsn+y
         nm/3cG4B5OGTyC19anJPtCK8l8hZ9YggjtHwsZGaAV6mqZM1NdbPhu0J9bc93jwPlr0P
         j9bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792219918; x=1792824718;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hLRycCYqFI0sJDL3wNe30VNcaI33OzZwjCiyocKoV9g=;
        b=XAA3qI5oewY7v7p3+rx8d1qxwQvXM05Hl+mnASihF5QFZDdMAvYkoArXQAqvWi6Iat
         KeVI2lPsZ6H0VYrXGlK5f9ezZER3iGHPH7vXAIST932QKGDoOfOlM6AVEAkdgWhpQLH/
         LnzwYmgVSPrE6P+R9vCn49Y5bNQZh+nk97euhENG/YdFFDHYNntnlBDzxQIdOYc6QRor
         UTVMHqigQAMPsTG8X98FdQDb963sgUz8eomRgRnJkKgSG1h5RPNLsOsy0OYX4RHGwafO
         pTBqgp32CZlA2y05H25Ou1Sn/1Ruf5ReNmuST97czY4KXQkjpKymV7gbqUh1xpjDljxD
         Cqow==
X-Forwarded-Encrypted: i=1; AKwUvBzPDfWb53qwADK1b1+PHBLBxPJNMwsTj82UZ/t7UInkK/MjSwwUwuP+jB9eMp+AkL/FdAe2gIss+nX4zQFC3w==@lists.linux.dev
X-Gm-Message-State: AFq9FYKoi996PEQqJS0LHvflOpGImTcSBy7zHEC23dace2WCoaNdCvIz
	EG16JkI0ReY27nTY/qjwTny0wRzbNO881OdEVV8GjLrF26CSylLhIKYwrw+8iqXlr7dg61JpcZT
	pmuVtog==
X-Received: from pjgs9.prod.google.com ([2002:a17:90a:4409:b0:3aa:ee30:1a77])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2ec3:b0:3ab:e588:c295
 with SMTP id 98e67ed59e1d1-3acef51e29dmr1670580a91.42.1792219917592; Fri, 16
 Oct 2026 23:51:57 -0700 (PDT)
Date: Sat, 17 Oct 2026 06:51:57 +0000
In-Reply-To: <20261015162209.485940-1-jkain@nuro.ai>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20261015162209.485940-1-jkain@nuro.ai>
Message-ID: <atMVsAmXKl7D-Fxh@google.com>
Subject: Re: [PATCH net v4] net: do not let defer_count outlive an empty defer_list
From: kuniyu@google.com
To: Joseph Kain <jkain@nuro.ai>
Cc: netdev@vger.kernel.org, edumazet@kernel.org, davem@davemloft.net, 
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	kerneljasonxing@gmail.com, bigeasy@linutronix.de, clrkwllms@kernel.org, 
	rostedt@goodmis.org, linux-rt-devel@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Thu, 15 Oct 2026 09:22:09 -0700, Joseph Kain wrote:
> __skb_defer_free_flush() can leave defer_count at or above skb_defer_max
> with an empty defer_list. That state is absorbing: every producer then
> takes the nodefer path without queueing, so the list never refills.
> Deferred freeing stays off for that (cpu, node) until reboot, and
> cross-CPU frees fall back to the page allocator, which is the contention
> deferral exists to avoid.
> 
> skb_attempt_defer_free() increments before testing the limit and does not
> undo the increment when it rejects, so a rejected free leaves the counter
> raised with nothing queued.
> 
> Nothing brings it back down. The reject path returns before
> kick_defer_list_purge(), so once the counter is stuck no producer
> schedules a flush on the owner CPU. A CPU that never raises NET_RX itself
> -- an application CPU doing TX while NIC IRQs are pinned elsewhere and
> RPS is off -- then never runs the flush at all, so clearing the counter
> inside the flush cannot help it either. proc_do_skb_defer_max() neither
> resets the counters nor schedules a flush when the limit changes.
> 
> It is reachable with no race at all:
> 
>   sysctl -w net.core.skb_defer_max=1    # frees increment, then reject
>   sysctl -w net.core.skb_defer_max=128  # does not recover
> 
> skb_defer_max has .extra1 = SYSCTL_ZERO and no .extra2, so 1 is settable.
> From v7.1 on, 0 is safe because proc_do_skb_defer_max() flips
> skb_defer_disable_key and the producer returns before incrementing. On
> 6.18 through 7.0, which carry the llist conversion but not commit
> 08dc30de1a40 ("net: add skb_defer_disable_key static key"), setting 0 and
> restoring the previous value strands the counter the same way -- and 0 is
> the documented way to turn the feature off.
> 
> Test the limit before incrementing, so the counter is only ever raised by
> a producer that goes on to queue. It then cannot outlive the skbs it
> counts, and the absorbing state is unreachable without depending on a
> flush ever running on the owner CPU.

I think the state is still reachable when reducing the knob
if the new value >> 1 is smaller than the current defer_count
due to the kick condition (==).  This can be fixed by bumping
the knob to defer_count * 2 though.


> 
> This makes the limit advisory. The test no longer reserves the slot it
> checks, and the recvmsg callers run in preemptible context, so the
> overshoot is bounded by the number of producers in flight rather than by
> skb_defer_max; the post-increment test reserved the slot and bounded the
> queue exactly. The counter is already approximate -- the flush zeroes it
> without regard for producers in flight -- and the next flush erases the
> overshoot, where the latch it replaces never recovered at all.
> 
> Undoing the increment on the reject path instead would be wrong: a flush
> that zeroes the counter between a producer's increment and its undo
> leaves the counter negative, and the producer's local is an unsigned
> long, so every later test reads it as enormous and rejects. That is the
> same dead end, reached more easily.
> 
> While here, drain before clearing in the flush. A producer that queues
> between the clear and the drain currently has its skb drained but its
> increment kept, which over-counts and costs deferral until the next
> flush. Draining first matches the ordering __dev_xmit_skb() already uses
> for the qdisc defer_list.
> 
> Found by manual code inspection, LLM-assisted, while backporting the
> llist conversion to 6.1 after hitting the sd->defer_lock contention it
> removes. The latch itself was not hit in production; it was reproduced by
> lowering net.core.skb_defer_max.
> 
> Fixes: 844c9db7f7f5 ("net: use llist for sd->defer_list")
> Assisted-by: Claude:claude-opus-5
> Signed-off-by: Joseph Kain <jkain@nuro.ai>
> ---
> v4:
>  - v3's "undo the increment on reject" was wrong: a flush that zeroes the
>    counter between a producer's increment and its undo leaves the counter
>    negative, and the producer's local is an unsigned long, so every later
>    test reads it as enormous and rejects forever. Test the limit before
>    incrementing instead, so there is no decrement to underflow
>    (netdev-bot sashiko).
> 
> Note this changes the effective limit from skb_defer_max - 1 to
> skb_defer_max, because the test now runs before the increment rather than
> after it. That matches what Documentation/admin-guide/sysctl/net.rst
> describes. It also means the half-capacity kick can now fire at
> skb_defer_max = 1, which commit c09b0cd2cc6c ("net: avoid strange
> behavior with skb_defer_max == 1") set out to make possible.
> 
> Built for x86_64 and arm64, with and without CONFIG_PREEMPT_RT. On
> v7.3-rc6 with skb_defer_max=1 and a cross-CPU TCP load, defer_count
> reached 1918118 unpatched and did not recover when the default was
> restored; with this patch it stays within the limit.
> 
> v3: https://lore.kernel.org/all/20261013205416.3417296-1-jkain@nuro.ai/
> v2: https://lore.kernel.org/all/20261008220256.1844072-1-jkain@nuro.ai/
> v1: https://lore.kernel.org/all/20261007180056.1394868-1-jkain@nuro.ai/
>  net/core/dev.c    | 5 ++++-
>  net/core/skbuff.c | 9 ++++++---
>  2 files changed, 10 insertions(+), 4 deletions(-)
> 
> diff --git a/net/core/dev.c b/net/core/dev.c
> index 18dc88990510..60d86bc21632 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -6940,8 +6940,11 @@ static void __skb_defer_free_flush(struct skb_defer_node *sdn, int budget)
>  
>  	if (llist_empty(&sdn->defer_list))
>  		return;
> -	atomic_long_set(&sdn->defer_count, 0);
>  	free_list = llist_del_all(&sdn->defer_list);
> +	/* Racy on purpose, as in __dev_xmit_skb(): a producer landing between
> +	 * the del_all and this store stays queued but uncounted.
> +	 */
> +	atomic_long_set(&sdn->defer_count, 0);
>  
>  	llist_for_each_entry_safe(skb, next, free_list, ll_node) {
>  		prefetch(next);
> diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> index 4aea06d5167d..25f82b7dcf01 100644
> --- a/net/core/skbuff.c
> +++ b/net/core/skbuff.c
> @@ -7386,11 +7386,14 @@ nodefer:	kfree_skb_napi_cache(skb);
>  	sdn = per_cpu_ptr(net_hotdata.skb_defer_nodes, cpu) + cpu_to_node(my_cpu);
>  
>  	defer_max = READ_ONCE(net_hotdata.sysctl_skb_defer_max);
> -	defer_count = atomic_long_inc_return(&sdn->defer_count);
> -
> -	if (defer_count >= defer_max)
> +	/* Test before incrementing: the reject path returns below without
> +	 * reaching kick_defer_list_purge(), so a kept increment never flushes.
> +	 */
> +	if (atomic_long_read(&sdn->defer_count) >= defer_max)
>  		goto nodefer;
>  
> +	defer_count = atomic_long_inc_return(&sdn->defer_count);
> +

IIUC, atomic_long_read() before atomic_long_inc_return() needs
two-step coherency transaction, and we could avoid that and
the corner case above by fixing the off-by-one and calling
kick_defer_list_purge() in the slow path:

if (unlikely(defer_count > defer_max)) {
    if (!llist_empty(&sdn->defer_list))
        kick_defer_list_purge(cpu);
    goto nodefer;
}


>  	llist_add(&skb->ll_node, &sdn->defer_list);
>  
>  	if (unlikely(!cpu_online(cpu) || my_cpu != raw_smp_processor_id())) {
> -- 
> 2.55.0
> 
