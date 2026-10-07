Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DED4B37DEA8
	for <linux-rt-devel@lists.linux.dev>; Wed,  7 Oct 2026 21:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791408252; cv=pass; b=St/7p7Ax0NOj67hlXQeFJKnHDUIHwkHqpSgNIHdSpyfs5wIUoM6UdeOgCBwxX4OPi8w2A0kesUpIcFFFLxURywBh5RVW27Lp1tY/YmwRa1kn6o+VVmbbt15obKONZgWdshKGiLAZKDsQWks7l+aPACrDic1bhc9Tv7rChFKFenw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791408252; c=relaxed/simple;
	bh=/lNFX67BceVjk6Q9VCnmwWo5BV1LSykqG/p5LMy4K3E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YpN+yGrfFcH+GeXZvua7iJkaay6jqUbR7/Pgc7VilbVgfbcCKROm3PkM8NHaOpzLJIKC6v0YCPwG/saKduabGXw9oDSHnkpX4nZGSosqce6EOvRTbYBDL771+fk/lCgiiNJecHQumwDTp2jyUNZtI7+X5PbxJKi4x04GJVKpwvo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nuro.ai; spf=pass smtp.mailfrom=nuro.ai; dkim=pass (2048-bit key) header.d=nuro.ai header.i=@nuro.ai header.b=FIvtjYvD; arc=pass smtp.client-ip=74.125.82.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nuro.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuro.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nuro.ai header.i=@nuro.ai header.b="FIvtjYvD"
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-34ceab2900eso4033713eec.0
        for <linux-rt-devel@lists.linux.dev>; Wed, 07 Oct 2026 14:24:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791408250; cv=none;
        d=google.com; s=arc-20260327;
        b=pC24mKAm/De6lMaI0bBjxVFuiHz5E6sECYW6DKd3V7Z+k5KEeSaYyi3kLLARrCbd3v
         RBc88DfUFEErFl8aULuC+NV9xOGf4JTCgC19xqkQ7U4E4g0+p0YUTBJt0ZVNfIt77Axm
         YlCa29COKYP66IW/wIJ5trqGJJLP28hqIgA8S8WbqYUEKnzHZu82b3K9CNIGelSoi74z
         SrCK8oErUmr7mIeiakQhAsYtYzQJmmfcKfPQI7zNZLKHj/638UZp6Tp/jXjOgp4aoZ+J
         Bjnkug2RvWZrwlaMTwCxUeDGuEgAD/6N9iIC/E/5sBA4T8qKI310UQ37Hs87HykwcwLB
         QdCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=LO61wYACHd+oids/QJ96f5oOR04UNVlFvX9IYm4n0vY=;
        fh=cc3N6EKaaFimOjiUhCfgxFM/tnzUmlGleImoqRb/da0=;
        b=OKbDGCGh2gkki28z9aC4vO3AsjPG5PX7F7i920ltty+L8gC9GtAXYrJjm9UDw8mWH9
         OxzIP/mxocCyluYf3DLiC1h9RytwV9Bh6QMrUIo0eyILMwP1qrKs/ptNncj++ZRbSym/
         DO3xZQqSbEkgbrPqgP4T39Q1n8o6mkbEQTh/qeR4lyK6U4iTw2eGzGRZ/jTZ+68OrKhs
         X6vsXnUuQOzIwWrPuJZBVpxuy+OtyLwrIoDrlgytaFkx7amf2CQ+R1L9DfSE+2JGCfuV
         Skoiabj4Rt+gETmi/66ETw/YUCTcKplfE2pACnl6T6wV1Zq+qbWmJvL85OhhTgxl5kKg
         BVrw==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nuro.ai; s=google; t=1791408250; x=1792013050; darn=lists.linux.dev;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LO61wYACHd+oids/QJ96f5oOR04UNVlFvX9IYm4n0vY=;
        b=FIvtjYvDQOixswZDyFweC2bLUKlTpGs44fxu+pai5dkNPndriAoWycSN1dgZYmOtoa
         fQxp0Z2qNuUdklm6KQ6D9CjI11lFC9HyMs1wFqUJF3yHLi8ms8W+gZFmhuhSRShTX+Nj
         ywHRZz46WWrTks8tUZCPMTcCrddrDyVMUBC13BHpkJuSG0PniiaGF4gHmQlZw9Mw1TDg
         q9BIGn76awzZhnvG5wY7nZu6L/COj0LkIbSbD1tz7P7Rtlm/FQ1SI0OkuXD44uY41Jva
         6cyAVErbdOWBXTgJ48/kaHXGzSKavHX7FzmjgnpSwcHOEj3wCXw7E5qnz0QpBkqFzta+
         LxUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791408250; x=1792013050;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=LO61wYACHd+oids/QJ96f5oOR04UNVlFvX9IYm4n0vY=;
        b=mP7cq4jrdssPw2KvR0HxCJLKcyPraQtIo/iROb6bZWmEs7HbQFVUlGSnFn2+rNgo7M
         CUPGbl8uSGXDwbcG/hEiMtUx9a+t0S+DAbQSdKWAPHGnVG6NRanq089pVfOSG3UTe5Tr
         F3OpFf+WhzA50DaHKd3nZdZEYZSOTQTTrBVCYG90ymL51okjFEaeD02vCvcAsuce+Wkr
         bXa9x+y0FYpF1Vw+7C/NxXvwyI3XaIVRikCtOTTgCZ2hBODl3/5yRRvb1h3ZiVswHJ8W
         UjN3W/Mtcgn/ACR7phLkPfkg0jUoHRDMjP1QjnISXGVGd6BxT7m/VbILoXKtwUi/R7ef
         nr4Q==
