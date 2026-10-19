Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792432711;
	b=0V0ZTfEhR5qbrqekOCgu4oMnkPTSJwEiDpYT82XQ7sQnEks6z3bRmx7YmLHLMSCKl3P+
	 gfolC8HJZTrFWtCQW8yHWVfAGebs4nVftIvgzhoA4gVMkaas/VsVyYC6kDV1fdE8IDDLu
	 ljeNfmDLUIirwKyjHJ4ya1KzANfD0nRmbZNPb9ShgZZb97n6DdE5MLxptjxgVQbHziM0q
	 bflEDGfNQyP9aEZQh6go6FLjBQSGFrnCOpckLMQKHTwH7CECow9SfhT+HqvqHBpYg/9vW
	 VoGxf+cpQMUEh+FLjERoAowr3KXNJaL4c9NKJl2i43ko+ACT1+3/JKx9Fw7tLLf5J+Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792432711;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=EPl+s8Alb278lktSJ9Y4SjPtdKUrddbwq+zPo72cjqg=;
	b=SIk9+rIGJ1twWvbGwyCel4nJtr7Xww+BGyYGAh97Y8gmq9xdjDoXXIbhblWOktEtNDD4
	 v87RwpAA4E/1urms6Sp8x5HzxwcUHAyZDEnp+FhWVrs2f+oWuPPtKKusMrxbT6xZ2CTwn
	 alvxQScjGZClJupv9fjPxioqy/m/IU5mtlqNBZMh3KNbNRbCgtCejFXDyy2Dhmf9eW8ma
	 LEhU5J2tZ8MwFo2BlDtdKUPrI+3MueJBy+w2o5yTfMc77vlu8Zgyupx8JXpY7sErW1Cca
	 OKw5Amvjqv1iAS3laxV4l8UYWhOZz0wX9eCpkUZCkdHIDPq3z2+GoRlC1vHi1mCBdRw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kDaE9RuU;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 590DE606A31C
	for <linux-rt-devel@lists.linux.dev>; Mon, 19 Oct 2026 17:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kDaE9RuU
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08D691F000CB
	for <linux-rt-devel@lists.linux.dev>; Mon, 19 Oct 2026 17:58:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792432711;
	bh=EPl+s8Alb278lktSJ9Y4SjPtdKUrddbwq+zPo72cjqg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=kDaE9RuUcAl1lAt2gFiu/H83frdFqngl8r3yg0kd/nD8c/Xi0KBzSAyG+67Ve18e1
	 mZJZLlu8oYK+TRC0Ug+a5E6yG+L8Me5valE4U7LMjZS/9M9kYp+yJ4xFECWdcAXIT0
	 f7O2TFG1xU3bpP+mYsvLs8aD43eQxZoJ7NTpYUbHlpta85mFZNXYfE8mPYfKgmwsyp
	 eajKizqIbbjmC03EEdV1LKyy6ytzxTjXY3ttG6pyJ0iW5M4iuIJQ3wyVBmTD0gCBuw
	 3Ks0R/zhgcApop2saF9SYdV7lbxvVd54BmjPtIYssjlHH+EXC0BxzsNfaJ0OArywRz
	 yRs1LlcQ7DgIQ==
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-4949f037131so1481013fac.3
        for <linux-rt-devel@lists.linux.dev>; Mon, 19 Oct 2026 10:58:30 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBzJFpDTvMfl+SNsrrkaIEdotPeWN98xmYTqzWz/f3SFh9tAzpnSbW2jlgaH8mDuxvHYIwE0nXEtVEoqnwCjAA==@lists.linux.dev
X-Gm-Message-State: AFq9FYJSGCJG/hp1mQAthQXakqgDuiYAC27aKMNh9SEo7jgq1+T4oymb
	G+kfzfojEk4BBx2ecBlFMlIKduIfoc2RM45jT88hiPRizOWZJoP+Zu4dzY5udUi/f3Q4MzUxgGp
	mGJ/+dK0F1h8590XOYe2RaoeZWlp6JHE=
X-Received: by 2002:a05:6870:3d90:b0:4a7:4a8e:237 with SMTP id
 586e51a60fabf-4a7578acf6bmr6059501fac.19.1792432710042; Mon, 19 Oct 2026
 10:58:30 -0700 (PDT)
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Post: <mailto:linux-rt-devel@lists.linux.dev>
List-Help: <mailto:linux-rt-devel+help@lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
List-Owner: <mailto:linux-rt-devel+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
References: <20261019174258.1375583-1-jkain@nuro.ai>
In-Reply-To: <20261019174258.1375583-1-jkain@nuro.ai>
From: Eric Dumazet <edumazet@kernel.org>
Date: Mon, 19 Oct 2026 19:58:19 +0200
X-Gmail-Original-Message-ID: <CAL4WiipkRkOnc_QJ51g6_9uB=pTeCSp6U8L-YVD2ytuZn4g5Qg@mail.gmail.com>
X-Gm-Features: AclHuK9K2lPA1ci6HB3CJlYoscojO5J-XyHjuV9QqTl7I0JMA-hlZq3voyhM-j8
Message-ID: <CAL4WiipkRkOnc_QJ51g6_9uB=pTeCSp6U8L-YVD2ytuZn4g5Qg@mail.gmail.com>
Subject: Re: [PATCH net v6] net: schedule a purge when the defer queue rejects
 a free
