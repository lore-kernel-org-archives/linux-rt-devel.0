Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 221012E8B83
	for <linux-rt-devel@lists.linux.dev>; Mon, 28 Sep 2026 12:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790600121; cv=pass; b=jjeCPhxKtIBkhKxN+gUjynlzBvIGyOr2dCecMbbqRF1Bnz5U1m41mT9XCSznYAwon7JT3jKd1kw80uXAtRreKBF5Iui1Ch52dGLX8hy+pJoeBDyEq+A43RcbmqwDmyNciaWXE6PF3b5zhJRuZt+9vwHjScaMXgnTXmtLrPUxG9I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790600121; c=relaxed/simple;
	bh=HGdJ8P7pSskXwI6y7NBpLAw0+M7RovjnFsZII77q+BI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BXyfqUtRjFEspCg4maYgAHmWuTCR1e84Ju4m04C2tqhEVoStfNGSKRJLS6dSl8XdIV50PuGHeRvknpiDTtc6TCjqIZS8vAq3ugcuIK4dqfEsfaswVoeW+zxX8pQ8+Igv960arf0VrmVVEZYV7T3Ox608o8JligMmgv3JoZSt0HE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YDW94MND; arc=pass smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YDW94MND"
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-53334ea7b5cso14171011cf.0
        for <linux-rt-devel@lists.linux.dev>; Mon, 28 Sep 2026 05:55:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790600118; cv=none;
        d=google.com; s=arc-20260327;
        b=MQefk1NQL9rMOO4pka2eKsD1Il2vbXK5RFUbdh+JlkYBXdcIxz9wGHnL66axh/px6B
         4psw+nRZkiRhRuROSBtjL5uUlo+HhfNZQV6pYTRKbXGrhB+mpTc2kRd/mZOKxWG/k88J
         dPDBKXCr1Rs+ajAntEKjaMBHBX0ISS2k0oHYGHIBi54Vjy6b4fqm1S2IyDwfuGStuUWF
         +CVKY3M4AIWb4H7edpD80hEYmwsir4l6RP8wCTSVzYcJ4EhPjAGyYkr2KKHUcrx6ESCS
         Ae6twB4tEnXYy1V88ISWbRVby34lHVCv68eNCyXAFbSUhp3MnHf0t/qhI1ca19lFDwRM
         xllA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=HGdJ8P7pSskXwI6y7NBpLAw0+M7RovjnFsZII77q+BI=;
        fh=9k5+ps+pI80pU6sLiR+sokSzYBwwRZImZ8ulZGcpqIg=;
        b=oRozexvB32LAar2B+Ta115T61EuTJNIlmxPWDbRszup7xDoYDjmffiTvuhmQtR+4iw
         y6Hk2pY59q0Ifm+b5D08TRT/5mAcNgHmU0EkB1tzktNB6V3sv4jyTMY4NQlVeAlZU5f3
         +9BkAdZ6fE/ABSsu68UyP6pFnubS6nG/QlroSvJHEurqSvEU9hewJMw6plohPjtLuKLK
         YwNLHQ1Qoc8z33sFoXGrC5q+FtVKTxDjuKu6cRJQ5hZcPNnNQlCfnlJIwb59+GxnwINZ
         it/GgHYLylMAl5Ir6QZsgErQbJm1YNjgW3on3U2ihXL4FKe+D0yjU8/UTPMqMebN7/Ou
         WANQ==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790600118; x=1791204918; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=HGdJ8P7pSskXwI6y7NBpLAw0+M7RovjnFsZII77q+BI=;
        b=YDW94MNDXfr4LA6J3RPgfRwLNnpLgP69JEDZMjYcn7gjRTE+F93zewRcZTBIZK86hP
         /vuQyMwUgHtWbhVWlt0oi0eiC0gHauWMiEF9TPq3fdzm9R7wAB5fHWNOYz6encWR06VL
         mpSlacR6VR2DOQ7k071JUOq0fRAWFsE73H2j0ANMwuhZBKNtO+XqiGpJwq2HtCM78x3s
         K1J2v1x/w3Yt7uBcfb+m0vOErwGd/b4OXdcpbzjt6brqS8XUuDHta84sfRY712XjK6+M
         f5x1l4aZhKBEaEz+Jjmtixl52l0uK0nhVWRHPRat9VlJRVQH2q6NZd2nT/GlZbff5kUi
         3S7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790600118; x=1791204918;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HGdJ8P7pSskXwI6y7NBpLAw0+M7RovjnFsZII77q+BI=;
        b=vzVC3RpHs8e9QG/5UIPZHX7VI0qXkQ2LHljTnIS6xe8REMzk8vGxAHF0YGbxXDocIY
         Be6Vo3LC/opW/nJ5sChutXav7TwJBN4x6k5GpRHDnBx69f7Vs0cb54A6UMwvu7Pl+nIB
         cVmxy4Au6az43c+jlRD9xHAc6CrKJLsg1auvq19QowWlyO3pSaXK6A25naspVWcjulNM
         l2wPCfA2F/iWPPZvE4Cbz2y+XeM3uL8F1+xV6V2trmENkKkLk+Lu61ustwwVlSEQLV5h
         rAqtQUKxCu42Y40G/g8KwBnVqnG8eQKlb1qDlW6M9yv2JmMj1jZkYUNG2Hwgj5TVKSh+
         2jkQ==
