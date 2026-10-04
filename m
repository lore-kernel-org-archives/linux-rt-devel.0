Received: from mail-pg1-f225.google.com (mail-pg1-f225.google.com [209.85.215.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC3783B71BB
	for <linux-rt-devel@lists.linux.dev>; Sun,  4 Oct 2026 12:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791116962; cv=none; b=Vszs5NYWLuisrj26bxQAZIXmlnFAngX/Z+HOVSIPfX9kucYt7z23sedzPVXuIR/4ZqKm6QTXs/X0qDKiP80tAV/phh7HPucgUdafZIpiNwAilCvqMPavWRsXmotCWgIFTHIcSm8bXxy4iTOYXJsVWLH/Lgf/twxMyViZE1c4nX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791116962; c=relaxed/simple;
	bh=tjCJ1OLd4bESmRn4ltE+OeVIx/6AdbNp7qosZGyVn/M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Hdk22mDr9BVWmT8TI9xr5hmPdozdp1z4vk9vGYGQoruqtGlil57CfSiaig/Pz9QlyQR2a3cGlFd3aREO3fd2IUXQdoC9QJhaLBQzlEN2RoATJym9Yig2ZLB7y8C8Dz5+XR4Z1BDTSbqN2tCSEXAhshoybAXzlNnVG8YjVW3QtTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=JYvoMlUe; arc=none smtp.client-ip=209.85.215.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="JYvoMlUe"
Received: by mail-pg1-f225.google.com with SMTP id 41be03b00d2f7-cbee846deecso718300a12.1
        for <linux-rt-devel@lists.linux.dev>; Sun, 04 Oct 2026 05:29:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791116960; x=1791721760;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VPmsD6wMbwGyIjjK6id1o7siDpKmgW9pQeTfa7Jr/0s=;
        b=yTTLRqeyIfqJi3m5d8Zhny+gfCAdf9SUK/tOVkSuvm6P2MKr7fkxoGF4OEad6zbeJq
         w7/chkXx8ZgUjyYD8DLuJnJ6NgD8AeGwgjY5ZwCvNbZWyok8lAcOy1J+i49+qELC5BfX
         YKocdv2vw7ArF1//hQmI0B0KKoMTKqRplhCzaVb50PND4hCsZ7hlFUDJ7NKfGwfoe2mi
         PUewYS/2u+foZR+hZgCXTbhTQ8Zr74hhcprk1tA1k35MAU2MZhHGdfxjRqGk/569IZTX
         lU9xttDSUg0dGkIMHwlsftSnhuIwlqspvwVt5sPt82nLI6nRGonbtAOKjqR2fXv9nPUA
         CBRw==
X-Forwarded-Encrypted: i=1; AKwUvByVQqodbhWH7/HUTpxHIzbJ0brqkA2k11SjEFuM2OccXGevKcux7o8RqJBABZSQg93JeFNezmoSMJXVuMQBmw==@lists.linux.dev
X-Gm-Message-State: AFq9FYLQ9ECbsPTvK8F2NKqf2Lu49jRbsoMsDQIUhql0ViLzNFXaFP7n
	QUGvU9UCU36cXYFyTCrdXRwZnDTGhq7GuOC0ZKQtNGxIYQaNz95C+3VxcqvOR3Awb40n5YT+3/O
	a3BF4bRNzp5UY8SQR9z8YxBuLPTC26silLbLpwzN2TbloqbKB/Lzg5OefKPYqIo2Q/A4xexEyrW
	+gb/gXRoedbvrAgrVsdSXakR+u+q4FKeLCTNbog0iO8JhZRtbH+KFBhqYxfVrH5izXvAb0ci7LK
	eu/DfDraj63BnpGeQVe8KI6RqQ3
X-Gm-Gg: AYBFou1YbjQpF2cNY4+A9uxLJH6pwqTDINRnCj9c5USocjNXVqDjy5KWLgUjdYzFR+B
	ygcT/+UoDm57FJiJohbJ/32nB6ETq1hJwZwr9YmlBbuN2l2d/pPHfKvwkFcvuCDaK+NZSLrA75g
	LxU60T1lL6JC8Cp5w3UZ5BUS1iu7nDetdJP+ewzfQnlsNfAZxSD76FCp4h9NZphY3EMHWamCY1F
	NS2F4Y31MhnQuXPjUnAiR8l87tawFEfG2k7C29J704sDFQv1F6BTrnwRRzx7GeHH8to4MJJkvfC
	MK/gIMbjRk1s2Uaw+Z7xBnhsO+r2/Lkq2wI33B6pYeIng5hGRxJPz/fMFA0YT3dGJa2p0NpCwk4
	mSYiEUrmu52gK1ncQjED/dNIghq9KcFRgNYeVdqo4jLZGQ2/b+3npgtn7ss7Mmj+6WURk4T02P3
	9Ma4XyWy68buqsHZ/4hAzF5NxF0H8UAvVPjhWiLCSCww==
X-Received: by 2002:a17:90b:1807:b0:39e:574d:3d2f with SMTP id 98e67ed59e1d1-3a786736764mr3960664a91.7.1791116960004;
        Sun, 04 Oct 2026 05:29:20 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-120.dlp.protect.broadcom.com. [144.49.247.120])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-3a7db5cc3bdsm224270a91.0.2026.10.04.05.29.18
        for <linux-rt-devel@lists.linux.dev>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 04 Oct 2026 05:29:19 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-34d84114044so4648090eec.1
        for <linux-rt-devel@lists.linux.dev>; Sun, 04 Oct 2026 05:29:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1791116957; x=1791721757; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VPmsD6wMbwGyIjjK6id1o7siDpKmgW9pQeTfa7Jr/0s=;
        b=JYvoMlUeDTmMi0TfUAgeVuvYdtEs8GRtUXddMnEiuQbcGEx5JuJsZ8RehB7QAyG+pb
         vZh8eC3CPKs8LOo9Xk1CBQ1CB62wduVY+Pva0R05SV1/7dxS9IcJVukb/SkLK3sgxen8
         PfzEyEWen3tBgxAY17PxPb4dm+QU7H29NMb78=
X-Forwarded-Encrypted: i=1; AKwUvBxWLzO+VwouuX5hqwLTh7UHwPLvyf+ULnGX5j3Two2nXk0HZtJhSsuzDuuV9E74yZf7+TiCJ4wCFfNgyHl/SQ==@lists.linux.dev
X-Received: by 2002:a05:7022:7e8a:b0:143:298f:33b8 with SMTP id a92af1059eb24-151c4c11b5amr10031757c88.44.1791116956788;
        Sun, 04 Oct 2026 05:29:16 -0700 (PDT)
X-Received: by 2002:a05:7022:7e8a:b0:143:298f:33b8 with SMTP id a92af1059eb24-151c4c11b5amr10031715c88.44.1791116956147;
        Sun, 04 Oct 2026 05:29:16 -0700 (PDT)
Received: from bld-bun-02.bun.broadcom.net ([192.19.176.227])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-35126f01924sm4803605eec.0.2026.10.04.05.29.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Oct 2026 05:29:15 -0700 (PDT)
From: Arend van Spriel <arend.vanspriel@broadcom.com>
To: Karl Mehltretter <kmehltretter@gmail.com>
Cc: Arend van Spriel <arend.vanspriel@broadcom.com>,
	linux-wireless@vger.kernel.org,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	brcm80211@lists.linux.dev,
	brcm80211-dev-list.pdl@broadcom.com,
	linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev,
	stable@vger.kernel.org
Subject: Re: [PATCH] wifi: brcmfmac: avoid sleeping tx locks in netpoll context
Date: Sun,  4 Oct 2026 05:29:10 -0700
Message-ID: <20261004122910.1392318-1-arend.vanspriel@broadcom.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260930185417.61865-1-kmehltretter@gmail.com>
References: <20260930185417.61865-1-kmehltretter@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

On Wed, 30 Sep 2026 20:54:17 +0200, Karl Mehltretter wrote:
> With the default fcmode=0, netpoll calls ndo_start_xmit() with hard
> interrupts disabled and reaches brcmf_sdio_bus_txdata() directly. The
> function takes txq_lock with spin_lock_bh(), and the queue helper takes
> the embedded sk_buff_head lock. These locks may sleep on PREEMPT_RT.
> On non-RT, spin_unlock_bh() can run pending networking softirqs before
> netpoll releases the transmit lock, causing a recursive transmit
> deadlock.
> 
> Use spin_trylock() for IRQ-disabled calls and enqueue with the unlocked
> skb helper while holding txq_lock. On PREEMPT_RT, reject hard IRQ and NMI
> callers, where rt-spinlocks cannot be acquired. If the lock is busy or
> the queue is full, return through the existing drop path. Do not evict an
> older packet from this context. Suppress the queue-full printk because
> netconsole can recursively enter this path.
> 
> The flow-control callback takes another spinlock, so defer it when an
> IRQ-disabled enqueue reaches TXHI. The data worker rechecks the bus state
> and queue length under txq_lock before stopping the queue. Existing TXLOW
> handling wakes the queue after it drains.
> 
> This fixes the direct SDIO transmit path used by fcmode=0. Modes 1 and 2
> take the FWS lock first and need a separate change.
> 
> Fixes: ac3d9dd034e5 ("netpoll: make ndo_poll_controller() optional")
> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>

[...]

> @@ -2796,8 +2797,53 @@ static bool brcmf_sdio_prec_enq(struct pktq *q, struct sk_buff *pkt, int prec)
>  	return p != NULL;
>  }
>  
> +/*
> + * The caller holds txq_lock with hard IRQs disabled. Avoid the skb queue
> + * lock, which may sleep on PREEMPT_RT.
> + */
> +static bool brcmf_sdio_prec_enq_irqoff(struct pktq *q, struct sk_buff *pkt,
> +				       int prec)
> +{
> +	struct sk_buff_head *list = &q->q[prec].skblist;
> +
> +	if (pktq_pfull(q, prec) || pktq_full(q))
> +		return false;
> +
> +	__skb_queue_tail(list, pkt);
> +	q->len++;
> +	if (q->hi_prec < prec)
> +		q->hi_prec = prec;
> +
> +	return true;
> +}

