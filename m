Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.172
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792427591;
	b=KlmTOnYUic7S6ggQWNfgwOZcJlZncNUJq8UPVOxUCQNQ+514t6ryr+oA0XETHmIRL6CR
	 G6YXwwV2/sXx6chuasP9+44iJL8Y55Rtx4vAIs75B9SnEUBSsCD9mSbLUPWR7Ce8NtJth
	 BytRk/k5Qn9PyETzd5ZGIq2sNd0my9TnzDwax8aHkWLFFPwrLkKH03ZiVh9u8tOQkR1ay
	 tzQBbl9ca/pwX+ag8ygietIl92C9FEyYtXPkClTO3ZQ/m45xG/KtEReFWjwXeeuzqrmHg
	 brhdU23WUB2Ei7/XJgQoAGjy1m8WFaoXS5JOSr+4XsTVOe2sbO9lYzuHxwM4/P9zwdg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792427591;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=PVyw06abLNr7loVcICaX07VDm6KPz5wxyY1cmqpMoX4=;
	b=X6mifP3hjJdCmSbcprC/n76f7IUxTIJTmX/9lv/tGLXGVQJ3inQUPgm3k7IGRY/Sw8k8
	 QmwoFmavDrLBCva3UBJBy/lxrXCqGYL9bjTK1yFM23DF5787THn9MpcdSvlcUjXDdxJq/
	 rz0Qey2RMmnrtHLfnCOT7HNSVP7fS9D+47JnrtgxiC5gX1cI3j2ZRYYJd9t0jIA5aL5FZ
	 jWTt34+9Nq6f/tBhmULMkIRMVRbZPVgloKboT2GjjxiQKHlt8/nofSt+4o96g+l5Y8J6k
	 SpaIPHoCSice8iY6/t73LFy14ZPmT1zYGyI7iuufMZoCSjEc1I0FTPDWGNBFX4MLJTw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nuro.ai;
	spf=pass smtp.mailfrom=nuro.ai;
	dkim=pass header.d=nuro.ai header.i=@nuro.ai header.a=rsa-sha256 header.s=google header.b=YXKo6ZTH;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.172
Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CFB1606A31A
	for <linux-rt-devel@lists.linux.dev>; Mon, 19 Oct 2026 16:33:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4CFB1606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nuro.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuro.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=nuro.ai header.i=@nuro.ai header.a=rsa-sha256 header.s=google header.b=YXKo6ZTH
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-35943f55c06so3461658eec.0
        for <linux-rt-devel@lists.linux.dev>; Mon, 19 Oct 2026 09:33:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792427588; cv=none;
        d=google.com; s=arc-20260327;
        b=FD++Dk9PGjyENt70nVmVUZzQbAfgQnpNNvVzetSd2LRB/XFp4NNpLE+EbQsR8CGJJF
         mRjZxsT2G20+Tsu716osxhr5ldnkMdruuOxhggxdU7TnD5twccUlYNGhSVhKZ/+ZRAA4
         AWtkmF9GxX8i3HGAvYg1FrfWdqQSCRQlR7V2XO/4yIbH8VlbkY56LOUJ7vf5d7q2DSUg
         VuTbyoccdszfXSfROOU0wzytgyz8Ix+9tUf2XqY+YPzxyad77u6qrxTelNpoe1Soa8lc
         Hi8HEEZulYxIm84bgM5EB4kDFrjbEJ339jyPA8AzKLmsT6/B7qrlk2dyA0lOerPs81Wv
         Hs2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=PVyw06abLNr7loVcICaX07VDm6KPz5wxyY1cmqpMoX4=;
        fh=Evdc3H71HEIhB/VL28gSAyQfuZxnqLuUvJDUi8yG4TA=;
        b=XqJ3mWY1XMPdrhK9psxlnNDNHqpBtG1MWa8rJ0e1HadJZBUmomnv/Q+GmXszcXtBNA
         FR/02aAbhF9wwGuz6MmJ/n44ZP6DVF+EDbPSvsXGeVtDaDioYO6bJakUJrKEqECP1vK7
         BTFOwaBe1t7qqQHy3VgHWC8iNSXlqOE9ooCHVlzDmcq8KtSMTZGo5JQPCGleAysksLnd
         wbLg5cpr7ZCFxhYZQO5hMSugrAQBwSs+yFM2Td9ENtb0M0Wp0RRScTcDObe1Fu/eA+l+
         vDBGzwplNt0X0gbiFGLAsK2puQ/KTHqZR69091HrUxJAiCeMiIByDVkkeC7v4klBSKMm
         cf9w==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nuro.ai; s=google; t=1792427588; x=1793032388; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=PVyw06abLNr7loVcICaX07VDm6KPz5wxyY1cmqpMoX4=;
        b=YXKo6ZTHeyMiUc69koT5YAWhcpRSAxvctQihuCQpeau9L/8vvSeP+ZJlB/ink30rD5
         HmDqQb+0yRhYaeCXSg1U4glikUYj4lcqoz3ZLIF7S4/eJKSwogqoyRrr4zKImNtwWI5C
         PU7Rj1tkij8ghSxP/LX094FpAmGeFWQ9PUct0eXnUWDkUsuGHHosfl0tDp17SX1NRsSA
         UETxT8N9kkm6tMVzQYu40SoDmjgTL9qDw+6SzdN42RKDwpWVQwO/ZvKGSRvqaSLH7iNp
         yZfrJeaApGMOU+/aUH4QMI+05pjemf8mkiA2TXUaSTXqXoZLMe3aw6iVDZI/e2fhypsJ
         BFeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792427588; x=1793032388;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PVyw06abLNr7loVcICaX07VDm6KPz5wxyY1cmqpMoX4=;
        b=qU2V0MAUzB+LpAm13hztwLCjWwGU4r72OcuOlvLBRZYAC/kHtVVKXRE8e1GQ15zwKG
         mxqVRRWph8UouXg1CX/r/jyQSbrywdWT3ndY9kmnQSzzciyMmVVj4skwvxOii4uuOkSQ
         BGpRcgIjDMRHSM7LTjdEAKa2Eov3pLgccfWf12viUgfSpFjBTmKFXSakzDWfr0OT9s7l
         nwWt4NFF2/wYd+TmUOTyxGVQV+b1kKB7EapMQ3mH7I21AwNPHRT0wTtZwfXdiPveWhoN
         poJlMvaV+AkAiVrMeXuL/y4wCAe6L3bJgb19t5CLRlWYeD4zc7b8YNTzFNU9713cWuLB
         cuiw==
