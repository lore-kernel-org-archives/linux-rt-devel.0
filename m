Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7F9338F653
	for <linux-rt-devel@lists.linux.dev>; Wed,  7 Oct 2026 20:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791404607; cv=none; b=M3SKvotCwYFo/eAlbl+PIIiMdBKhRu9E/sicB7bNJhu0iiwUxQK0EVQH82TvdzM/FkNGHm0jr7KfncYrThQ0B+ZJyQBz7ucxpBZMFMKZGIYWTOdRsGDNzGC6e5aBQWQIjuZpkNtn7sE9NCJWZ/LGOIrBGJge9eQkhyTfZ7d3THY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791404607; c=relaxed/simple;
	bh=3jt+5FtRz6e1tCgCtwGri+4Lp4PI5u1JFl8ZGDIJdbM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jel5P2XS/GU45dXa1wUQvtWz+NVm/Qn44fPYO7muoLifvZ00obNTruu3MSueYKM5l1WGjDH+KZTWWrNzRGcAXaPQwVxSPaRQNwUZlO0juAT0An7Etg7KzI2lnjj4dIgQ8cX/41lrE312tEKgK0VpXZvjyA2IsHc5MVB8Gi79UUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A76Aehfs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A76Aehfs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 992701F0089C
	for <linux-rt-devel@lists.linux.dev>; Wed,  7 Oct 2026 20:23:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791404606;
	bh=a47jPiOkL7aWI9ip0LbLLz0CKtkQQBrXCYrRxSS2YLQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=A76AehfsEYL3HheyeK8R64HIHOvrBGn8yjRvPTang8fqSq4MCB2CcMAjsFtvArsZt
	 6AMijk40wAF6JmAX/xRflRIXL5GoLNe5yDa3DZOdLJuwl/ydz+kk1Q4tdBLGtU7FjS
	 7+qjPlpFMqpNZiSQUyNj2bEY6gSwKblSgv3zxbL0SfGIPS0NYyIjKq32aISN1iIr5q
	 RET4k40TwecuFfQ6WEZFcbJ3sjAdfqTTRc9fR27sQPVC/vAtoQ/Z/9mFn+DjsqFUbC
	 wG/r+ChmqTCkYOJExj2K7uJKSZHRRJolvhNAaZHsWFjUfThxnlVCRjXcecg5NgcFhu
	 tSI5JHQbQy1XQ==
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-4a2757826b9so225096fac.2
        for <linux-rt-devel@lists.linux.dev>; Wed, 07 Oct 2026 13:23:26 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBzrq/JIr4fSsM8/tl3xxZhTKJt19tq32iD8cYiMG1yegWp28SaAG9LueRi8RBZhwWjb2+IM9DJz0SBJrEc+4Q==@lists.linux.dev
X-Gm-Message-State: AFq9FYKltMvY58KKUS8Xgt3tSNUJDQM229aWltnLGFLfRGiNyIhzGOQ8
	87lYXESVwgHqW5kngD/liIQ6OU1Cqo0QvnZdIu/eGnxOytGpLT+9/NzOHf+IQ21xG7WvoFcGgvI
	UOYBdH2ANCu4koMXU8t4NhJBCSLKDL0A=
X-Received: by 2002:a05:6871:c8ce:b0:492:d8bd:949d with SMTP id
 586e51a60fabf-4a2591dda52mr3103729fac.2.1791404605866; Wed, 07 Oct 2026
 13:23:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20261007180056.1394868-1-jkain@nuro.ai>
In-Reply-To: <20261007180056.1394868-1-jkain@nuro.ai>
From: Eric Dumazet <edumazet@kernel.org>
Date: Wed, 7 Oct 2026 22:23:14 +0200
X-Gmail-Original-Message-ID: <CAL4WiipPRh_=aWcHF1+JuKQno8AR-V1bf=yDfgaPQbTDvsOWSw@mail.gmail.com>
X-Gm-Features: AclHuK86Q3lEDlVLZ6eCmdvtc6y2K46nwVmAQ0ck-jGa06hCicXz3-obsFcTwL0
Message-ID: <CAL4WiipPRh_=aWcHF1+JuKQno8AR-V1bf=yDfgaPQbTDvsOWSw@mail.gmail.com>
Subject: Re: [PATCH net] net: do not let defer_count outlive an empty defer_list
To: Joseph Kain <jkain@nuro.ai>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org, 
	pabeni@redhat.com, horms@kernel.org, bigeasy@linutronix.de, 
	clrkwllms@kernel.org, rostedt@goodmis.org, linux-rt-devel@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le mer. 7 oct. 2026 =C3=A0 20:03, Joseph Kain <jkain@nuro.ai> a =C3=A9crit =