Looking at brcmf_sdio_prec_enq(), it performs essentially the same check on
its fast path (!pktq_pfull(q, prec) && !pktq_full(q)) before calling
brcmu_pktq_penq(), and only falls back to packet eviction when the queue is
full.

Since bus->txq_lock is always held by the caller, using the unlocked
__skb_queue_tail() is safe in both contexts (the embedded skblist spinlock
in brcmu_pktq_penq() has always been redundant in sdio.c).

Is there an opportunity to reuse/refactor brcmf_sdio_prec_enq() rather than
adding a separate brcmf_sdio_prec_enq_irqoff() helper? For example, passing
a can_evict parameter:

static bool brcmf_sdio_prec_enq(struct pktq *q, struct sk_buff *pkt, int prec,
				bool can_evict)
{
	struct sk_buff_head *list = &q->q[prec].skblist;
	struct sk_buff *p;
	int eprec = -1;

	/* Fast case, precedence queue is not full and we are also not
	 * exceeding total queue length
	 */
	if (!pktq_pfull(q, prec) && !pktq_full(q))
		goto enq;

	if (!can_evict)
		return false;

	/* Determine precedence from which to evict packet, if any */
	if (pktq_pfull(q, prec)) {
		eprec = prec;
	} else if (pktq_full(q)) {
		p = brcmu_pktq_peek_tail(q, &eprec);
		if (eprec > prec)
			return false;
	}

	/* Evict if needed */
	if (eprec >= 0) {
		/* Detect queueing to unconfigured precedence */
		if (eprec == prec)
			return false;	/* refuse newer (incoming) packet */
		/* Evict packet according to discard policy */
		p = brcmu_pktq_pdeq_tail(q, eprec);
		if (p == NULL)
			brcmf_err("brcmu_pktq_pdeq_tail() failed\n");
		brcmu_pkt_buf_free_skb(p);
	}

enq:
	__skb_queue_tail(list, pkt);
	q->len++;
	if (q->hi_prec < prec)
		q->hi_prec = prec;

	return true;
}

Then in brcmf_sdio_bus_txdata():

	if (!brcmf_sdio_prec_enq(&bus->txq, pkt, prec, !irq_off)) {
		skb_pull(pkt, bus->tx_hdrlen);
		if (!irq_off)
			brcmf_err("out of bus->txq !!!\n");
		ret = -ENOSR;
	} else {
		ret = 0;
	}

That keeps the queuing logic in one place, eliminates the duplicate helper,
and simplifies the caller.

Regards,
Arend