X-Forwarded-Encrypted: i=1; AKwUvBxPzuF3IsjG47ag0oFGJ6G0BDLzft5jOhB9RvEjdX6w4Cj4PQov3PigpVXym/5PhauYLJPCnKKubQPJVXDz8w==@lists.linux.dev
X-Gm-Message-State: AFq9FYJu2se12s6Jh7HInHOsMJe9IuOV+QinkGRTsP6XVLTRNhEIgeSu
	2rz6j6Zl91Fgzhh2fUBjh2MW2Kn18lOQBx6dc5stxCPnP0CdvxTvP+T4TRdTuhJ6fh0i4ChIzNK
	o40eY4h6XSYfF4B131gKR0bqC0UW8TwjPiHXEX8oZRg==
X-Gm-Gg: AYBFou2ijM7RwO+0xdB6KQGVQ6rl7ELlWsYMPHbF5AqoUMSlUStVvwPZNH0AU4ki8AK
	/lw9s1zb+VcDuMp8VVjYmpGJDec3lXDvLtKr7FTdUSIikXcYR2rXynDam3MnoGkwbflmaPhNG3i
	5iqx+tlKBhR/zKVRcwVfyHIicilemfbw9afRmeFpYjnmUjuQi5Y7vahpo1qi3VLJcUVPH56Dx0N
	GZcH9ROiFgNwIvhNWdHgbot1PvBayUYBH5H4r95Gj1OL94liXvVg119g1Uu6sTI8sOYcvkkF6vd
	NObU0xge8e8SjDHDTFWl8oJX6eKQr85J37k0vSb8XkFUtANa2nVOU+HI4K7YC0NQY4ku8GxXuwu
	Aa+WrJPDdXOPu6Gw=
X-Received: by 2002:a05:7301:825:b0:351:70ec:1071 with SMTP id
 5a478bee46e88-35170ec1462mr1592185eec.16.1791408249737; Wed, 07 Oct 2026
 14:24:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20261007180056.1394868-1-jkain@nuro.ai> <CAL4WiipPRh_=aWcHF1+JuKQno8AR-V1bf=yDfgaPQbTDvsOWSw@mail.gmail.com>
In-Reply-To: <CAL4WiipPRh_=aWcHF1+JuKQno8AR-V1bf=yDfgaPQbTDvsOWSw@mail.gmail.com>
From: Joseph Kain <jkain@nuro.ai>
Date: Wed, 7 Oct 2026 14:23:58 -0700
X-Gm-Features: AclHuK882S8MLKyOoObkKSwwFJpQZhgLXUqMlLQkMDw9-UQJoFKKgmpAA0agWZ8
Message-ID: <CA+Y90PgXVxo0=4D-v7Nuj5Qh9TFbu2WG=r_dk4zB0tD3ZHWpNQ@mail.gmail.com>
Subject: Re: [PATCH net] net: do not let defer_count outlive an empty defer_list
To: Eric Dumazet <edumazet@kernel.org>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org, 
	pabeni@redhat.com, horms@kernel.org, bigeasy@linutronix.de, 
	clrkwllms@kernel.org, rostedt@goodmis.org, linux-rt-devel@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