To: Joseph Kain <jkain@nuro.ai>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org, 
	pabeni@redhat.com, horms@kernel.org, kuniyu@google.com, 
	kerneljasonxing@gmail.com, bigeasy@linutronix.de, clrkwllms@kernel.org, 
	rostedt@goodmis.org, linux-rt-devel@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le lun. 19 oct. 2026 =C3=A0 19:43, Joseph Kain <jkain@nuro.ai> a =C3=A9crit=
 :
>
> __skb_defer_free_flush() can leave defer_count at or above skb_defer_max
> with an empty defer_list. That state is absorbing: every producer then
> takes the nodefer path without queueing, so the list never refills.
> Deferred freeing stays off for that (cpu, node) until reboot, and
> cross-CPU frees fall back to the page allocator, which is the contention
> deferral exists to avoid.
>
> skb_attempt_defer_free() increments before testing the limit and keeps
> the increment when it rejects, so a rejected free leaves the counter
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
>   sysctl -w net.core.skb_defer_max=3D1    # frees increment, then reject
>   sysctl -w net.core.skb_defer_max=3D128  # does not recover
>
> skb_defer_max has .extra1 =3D SYSCTL_ZERO and no .extra2, so 1 is settabl=
e.
> From v7.1 on, 0 is safe because proc_do_skb_defer_max() flips
> skb_defer_disable_key and the producer returns before incrementing. On
> 6.18 through 7.0, which carry the llist conversion but not commit
> 08dc30de1a40 ("net: add skb_defer_disable_key static key"), setting 0 and
> restoring the previous value strands the counter the same way -- and 0 is
> the documented way to turn the feature off.
>
> Kick the purge from the reject path instead. The reject is the one place
> that observes a full queue, so scheduling the flush there is what stops
> the counter outliving the list, and it does not depend on the owner CPU
> ever raising NET_RX on its own. kick_defer_list_purge() already coalesces
> through sd->defer_ipi_scheduled, so a burst of rejects costs one IPI.
>
> This also covers the case where skb_defer_max is lowered below the
> current defer_count. The kick condition tests equality with half the
> limit, so a reduction can move that point behind the counter and no
> later producer ever reaches it; rejecting without a kick then strands a
> non-empty list the same way. The reject-path kick recovers both.
>
> While here, test the limit with > rather than >=3D, so the effective limi=
t
> is skb_defer_max rather than skb_defer_max - 1, matching what
> Documentation/admin-guide/sysctl/net.rst describes.
>
> That also makes the half-capacity kick reachable at small limits. At
> skb_defer_max =3D 1 nothing was ever queued, so no kick was ever sent, an=
d
> at 2 the equality was never hit; both now kick. That is what commit
> c09b0cd2cc6c ("net: avoid strange behavior with skb_defer_max =3D=3D 1") =
set
> out to allow.
>
> Also drain before clearing in the flush. A producer that queues between
> the clear and the drain currently has its skb drained but its increment
> kept, which over-counts and costs deferral until the next flush.
> Draining first matches the ordering __dev_xmit_skb() already uses for the
> qdisc defer_list.
>
> Found by manual code inspection, LLM-assisted, while backporting the
> llist conversion to 6.1 after hitting the sd->defer_lock contention it
> removes. The latch itself was not hit in production; it was reproduced by
> lowering net.core.skb_defer_max.
>
> Fixes: 844c9db7f7f5 ("net: use llist for sd->defer_list")
> Suggested-by: Kuniyuki Iwashima <kuniyu@google.com>
> Assisted-by: Claude:claude-opus-5
> Signed-off-by: Joseph Kain <jkain@nuro.ai>
> ---

Say not to very verbose changelog, that nobody will read.

Since commit 844c9db7f7f5 ("net: use llist for sd->defer_list"),
skb_attempt_defer_free() increments sdn->defer_count before testing
it against skb_defer_max, and keeps the increment when it rejects.
__skb_defer_free_flush() returns early on an empty list without
clearing the counter.

With skb_defer_max =3D=3D 1, every free is rejected and nothing is ever
queued, so the counter grows without bound and is never reset.
Restoring a larger skb_defer_max does not recover: deferred freeing
stays disabled for that (cpu, node) until reboot.

  sysctl -w net.core.skb_defer_max=3D1
  sysctl -w net.core.skb_defer_max=3D128   # does not recover

Test the limit with '>' instead of '>=3D', so that the first skb after
a reset is always queued, and a counter above the limit implies a
non-empty list that a flush will clear. This also makes the effective
limit match the documentation, and makes the half-capacity kick
reachable for skb_defer_max of 1 and 2.

When rejecting, kick the owner CPU if the list is not empty, so that
lowering skb_defer_max below the current count cannot leave the list
waiting for a NET_RX on the owner CPU that may never come.
kick_defer_list_purge() coalesces through sd->defer_ipi_scheduled.

Also clear the counter after llist_del_all() rather than before,
as __dev_xmit_skb() does, so a racing producer is under-counted
rather than over-counted.