X-Forwarded-Encrypted: i=1; AKwUvBwHNCUAT0By6Y1jYTJcI3os3eXjJM8QcE2RZREg1RGtC1n87YoZlomtaIq4QGyd7tspWgnzC4mko/HFOYGbQg==@lists.linux.dev
X-Gm-Message-State: AFq9FYJz3nLC2gSFCYFOQ9Hy379J8kMu7hLIJumLATsN3YX38Y0lYq+Z
	sieyBF25WORpa4i8E0jknCFPeldUYTT+xDwD3ACE4Nn8zMMocfbbYZaeboJc5rSJuV/uDH4QN9A
	O03sH2OImEUdKPCCAb/D20rJRaGJfK2W2ozM6Ra2WLA==
X-Gm-Gg: AYBFou3lCtlvskEFR78QWugR9gUoyD6eB/c78Xw8YxD9tIxF7goo7FH2exqWAlgLLHR
	PryREPpa+tHgjTZLOYL8idlF9i8RSwrq4HnLeuH6HxqLrbM7mu5odwTm31TqMkA9QHqtPCuyNij
	TaYZONw8Gm2tS+fo35xxxdanEbr2ja/zpuiPrKTeVDqJWfRh16noybd//MoYbnyyo11/S0mCK+G
	WMl7KAUpMTYY0ojYt/aPsctBDYD9p2aNdj3ziovBmHzpbPWZiFtKnYVc1nj+jHRehxDK+9JL+EK
	Yzd1a70VopDPDwSKuHFEpC2eg9jFoMMI7Dh29Mku+RBG6TzcnWrXEPA=
X-Received: by 2002:a05:7300:f78d:b0:353:ba38:789d with SMTP id
 5a478bee46e88-3619b4101c6mr10300680eec.0.1792427587934; Mon, 19 Oct 2026
 09:33:07 -0700 (PDT)
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Post: <mailto:linux-rt-devel@lists.linux.dev>
List-Help: <mailto:linux-rt-devel+help@lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
List-Owner: <mailto:linux-rt-devel+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
References: <20261015162209.485940-1-jkain@nuro.ai> <atMVsAmXKl7D-Fxh@google.com>
In-Reply-To: <atMVsAmXKl7D-Fxh@google.com>
From: Joseph Kain <jkain@nuro.ai>
Date: Mon, 19 Oct 2026 09:32:56 -0700
X-Gm-Features: AclHuK96ao3-gcFPCTsoNVUIQop3QovF9TTmqCGWlYJyX7oEZUJ0dp91AGzMnc0
Message-ID: <CA+Y90Pgk3Yd_+dQrTj42+c_cmi9D__Nfg=Xq4OZXRxpm9Eq68g@mail.gmail.com>
Subject: Re: [PATCH net v4] net: do not let defer_count outlive an empty defer_list
To: kuniyu@google.com
Cc: netdev@vger.kernel.org, edumazet@kernel.org, davem@davemloft.net, 
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	kerneljasonxing@gmail.com, bigeasy@linutronix.de, clrkwllms@kernel.org, 
	rostedt@goodmis.org, linux-rt-devel@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 16, 2026 at 11:51=E2=80=AFPM <kuniyu@google.com> wrote:
