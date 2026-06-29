Received: from mail-yx1-f49.google.com (mail-yx1-f49.google.com [74.125.224.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14B6B36DA1B
	for <linux-rt-devel@lists.linux.dev>; Mon, 29 Jun 2026 14:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782742130; cv=pass; b=kEHa/mXJyS6jOLDLQaLFgYhIaiq6qH/co0tru/J6Ey4fnqRuns5uq+i6bfiPs3EaHMez5YwmSM2OQDNigO/GtO289zbYPDM0K8ymqgo5Rv82/8Z+gsJNzMiRN4rIScR9D0AfScJ+CsjCBuQP7afPMY4fA+cMZ9LmQjn6vf5totc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782742130; c=relaxed/simple;
	bh=q8QVdB9NJN+/zi8Xa6uyCMmfy4NxiwhJalxYShKUiSI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gSBPBOIVoFb8Hn2XfUB9juUsceriRVIKH0MG8JytKtRzH5iBZTg9GDHr6iY1VE3GVjSUKTSmZKHu+BUynwgkmJeC6ZztYZ5oWWgtzi+9GO8ItEdOyr2uFqNdesvsC+MdZC6E7Iu4tU8HlE08df9AiFOdYkxOD6d8hhf0oyN7Mv4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=ncP9DBgi; arc=pass smtp.client-ip=74.125.224.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="ncP9DBgi"
Received: by mail-yx1-f49.google.com with SMTP id 956f58d0204a3-664db84f074so994536d50.0
        for <linux-rt-devel@lists.linux.dev>; Mon, 29 Jun 2026 07:08:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782742127; cv=none;
        d=google.com; s=arc-20260327;
        b=M4oGcf926u/Ws2IuEyk3Vm6sjr6l+q21HRwcA1GGw+sOU+6v+6BXg59cFm+XBWQeSx
         lkdUYFL49SlZPnaD/gbVpMOC8yG405dR650g6yBkTrc9mayFArsCl5ziTFe2xRJDW0sp
         60Tb6+3qF4UCz2nGhVSDcRZ8xNmgd3HV1WumbgOk3PC1PGtI46bP0elEEbMu15te9DVi
         kikjUHSF1ygpIF3Q+dKmA6hlvdbtkC5hJ4QQppXJB0bmM/9eyLQQVmRsWaokcPMUAVU3
         ZL+krOaZ3vaZoF3ggOyhW4m0XjQT4eamom5UnJnmbWxMQc+klmoeEjwYjTcHnFNL0b3f
         KbCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Kayxw8M9qLEbLCSUnNOcv0HfIXS5cEO8Cn8lVzCr2oA=;
        fh=e37BTA4fACWUlBegHVj6jg5RkGUUQAGykLWVIPv4wjk=;
        b=HsJ5Gcx039awmSMty04AwUuxBGPJQb+EOqhRZLo092CApNv66iezD0Nw1+Rt7VYhjm
         00Ga0yb+SjssYtHJ5O1bHuROQRMa7zCiGcYVK8Uw2MoXRDTTTEE4BfltNWlmW6G2/ejr
         djYmbgBOhOc93J0k6ebiXhlXMk7KfSibV8185WcCjac/DIIHrO4xupCA2tygvZt16PHX
         zdBqKXh9gDpV1wD6JVw/8yBR8/t62TGDFT81kGzlCs77caUOjm0ZbUKLhCFySl3+fSXX
         UhTXJAu/3Xd1n03IuNUMcurkhxLqsu9k2rsaEii1jVt07uG1hKyPorteAL2LNdHBqS7b
         7CDg==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1782742127; x=1783346927; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Kayxw8M9qLEbLCSUnNOcv0HfIXS5cEO8Cn8lVzCr2oA=;
        b=ncP9DBgiOHbUQHQnmgQNP5K7co8GqtZfVM3HrnYqiILc1CGoObPdIpLSmPi+30FUa6
         y6sVbMrfG/G+9bDDPjfb+ysyzNI1cqg6NCi0IC87O+ydfO6M/QJ4FFLBgKx/oT+YTuEB
         qIZYjzq+eYacdc0N1/gMm+PuFrY/797/8r8wI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782742127; x=1783346927;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Kayxw8M9qLEbLCSUnNOcv0HfIXS5cEO8Cn8lVzCr2oA=;
        b=DCuthUwICAwDAKsnIpEaGiRNKUVB9TCfbk25eqK2TZu5uPFCHFUInkHVtBDiZjukY3
         S1Dp/l1/e4FDGGb7FX2+pphZ9fnIFrLpWp0IYhmLvhIS1C4oEbMBsvWXdWNTMIhK4Djk
         qqjUqcUvjMmYR1z0gSNUNiX+ydUJb8YHNThnqnd6IWzDJKV1vvhFqbzMPdD/z+Gq50/x
         eE7d/aGJDg2wFY9VL4acgwwEtOFh/bQl20Jb3Hkajmuo28A9y0fMy10OCkiKh05IV6dB
         njG0r6oKnB/rlptjz26wCh9nv4/IzApLJVHZuA0FFU04rmiO7cF4J84GScGjbZ4mDZl7
         EZkw==
X-Forwarded-Encrypted: i=1; AHgh+RoE4kL2LDHV6pT0V4jfxWJgwFjTD+pjDLtXXnj4eYHbjJ/a/sJwov+KYn5Gyt/aR8ULpWsh0Fzl6xcKlEUY4g==@lists.linux.dev
X-Gm-Message-State: AOJu0YxYbUmMHLQTrHrFxw+3zbymwuSHMvgRmqamX5feJ4VVIjTbt7qQ
	NfSG0LGIHKAk0tQmrag+xEr1zC8qUgfh1lcQejzqyzisSZjUVGB5ZeLWSvcVBbmgx9hreJ0/zPm
	hM/xcGZLq1L3CKSvuMRF1VidzQRaahVCLUYen/WLu
X-Gm-Gg: AfdE7cnNFpkodRv65R46rbwGCQYWxlkDBrYh9AJF1xE1/os1FsjGRT9oNzRs5o8oHii
	GM8EJppv2sRvQKRddQnugwi9SD7EEXroQlUwlY97Uf8pYi8Emgw1jnO+ybiAHCz4GxxbuMWsRTe
	3ZpyKBor1c5pgeTjKE5W4jde+qwo4povJsePWaVb7AvWOyIbX4uSjTPmPqQ94lcCMHnIBrKIuTu
	JseJ6pHuKE9yhnqwbENaEaEGCx9cRGUMsx7hsnfnyOXNsBrNy8k9yHaWL6KXBbOd7fWfQ==
X-Received: by 2002:a05:690e:11c9:b0:664:cd1c:3c1c with SMTP id
 956f58d0204a3-664cd1c64c7mr3930877d50.0.1782742126728; Mon, 29 Jun 2026
 07:08:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260629102157.737306-1-jhs@mojatatu.com> <20260629102157.737306-2-jhs@mojatatu.com>
 <a1a31c1e-b5bf-458f-a80a-bc324fc7a07c@iogearbox.net> <CAM0EoM=QsOZ+mbWk7Ysv8-UNMzbmzbYiNXvF9fjEnG1-bDv6YQ@mail.gmail.com>
 <8a462b1c-b79b-42c5-8409-a36ad727f994@iogearbox.net>
In-Reply-To: <8a462b1c-b79b-42c5-8409-a36ad727f994@iogearbox.net>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Mon, 29 Jun 2026 10:08:33 -0400
X-Gm-Features: AVVi8Cdkj6dZhabBc0jnLqVMZa0vjqL1ozX4LLqAaVAUSsSvVM-qHxGJioR3gI0
Message-ID: <CAM0EoMknehYGAse7AfAN12oEYvQ894YbJrdhv1unOYgpTtvzFA@mail.gmail.com>
Subject: Re: [PATCH net 1/3 v2] net: Extend bpf_net_context lifetime to cover
 qdisc enqueue
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: netdev@vger.kernel.org, jiri@resnulli.us, davem@davemloft.net, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, toke@toke.dk, Steven Rostedt <rostedt@goodmis.org>, 
	Petr Machata <petrm@nvidia.com>, Alexei Starovoitov <ast@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	linux-rt-devel@lists.linux.dev, bpf@vger.kernel.org, security@kernel.org, 
	stable@vger.kernel.org, Victor Nogueira <victor@mojatatu.com>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 29, 2026 at 9:49=E2=80=AFAM Daniel Borkmann <daniel@iogearbox.n=
et> wrote:
>
> On 6/29/26 3:36 PM, Jamal Hadi Salim wrote:
> > On Mon, Jun 29, 2026 at 9:01=E2=80=AFAM Daniel Borkmann <daniel@iogearb=
ox.net> wrote:
> >> On 6/29/26 12:21 PM, Jamal Hadi Salim wrote:
> >>> The bpf_net_context used by sch_handle_egress() is stack-allocated an=
d torn
> >>> down in that function returned. By the time tcf_qevent_handle() runs
> >>> current->bpf_net_context is NULL.
> >>>
> >>> When a filter attached to a qevent block (e.g. RED's early_drop or ma=
rk
> >>> qevents, which always use shared blocks) returns TC_ACT_REDIRECT,
> >>> tcf_qevent_handle() calls skb_do_redirect(), which in turn calls bpf =
helper
> >>> bpf_net_ctx_get_ri().  That helper unconditionally dereferences
> >>> current->bpf_net_context resulting in a NULL pointer dereference.
> >>>
> >>> Note: The same holds for actions that invoke BPF redirect helpers
> >>> (e.g. act_bpf running a program that calls bpf_redirect()) during qev=
ent
> >>> classification itself.
> >>>
> >>> Fix:
> >>> Move the bpf_net_context lifecycle out of sch_handle_egress() into
> >>> __dev_queue_xmit(), so that it spans both the egress TC fast path and=
 the
> >>> qdisc enqueue.
> >>> Note: The call is placed outside the egress_needed_key static branch
> >>> to cover the case where clsact static key is disabled. Unfortunately =
this
> >>> adds a small unconditional penalty to the code path _per packet_ only
> >>> guarded by CONFIG_NET_XGRESS (two writes and one read).
> >>>
> >>> As pointed by sashiko [1]:
> >>> The same context must also be set up in net_tx_action()'s qdisc drain
> >>> path, since qdisc_run() -> netem_dequeue() -> qdisc_enqueue( RED chil=
d)
> >>> can trigger qevent classification asynchronously from softirq context=
.
> >>>
> >>> This keeps all bpf_net_context management in net/core/dev.c i.e the
> >>> existing boundary between tc core and BPF without requiring any net/s=
ched/
> >>> code to know about BPF plumbing.
> >>>
> >>> Reproducer:
> >>>
> >>>     tc qdisc add dev eth0 root handle 1: red limit 1MB min 10KB max 2=
0KB \
> >>>         avpkt 1000 burst 100 qevent early_drop block 10
> >>>     tc filter add block 10 pref 1 bpf obj redirect.o
> >>>
> >>>     traffic through eth0 triggers red_enqueue() -> tcf_qevent_handle(=
) and,
> >>>     on a redirect verdict, a NULL deref in skb_do_redirect().
> >>>
> >>> Fixes: 3625750f05ec ("net: sched: Introduce helpers for qevent blocks=
")
> >>> Tested-by: Victor Nogueira <victor@mojatatu.com>
> >>> Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
> >> Could we simplify patch 1 & 2 by just moving the bpf_net_ctx_set() and
> >> bpf_net_ctx_clear() into a tcf_classify_qdisc() wrapper where we don't
> >> end up having to touch the core TX code?
> >>
> >> Untested diff :
> >
> > This is bpf plumbing which doesnt belong in tc really. You already
> > moved most ebpf/clsact stuff into dev.c - let's just keep it there.
> >
> > As a side note: calling a hierachy of N qdiscs we would incur N
> > set/clear cycles for N levels =E2=80=94 and worse, qdiscs like HTB and =
HFSC
> > iterate filters while loop calling tcf_classify_qdisc() per iteration,
> > so each filter chain traversal does set/clear per proto.
> I'm just saying that this is a lot simpler and taken out of the core fast
> path. Also, I think you forgot to Cc Sebastian on the whole v2 given the
> bpf_net_ctx_{set,clear} dance. Imho, having them via tcf_classify_qdisc o=
r
> something similar would be the much better choice compared to sprinkling
> ifdefs since you want to block the TC_ACT_REDIRECT from classifiers attac=
hed
> to qdiscs.

And you are clearly not listening to what i said.
Something similar would be fine - but stop using tc as your dumping ground.

cheers,
jamal