(resending with the list cc'd.  My previous reply went to Eric only)

On Wed, Oct 7, 2026 at 1:23=E2=80=AFPM Eric Dumazet <edumazet@kernel.org> w=
rote:
>
> Le mer. 7 oct. 2026 =C3=A0 20:03, Joseph Kain <jkain@nuro.ai> a =C3=A9cri=
t :
> >
> > __skb_defer_free_flush() can leave defer_count at or above skb_defer_ma=
x
> > with an empty defer_list. That state is absorbing: every producer then
> > takes the nodefer path without queueing, so the list never refills, and
> > the flush keeps returning early without clearing. Deferred freeing stay=
s
> > off for that (cpu, node) until reboot, and cross-CPU frees fall back to
> > the page allocator, which is the contention deferral exists to avoid.
> >
> > Two changes from commit 844c9db7f7f5 ("net: use llist for sd->defer_lis=
t")
> > combine to produce it.
> >
> > skb_attempt_defer_free() now increments before testing the limit and do=
es
> > not undo the increment when it rejects, so a rejected free leaves the
> > counter raised with nothing queued.
> >
> > The flush clears defer_count before llist_del_all() rather than togethe=
r
> > with it under defer_lock as it did before. A remote producer that queue=
s
> > between the two has its skb drained by that same llist_del_all() but it=
s
> > increment retained, so the counter drifts upward until it reaches the
> > limit.
>
> This is not cumulative: the next flush finding a non-empty list resets
> the counter. To get stuck, (skb_defer_max - 1) increments must land
> between the clear and the drain of a single flush. With small limits this
> needs nothing special, but with the default of 128 the flusher has to be
> interrupted or preempted at that point. Please reword this part and the
> "needs no preemption at all" paragraph.

Thanks, you are right; any later flush finding a non-empty list clears the
counter.  I will rewrite this portion in the upcoming v2.

>
> >
> > Neither needs PREEMPT_RT. The drift needs no preemption at all: the
> > flush normally runs in NAPI poll on the CPU that owns the list, while
> > skb_attempt_defer_free() only ever defers to a remote CPU, so producers
> > cannot be excluded by disabling preemption on the flusher. PREEMPT_RT
> > only widens the window, because local_bh_disable() does not disable
> > preemption, so the flusher can be scheduled out between the clear and
> > the drain.
> >
> > The latch is also reachable with no race at all:
> >
> >   sysctl -w net.core.skb_defer_max=3D1    # frees increment, then rejec=
t
> >   sysctl -w net.core.skb_defer_max=3D128  # does not recover
> >
> > skb_defer_max has .extra1 =3D SYSCTL_ZERO and no .extra2, so 1 is setta=
ble.
> > 0 is safe, because proc_do_skb_defer_max() flips skb_defer_disable_key
> > and the producer returns before incrementing, but that guard covers 0
> > only. Recovering from the latched state needs a skb_defer_max above the
> > accumulated count, which an operator has no way to determine.
> >
> > Drain before clearing, so the error can only under-read, is bounded by
> > the producers in flight, and self-heals on the next flush. Clear the
> > counter on the empty-list path as well, so no count can outlive an empt=
y
> > list and an already-stranded counter recovers.
> >
> > llist_empty() has already loaded that cache line, so the added read is
> > free; the unlikely() keeps the store off the hot path, where it would
> > otherwise bounce the line against remote producers.
> >
> > Found on an arm64 PREEMPT_RT system running the two commits backported =
to
> > 6.1. With skb_defer_max lowered, defer_count reached 788,888 on one hos=
t
> > and 122,399 on another with the list empty throughout, and restoring th=
e
> > default did not re-enable deferral.
>
> Not sure if this paragraph is needed?
>
> Lowered to which value? Have you seen this with the default?
>
> If the value was 0, note that kernels without commit 08dc30de1a40
> ("net: add skb_defer_disable_key static key"), i.e. 6.18 to 7.0, have the
> same issue as your skb_defer_max=3D1 example: setting 0 and restoring the
> previous value leaves deferral disabled. This is worth mentioning, since
> 0 is the documented way to turn the feature off.

Thanks, I will add that. The backport I reproduced on also predates the
 static key, so this is the case I hit.

>
> Please send a v2 with these changes (but please wait ~24 hours before V2)
>
> >
> > Fixes: 844c9db7f7f5 ("net: use llist for sd->defer_list")
> > Signed-off-by: Joseph Kain <jkain@nuro.ai>
>
> This is your first linux contribution, are you sure you have not used an =
LLM?
>
> ( See Assisted-by: LLM) tag in Documentation/process/coding-assistants.rs=
t

Oh, I certainly have used an LLM but missed the documentation.  I
will include the Assisted-tag in v2.


>
> pw-bot: cr
