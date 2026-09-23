Received: from mail-qk2-f12.google.com (mail-qk2-f12.google.com [74.125.230.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88972449B1B
	for <linux-rt-devel@lists.linux.dev>; Wed, 23 Sep 2026 07:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.230.204
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790147575; cv=pass; b=LmcGT6D+Hl6z/aWu20y1cT07Yky9HOOMMup/w8XzcLIWX75FJswovpwHJhkAHqqb3qu1U0QPgUBRimnLDTfgJKLLPZTJgrQunqXiTpzDRdILn9Kj+Eae5yu12mxZ+MepjdHwrgZ+tfPXq3nq2RsxrQUNH5hg2+b1Y58o6hcUIlQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790147575; c=relaxed/simple;
	bh=ePal1IXH2Ui+jY7Cm11lrIQVvYsSFG8i9kUMaDDpZ0s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=joS/6VJ3qw3ofz5APaWc84xCCbwlIxsrsLq6KrSznTxeAjslm7SEgE+nY8mVhsZdxYcUVZO5fiYFnmbpIb3gn4hmWxZ1aJcvIq/9tvP3n1QIkdi7s44sHBVdgfM24XJaSycGW3ys+uXbXJiHc87b36N+ECuG1KVpb2yCl0A4tIs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=C19MduNb; arc=pass smtp.client-ip=74.125.230.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="C19MduNb"
Received: by mail-qk2-f12.google.com with SMTP id d75a77b69052e-5309a20a55bso6316801cf.1
        for <linux-rt-devel@lists.linux.dev>; Wed, 23 Sep 2026 00:12:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790147571; cv=none;
        d=google.com; s=arc-20260327;
        b=SZnAs1R9K2hwe89QS4NknVy5YsVwMh8HZAXNOA0/X/RDexTH55GJT3YzoarstMavvS
         zoB8qFQJPFiesw+sElkQcHdQYT4PS9d9qoGYpe/HLJ8vDNRmQHtODJi4OMLW9A5iaEY8
         siN83451ksQYKGeZ1OsosKGZ/l7W64oT5a20o73DWLZwMD2qACvf0lX7xV+dVqnKNgG1
         qiiFvu/YJ4r6Y0U/bejvt/BOoysMglocqveLJmZrXA3Ix/OpVmhSpMWh/uTSGTb+ZI9v
         at6uiQaTck1m7mZcDqU6mwV4Q2M3DWrQi6yDRHI0uhnfg8Mnr8tgDu6T2QlyMDdSsxkp
         HjxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=1fux143jdFR0Eh4CQI0otQKDHPnWvDD/S8UKWh266eU=;
        fh=7H//a+jkF4CSdutZB1R76jEqFRcP2/ulpoJPiluYZSU=;
        b=I/CPRkoYHh1XmwhAemO0F0floTIN+thnTRLL6H1vFb6YMNn5VdjKNyfJUGuBoufqnZ
         AzeXI5Dcx22P66mrr01vtJ+slVDLYFdv4t++OsCkfRTccQQHlqH9AuLGm6pOF4Nsz8nm
         bO6VwR8g7x3AKhqtgRcQuDo88kyjc1gZGkT/NPwfBLSUzAPqCUdi5+BKgL49tKRLXPaw
         nxCti6L/oTFkte3Jn7t1nFchFCLWJH1xuzEW8xhLqQ+okSuaAiT9flb51yS/IkrvfLPU
         xaOf3fb5xRmvqxMuGzfD0fDgT/mfV6/8OK529S7Z4Yg/5jo2Duostk4J8y8UIypfmVlq
         vMWA==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790147571; x=1790752371; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=1fux143jdFR0Eh4CQI0otQKDHPnWvDD/S8UKWh266eU=;
        b=C19MduNbjI4nn8D8cXFG15hNMSUtdfrhPijAjQR3TArFDfOdR1dKSZpRFF8WCkVFmK
         6QGFPhBI47eHIVpYGbNqK1F5XFF289CaStImPjQsgs82kbncLXvA25KvPXWtZ4eMeYGA
         JPQGyCGmt8W0qHOe/pDLWoRkijkgBRtP+N2xoRknlw4fNvrOw7Uqj/t3Qj3+8PV8pbck
         cthqES7tDATKXvxzAdHdBkbLJW7N47Q9lbLjl6KpR/i6CyTAnRORmvHFhQvhE3ZJHiF5
         9aWCvf5JGwwN5Wzn0/iqdaCHT9WC/qdRM+fgqgmYwmjZ2E+yD5pTt97SCbhiY+VACjd6
         b+Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790147571; x=1790752371;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1fux143jdFR0Eh4CQI0otQKDHPnWvDD/S8UKWh266eU=;
        b=QJbxtVlqTvYgiE8BWkRB3FDU0it8UrO7fubcj11YTPlnH+K9dfjzFBZZnMvPdHNyAR
         /Zkd8ybi6Jb/JibWz6xIpzAL1K1mhEkUWrDYxBtYtE3kUXa7jWnrN8WkRq7+h1z11MyF
         34oHnaAbT16tGRaceLDTj2pMB8nJdQ+XGHd1OpYSBVxMmK9Fd+kncfnJHz/q9anpCgtT
         z7LI2WIBjNxherBGjyFdQtNswYkMbZdIxdTG+xaQ2YnvAwAc6e/wksjUIRWPRs/1dThs
         OwbFB6id61kaHRFwB6LUKih3DTAkW2gssDqVBNiYeTQDU6kTx2kU7jfKeFDkaYT5knzX
         h8OA==
X-Forwarded-Encrypted: i=1; AKwUvByf225Dpxps0TLWNSO+VWgcMQI5NCbHUyjtmh/jiIDSOSA+cwhbbQRWoL1ZrV3K2EdlIPWbzc8dxE1Ba13ThQ==@lists.linux.dev
X-Gm-Message-State: AFuF++kyhgacDd/rR4uk5dnR/hL1akq4NRvArUUCIVRnjh/E5rKOQ925
	Aqx4l4wHAByFXea3gyBs36bX3AOuFW5sl4+1DzULpQ4i4q9iM8AnhZr1XS9BLwbTW1PwBb15jGz
	W0acruCuNBa49Z2xpkCtMtMIz4oHmbDMvyRJQTefF
X-Gm-Gg: AYBFou3ir8/FZss093tBx1Vc8xmWFy+BE8F8WzJ7yuv7OX8udvRu4lnlRajKYjgh1py
	lDAevCx0RiUO7y6ZELNgAIneuDavbQ/GEeq/PFoZ9F9a5WWUhZ1TCa1yGA2xwVAKGDczut40pbR
	LMLtCdx/FNuRN6NgNH+9a16L+WYO2kRnka2bWIM+UOuwNkCqNhL52azJYuagIk7xyaB+6TCcQvq
	qgZrRxV5B87Dbf4zjLWscxGF11XDvM/dd8+0Le0JjQ+uwz42iGYmcayoW1ObafBjOlbWFlnp4dl
	tEQunD9mMdqLjz1how0ld7afDA5aL+rq275K7I7yQ3hWPhyKnWrOmRwhLYsGX7KYYM4Iw4O4FrA
	PQt6ct56MI9Z59zyM5KdGx+AnyQq06qY71zKp1DLHGxXA49gWyEqEbVpvO9XwovolHGW+
X-Received: by 2002:ac8:570b:0:b0:530:e01d:6001 with SMTP id
 d75a77b69052e-532eac6cbb3mr31883801cf.11.1790147569115; Wed, 23 Sep 2026
 00:12:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260923032936.2020902-1-runyu.xiao@seu.edu.cn>
In-Reply-To: <20260923032936.2020902-1-runyu.xiao@seu.edu.cn>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 23 Sep 2026 09:12:38 +0200
X-Gm-Features: AcwNN1VwyXdqxc5s0wWZvupLP8rtkXVbaVkNw_j7qxnCeeIIfDCdM4_fvPpPjkA
Message-ID: <CANn89i+fsQdMeMcc6zk_Vp0WtckLQBTmrQ_fbb9rm44L8kSiTQ@mail.gmail.com>
Subject: Re: [PATCH net] net: gen_estimator: protect seqcount updates from
 hardirq readers
To: Runyu Xiao <runyu.xiao@seu.edu.cn>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Clark Williams <clrkwllms@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-rt-devel@lists.linux.dev, stable@vger.kernel.org, 
	Jianhao Xu <jianhao.xu@seu.edu.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 23, 2026 at 5:29=E2=80=AFAM Runyu Xiao <runyu.xiao@seu.edu.cn> =
wrote:
>
> est_timer updates the estimator seqcount with preemption disabled, which
> does not exclude hardirq readers on non-PREEMPT_RT kernels.  A reader can
> observe an odd sequence and spin while the timer is interrupted.
>

There is no hardirq reader of gen_estimator_read() in the tree.

The only callers are:
 - gnet_stats_copy_rate_est() from tc dump paths (process context)
 - tcf_police_act() (BH)
 - xt_rateest_mt() (process or BH)

est_timer() itself runs from TIMER_SOFTIRQ (or ktimers/N on RT), and
softirqs do not nest on a CPU, so no reader can interrupt the writer.

> Disable interrupts around the seqcount write section.
>
> The failure mode was reproduced with an x86_64 kernel under QEMU. A
> test-only hardirq injection invokes gen_estimator_read() on the same CPU
> while est_timer() is updating the sequence counter.

Injecting a call that does not exist is not a reproducer; with that
methodology essentially every seqcount_t writer in the kernel would need
local_irq_save(). Note that such a hardirq caller would already deadlock
on e->stats_lock in est_fetch_counters() anyway.

Also, the preempt_disable_nested() here is deliberate (9f74c0ea9b26
"net_sched: gen_estimator: fix est_timer() vs CONFIG_PREEMPT_RT=3Dy").
local_irq_save() is not remapped on PREEMPT_RT, so this patch would add
a real IRQ-off section in a context RT intentionally keeps preemptible,
and would lose the lockdep assertion on !RT.

Finally, the Fixes: tag and Cc: stable are not warranted: nothing
regressed in 1c0d32fde5bd, and there is no user-visible bug.

pw-bot: rejected