X-Forwarded-Encrypted: i=1; AKwUvBzXS0JjqYvWtRvbImFR//zQh7pMm79PJwYDfw+LJGPiJg1TO2U4xq3m1lnNbt5BFrHV1Rwwj82u+bhkUYoJJg==@lists.linux.dev
X-Gm-Message-State: AFuF++l15etU9qM15qipt/nNrEjVPYVpczrZZ4PEC0EW/jCmxRfkGCgc
	JjzIgD/Yrw2KPhWqSRJWrbtkR//WlG/vDTMdbKxMV/RW9dco0Xs1EqydHkxeogt+IkXU5S/ytT4
	DBYfKmCEP8AwTBZrWHeRudUf88GWb3f5kmiH1N7vy
X-Gm-Gg: AYBFou3Kf/8f1OkO0Cc2vcq0SZgTs5AWDCRHs9CBGaMT6OEColiJlUtrjlWWFtHkldF
	8StzpIBt70zFita/ntCnMt8s9Vbc/FxHl5iciCWYzoF8xqzYkbnTt6TT1ZTdeChXb7uJRaC5mhS
	n1BTpJKhZ/oPSKWtDMp5lixL6lBABZ8EXYoq8eVyXbfq40DKuH70Ao3DEv+F04pIXW6eA6ATzwM
	0hRrccKglwMipQPSM+WYLiPpnbHsPcbEUZtLnSF0SAl1ndFr8Sppy8LG/hQ7Ts7mony4xS1IQ2k
	lKsGHcPv/2GTtnF9+ulQKCwDsovmYHH/pszt1crBgdr2K6DqjKpNjeEDJBphg54Bgt+YjxelsPT
	P0sylYlzKTNe8wgCstWQmNFEahyKJYLJIJsSIKpTap0n/iVpcMdBewfZesgYBANgQPV3L
X-Received: by 2002:a05:622a:355:b0:533:3a42:aeaa with SMTP id
 d75a77b69052e-5333a42b791mr77615191cf.4.1790600117206; Mon, 28 Sep 2026
 05:55:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <QDISC-9R8V.v4.20260928081529@mojatatu.com>
In-Reply-To: <QDISC-9R8V.v4.20260928081529@mojatatu.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 28 Sep 2026 14:55:06 +0200
X-Gm-Features: AclHuK9FtNEUEXpn14JvRmZ6b0QftR4i5sPaslooh9w1KzgEgklcCh1WUjgZQjg
Message-ID: <CANn89iL0baGdqnKof1FtQyQwbb8qiLwTwHB2U+HCMFsBm4wsnQ@mail.gmail.com>
Subject: Re: [PATCH net v4] net: cap skb->queue_mapping when the tx queue is picked
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: netdev@vger.kernel.org, Pablo Neira Ayuso <pablo@netfilter.org>, 
	Florian Westphal <fw@strlen.de>, Phil Sutter <phil@nwl.cc>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Jiri Pirko <jiri@resnulli.us>, Vinicius Costa Gomes <vinicius.gomes@intel.com>, 
	Simon Horman <horms@kernel.org>, Tonghao Zhang <xiangxia.m.yue@gmail.com>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Clark Williams <clrkwllms@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Victor Nogueira <victor@mojatatu.com>, 
	Zero Day Initiative <zdi-disclosures@trendmicro.com>, hybris <hybris@mojatatu.ai>, 
	netfilter-devel@vger.kernel.org, coreteam@netfilter.org, 
	linux-rt-devel@lists.linux.dev, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 28, 2026 at 2:46=E2=80=AFPM Jamal Hadi Salim <jhs@mojatatu.com>=
 wrote:
>
> skbedit can set skb->queue_mapping and raise the per-CPU skip_txqueue
> flag so __dev_queue_xmit() honours the mapping. __dev_queue_xmit()
> cleared the flag before sch_handle_egress() and only read it afterwards,
> so the flag was not confined to the xmit that set it: a nested xmit
> (mirred redirect or mirror, or a drop after skbedit) could set the flag
> and the outer xmit would consume it for an skb that never went through
> skbedit.
>
> A forwarded packet still carries the ingress NIC's rx_queue + 1 in
> skb->queue_mapping, so the outer device then indexes its tx queue state
> with that stale value. Taprio's child array q->qdiscs[] is sized to the
> device's queue count, so taprio_enqueue() indexes past its allocation
> and dereferences the result as a struct Qdisc *.
>
> We (ab)use the skb->nf_skip_egress which means "skip netfilter egress
> for this packet" to tag to "am I in tc egress?". Despite the overload
> I dont see it as a conflict since the marker is set only around the
> single sch_handle_egress() call and ingress path is guarded by
> tc_at_ingress.
> I will send a followup(net-next) patch once this hits net-next to
> rename the skb->nf_skip_egress bit/flag to skb->skip_egress
>
> Arm the flag only from the egress classifier that can use it: raise
> skip_txqueue from tcf_skbedit_act() only when it runs inside
> sch_handle_egress(), thanks to skb->nf_skip_egress. An egress qdisc
> classifier runs in q->enqueue(), after the tx queue has been picked,
> so a mapping it sets cannot affect the current packet; arming the flag
> there only pollutes it for a later xmit. Then own the flag for the xmit
> frame the egress hook runs in: save the incoming value and clear it just
> before sch_handle_egress(), and restore it after the hook - on the
> consumed (drop) path, or, in the same call that reads it, on the
> surviving path. The save and the restores stay inside the
> egress_needed_key static branch, so a packet pays for them only when
> egress hooks are active (2f1e85b1aee4).
>
> Store the value netdev_cap_txqueue() selected back into skb->queue_mappin=
g
> in netdev_tx_queue_mapping(), as netdev_core_pick_tx() already does, so
> the skip_txqueue path never hands a later reader on the xmit path a
> mapping the device cannot serve. A store made still later in the same
> frame, by a tc BPF program attached to a transmit qdisc, is outside this
> path and is not re-capped; a separate followup will resolve that path.
>
> netdev_xmit_skip_txqueue() returns the previous flag value so the
> save-and-clear is one call, and a no-op stub is provided when
> CONFIG_NET_EGRESS is disabled. skb->nf_skip_egress is compiled under
> CONFIG_NET_EGRESS rather than CONFIG_NETFILTER_SKIP_EGRESS, so
> skb_at_tc_egress() is valid whenever the egress path is built.
>
> A local user in a network namespace can redirect a packet from a device
> with more TX queues to one with fewer after setting a mapping valid only
> on the larger device. That reaches these reads and, under KASAN, faults
> with "slab-out-of-bounds in taprio_enqueue".
>
> Conditions to recreate the bug: the report's own trigger is a local user
> with CAP_NET_ADMIN in a network namespace, so no eBPF program is needed.
> With CONFIG_NET_SCH_TAPRIO=3Dy, CONFIG_NET_ACT_SKBEDIT=3Dy,
> CONFIG_NET_ACT_MIRRED=3Dy, CONFIG_NET_CLS_MATCHALL=3Dy,
> CONFIG_NET_SCH_PRIO=3Dy and KASAN enabled, create qa (3 queues), qb
> (2 queues) and qc (1 queue) as dummy devices; put a taprio root on qb
> (num_tc 1, queues 2@0) and clsact on all three; then add an egress
> matchall filter on every device. On qa: "action skbedit queue_mapping 2
> pipe action mirred egress redirect dev qb". On qb: "action mirred egress
> mirror dev qc". On qc: "action skbedit queue_mapping 0 pipe". Send one
> packet out qa. qc's skbedit sets the flag while qb's outer xmit is in
> flight; without the fix qb consumes it and reads its two-entry taprio
> child array with the forwarded packet's stale mapping. A qc whose
> skbedit is instead installed in a transmit-qdisc classifier (a matchall
> filter on the qc root qdisc) reaches the same code path the same way
> without the fix.
>
> Testing: on a KASAN build with panic_on_warn=3D1 the unfixed kernel panic=
s
> with "BUG: KASAN: slab-out-of-bounds in taprio_enqueue", a read 0 bytes
> past a 16-byte taprio_init() allocation, for the clsact-setter and the
> transmit-qdisc-classifier reproducers and for a clsact skbedit-then-tc-BP=
F
> store; the fixed kernel runs all three with no report, and the BPF store
> variant additionally shows the expected "selects TX queue" clamp notice
> from the write-back.
>
> Fixes: 2f1e85b1aee4 ("net: sched: use queue_mapping to pick tx queue")
> Reported-by: Zero Day Initiative <zdi-disclosures@trendmicro.com>
> Link: https://lore.kernel.org/netdev/CANn89iLwYx8nCVf0pCEk_MmEiyC6kQaMwCQ=
T9WkQVeeNzNQHqQ@mail.gmail.com/
> Link: https://lore.kernel.org/netdev/179008581937.2160803.711781429057426=
2942@kernel.org/
> Link: https://lore.kernel.org/netdev/179033713973.2160803.491457069399439=
8206@kernel.org/
> Link: https://lore.kernel.org/netdev/20260925180407.63647514@kernel.org/
> Link: https://lore.kernel.org/netdev/CANn89i+k-mZKDQVtvws_MEXeuMTAdaCcOXF=
ZE-RfhcGTu90sjA@mail.gmail.com/
> Suggested-by: Eric Dumazet <edumazet@google.com>
> Suggested-by: Jakub Kicinski <kuba@kernel.org>
> Tested-by: hybris <hybris@mojatatu.ai>
> Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>

SGTM, thanks Jamal!

Reviewed-by: Eric Dumazet <edumazet@google.com>