:
>
> __skb_defer_free_flush() can leave defer_count at or above skb_defer_max
> with an empty defer_list. That state is absorbing: every producer then
> takes the nodefer path without queueing, so the list never refills, and
> the flush keeps returning early without clearing. Deferred freeing stays
> off for that (cpu, node) until reboot, and cross-CPU frees fall back to
> the page allocator, which is the contention deferral exists to avoid.
>
> Two changes from commit 844c9db7f7f5 ("net: use llist for sd->defer_list"=
)
> combine to produce it.
>
> skb_attempt_defer_free() now increments before testing the limit and does
> not undo the increment when it rejects, so a rejected free leaves the
> counter raised with nothing queued.
>
> The flush clears defer_count before llist_del_all() rather than together
> with it under defer_lock as it did before. A remote producer that queues
> between the two has its skb drained by that same llist_del_all() but its
> increment retained, so the counter drifts upward until it reaches the
> limit.

This is not cumulative: the next flush finding a non-empty list resets
the counter. To get stuck, (skb_defer_max - 1) increments must land
between the clear and the drain of a single flush. With small limits this
needs nothing special, but with the default of 128 the flusher has to be
interrupted or preempted at that point. Please reword this part and the
"needs no preemption at all" paragraph.

>
> Neither needs PREEMPT_RT. The drift needs no preemption at all: the
> flush normally runs in NAPI poll on the CPU that owns the list, while
> skb_attempt_defer_free() only ever defers to a remote CPU, so producers
> cannot be excluded by disabling preemption on the flusher. PREEMPT_RT
> only widens the window, because local_bh_disable() does not disable
> preemption, so the flusher can be scheduled out between the clear and
> the drain.
>
> The latch is also reachable with no race at all:
>
>   sysctl -w net.core.skb_defer_max=3D1    # frees increment, then reject
>   sysctl -w net.core.skb_defer_max=3D128  # does not recover
>
> skb_defer_max has .extra1 =3D SYSCTL_ZERO and no .extra2, so 1 is settabl=
e.
> 0 is safe, because proc_do_skb_defer_max() flips skb_defer_disable_key
> and the producer returns before incrementing, but that guard covers 0
> only. Recovering from the latched state needs a skb_defer_max above the
> accumulated count, which an operator has no way to determine.
>
> Drain before clearing, so the error can only under-read, is bounded by
> the producers in flight, and self-heals on the next flush. Clear the
> counter on the empty-list path as well, so no count can outlive an empty
> list and an already-stranded counter recovers.
>
> llist_empty() has already loaded that cache line, so the added read is
> free; the unlikely() keeps the store off the hot path, where it would
> otherwise bounce the line against remote producers.
>
> Found on an arm64 PREEMPT_RT system running the two commits backported to
> 6.1. With skb_defer_max lowered, defer_count reached 788,888 on one host
> and 122,399 on another with the list empty throughout, and restoring the
> default did not re-enable deferral.

Not sure if this paragraph is needed?

Lowered to which value? Have you seen this with the default?

If the value was 0, note that kernels without commit 08dc30de1a40
("net: add skb_defer_disable_key static key"), i.e. 6.18 to 7.0, have the
same issue as your skb_defer_max=3D1 example: setting 0 and restoring the
previous value leaves deferral disabled. This is worth mentioning, since
0 is the documented way to turn the feature off.

Please send a v2 with these changes (but please wait ~24 hours before V2)

>
> Fixes: 844c9db7f7f5 ("net: use llist for sd->defer_list")
> Signed-off-by: Joseph Kain <jkain@nuro.ai>

This is your first linux contribution, are you sure you have not used an LL=
M?

( See Assisted-by: LLM) tag in Documentation/process/coding-assistants.rst

pw-bot: cr