>
> On Thu, 15 Oct 2026 09:22:09 -0700, Joseph Kain wrote:
> > __skb_defer_free_flush() can leave defer_count at or above skb_defer_ma=
x
> > with an empty defer_list. That state is absorbing: every producer then
> > takes the nodefer path without queueing, so the list never refills.
> > Deferred freeing stays off for that (cpu, node) until reboot, and
> > cross-CPU frees fall back to the page allocator, which is the contentio=
n
> > deferral exists to avoid.
> >
> > skb_attempt_defer_free() increments before testing the limit and does n=
ot
> > undo the increment when it rejects, so a rejected free leaves the count=
er
> > raised with nothing queued.
> >
> > Nothing brings it back down. The reject path returns before
> > kick_defer_list_purge(), so once the counter is stuck no producer
> > schedules a flush on the owner CPU. A CPU that never raises NET_RX itse=
lf
> > -- an application CPU doing TX while NIC IRQs are pinned elsewhere and
> > RPS is off -- then never runs the flush at all, so clearing the counter
> > inside the flush cannot help it either. proc_do_skb_defer_max() neither
> > resets the counters nor schedules a flush when the limit changes.
> >
> > It is reachable with no race at all:
> >
> >   sysctl -w net.core.skb_defer_max=3D1    # frees increment, then rejec=
t
> >   sysctl -w net.core.skb_defer_max=3D128  # does not recover
> >
> > skb_defer_max has .extra1 =3D SYSCTL_ZERO and no .extra2, so 1 is setta=
ble.
> > From v7.1 on, 0 is safe because proc_do_skb_defer_max() flips
> > skb_defer_disable_key and the producer returns before incrementing. On
> > 6.18 through 7.0, which carry the llist conversion but not commit
> > 08dc30de1a40 ("net: add skb_defer_disable_key static key"), setting 0 a=
nd
> > restoring the previous value strands the counter the same way -- and 0 =
is
> > the documented way to turn the feature off.
> >
> > Test the limit before incrementing, so the counter is only ever raised =
by
> > a producer that goes on to queue. It then cannot outlive the skbs it
> > counts, and the absorbing state is unreachable without depending on a
> > flush ever running on the owner CPU.
>
> I think the state is still reachable when reducing the knob
> if the new value >> 1 is smaller than the current defer_count
> due to the kick condition (=3D=3D).  This can be fixed by bumping
> the knob to defer_count * 2 though.
>
>
> >
> > This makes the limit advisory. The test no longer reserves the slot it
> > checks, and the recvmsg callers run in preemptible context, so the
> > overshoot is bounded by the number of producers in flight rather than b=
y
> > skb_defer_max; the post-increment test reserved the slot and bounded th=
e
> > queue exactly. The counter is already approximate -- the flush zeroes i=
t
> > without regard for producers in flight -- and the next flush erases the
> > overshoot, where the latch it replaces never recovered at all.
> >
> > Undoing the increment on the reject path instead would be wrong: a flus=
h
> > that zeroes the counter between a producer's increment and its undo
> > leaves the counter negative, and the producer's local is an unsigned
> > long, so every later test reads it as enormous and rejects. That is the
> > same dead end, reached more easily.
> >
> > While here, drain before clearing in the flush. A producer that queues
> > between the clear and the drain currently has its skb drained but its
> > increment kept, which over-counts and costs deferral until the next
> > flush. Draining first matches the ordering __dev_xmit_skb() already use=
s
> > for the qdisc defer_list.
> >
> > Found by manual code inspection, LLM-assisted, while backporting the
> > llist conversion to 6.1 after hitting the sd->defer_lock contention it
> > removes. The latch itself was not hit in production; it was reproduced =
by
> > lowering net.core.skb_defer_max.
> >
> > Fixes: 844c9db7f7f5 ("net: use llist for sd->defer_list")
> > Assisted-by: Claude:claude-opus-5
> > Signed-off-by: Joseph Kain <jkain@nuro.ai>
> > ---
> > v4:
> >  - v3's "undo the increment on reject" was wrong: a flush that zeroes t=
he
> >    counter between a producer's increment and its undo leaves the count=
er
> >    negative, and the producer's local is an unsigned long, so every lat=
er
> >    test reads it as enormous and rejects forever. Test the limit before
> >    incrementing instead, so there is no decrement to underflow
> >    (netdev-bot sashiko).
> >
> > Note this changes the effective limit from skb_defer_max - 1 to
> > skb_defer_max, because the test now runs before the increment rather th=
an
> > after it. That matches what Documentation/admin-guide/sysctl/net.rst
> > describes. It also means the half-capacity kick can now fire at
> > skb_defer_max =3D 1, which commit c09b0cd2cc6c ("net: avoid strange
> > behavior with skb_defer_max =3D=3D 1") set out to make possible.
> >
> > Built for x86_64 and arm64, with and without CONFIG_PREEMPT_RT. On
> > v7.3-rc6 with skb_defer_max=3D1 and a cross-CPU TCP load, defer_count
> > reached 1918118 unpatched and did not recover when the default was
> > restored; with this patch it stays within the limit.
> >
> > v3: https://lore.kernel.org/all/20261013205416.3417296-1-jkain@nuro.ai/
> > v2: https://lore.kernel.org/all/20261008220256.1844072-1-jkain@nuro.ai/
> > v1: https://lore.kernel.org/all/20261007180056.1394868-1-jkain@nuro.ai/
> >  net/core/dev.c    | 5 ++++-
> >  net/core/skbuff.c | 9 ++++++---
> >  2 files changed, 10 insertions(+), 4 deletions(-)
> >
> > diff --git a/net/core/dev.c b/net/core/dev.c
> > index 18dc88990510..60d86bc21632 100644
> > --- a/net/core/dev.c
> > +++ b/net/core/dev.c
> > @@ -6940,8 +6940,11 @@ static void __skb_defer_free_flush(struct skb_de=
fer_node *sdn, int budget)
> >
> >       if (llist_empty(&sdn->defer_list))
> >               return;
> > -     atomic_long_set(&sdn->defer_count, 0);
> >       free_list =3D llist_del_all(&sdn->defer_list);
> > +     /* Racy on purpose, as in __dev_xmit_skb(): a producer landing be=
tween
> > +      * the del_all and this store stays queued but uncounted.
> > +      */
> > +     atomic_long_set(&sdn->defer_count, 0);
> >
> >       llist_for_each_entry_safe(skb, next, free_list, ll_node) {
> >               prefetch(next);
> > diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> > index 4aea06d5167d..25f82b7dcf01 100644
> > --- a/net/core/skbuff.c
> > +++ b/net/core/skbuff.c
> > @@ -7386,11 +7386,14 @@ nodefer:      kfree_skb_napi_cache(skb);
> >       sdn =3D per_cpu_ptr(net_hotdata.skb_defer_nodes, cpu) + cpu_to_no=
de(my_cpu);
> >
> >       defer_max =3D READ_ONCE(net_hotdata.sysctl_skb_defer_max);
> > -     defer_count =3D atomic_long_inc_return(&sdn->defer_count);
> > -
> > -     if (defer_count >=3D defer_max)
> > +     /* Test before incrementing: the reject path returns below withou=
t
> > +      * reaching kick_defer_list_purge(), so a kept increment never fl=
ushes.
> > +      */
> > +     if (atomic_long_read(&sdn->defer_count) >=3D defer_max)
> >               goto nodefer;
> >
> > +     defer_count =3D atomic_long_inc_return(&sdn->defer_count);
> > +
>
> IIUC, atomic_long_read() before atomic_long_inc_return() needs
> two-step coherency transaction, and we could avoid that and
> the corner case above by fixing the off-by-one and calling
> kick_defer_list_purge() in the slow path:
>
> if (unlikely(defer_count > defer_max)) {
>     if (!llist_empty(&sdn->defer_list))
>         kick_defer_list_purge(cpu);
>     goto nodefer;
> }
>
>
> >       llist_add(&skb->ll_node, &sdn->defer_list);
> >
> >       if (unlikely(!cpu_online(cpu) || my_cpu !=3D raw_smp_processor_id=
())) {
> > --
> > 2.55.0
> >

Thanks kuniyu, I'll follow up on these in v6.
