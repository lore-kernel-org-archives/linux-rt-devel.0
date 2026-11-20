Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795179723;
	b=F/6O9mqC/B/99o66LVYjp3DYcVVHxt3qPMnOVemFzxzlvYReEwiA6/jTrFJAg50+uE2T
	 vQ0oW3R5xDB2kc8vW+jPDmHZowf+iZOKJt3p1/4tWC6OAkNbuml7tpchesPjVG37esKq5
	 RoTy4DvtYoPEv4cln12t3GSwg8WT9bUMv4M8eThJ0VGubHAhFJTbX1nEXX61QRLclT4oW
	 d9rurW5S2ajjmmlwas7l7FXZj8ZN/nDUjLbS3MYseZQxa6YOsOL3/VPgbeVgqurAH6QDN
	 IjF5R5s0iXjHruC4CUBaTCFf9mbOkyvGUCYgY56AaeMoGCwUNvSSKMHk6+rwVIdLl7A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795179723;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:In-Reply-To:X-Mimecast-Spam-Score:X-Mimecast-MFC-PROC-ID:
	 X-Mimecast-Originator:Content-Type:Content-Disposition;
	bh=g70Sw5KFtXeD1N+klFwavclKwEB2Fifoe4OTNieWl5U=;
	b=J72dfFuBfEUeQHLlq/aEyA11FOgQYBhwg2zVBmlLkvwXrytOIeM2u8AYW1Lp1WiiFPzd
	 P31GdTp0gJhLb6DEn+jv/HsgBMUFMY3vVUiiehj9YWwljWMaMYhAeDO9RwpvYYZaz23tk
	 NlVE/jrSMu36QtN9AjhctHeda+Xfu4Ey85EQvN1eQH6hxQ8zfB/lbDEqeenbw5ELIdqTe
	 q4pmNNWaaribzf1EdcP8gy5Rk6wEytb04GgUxACLkoiiGkXUouncXpR40q5EqI8Z24HF7
	 32nDXM/Xd9N+T/G0EX9j4NJn22SMzVJnumqJ6E6+Z+0q1V0oOeEj766sA1GkP1D5WJw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=AXx+0F7d;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66DBD606A337
	for <linux-rt-devel@lists.linux.dev>; Fri, 20 Nov 2026 13:02:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 66DBD606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=AXx+0F7d
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1795179722;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=g70Sw5KFtXeD1N+klFwavclKwEB2Fifoe4OTNieWl5U=;
	b=AXx+0F7dukrGev5WfmovrAuRL/Pvn8ToUYetSUpx2t4TNVKer3Bw/YnxzPtx1HpL97YC6j
	f1paq6rDkcfGBszIzbAOTZyAHyWY0nMI0zQg0/Os9eGV7g3hdKGK/n8koHjJE46SkB7JN3
	/eDLxgGvhiXblfCryjKyLd/uwosN+kE=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-94-86ajCb9KPSeNLEDg5y9Fdw-1; Fri, 20 Nov 2026 13:02:00 +0000
X-MC-Unique: 86ajCb9KPSeNLEDg5y9Fdw-1
X-Mimecast-MFC-AGG-ID: 86ajCb9KPSeNLEDg5y9Fdw_1795179719
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-4a799d93bc3so417652f8f.1
        for <linux-rt-devel@lists.linux.dev>; Fri, 20 Nov 2026 05:02:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795179719; x=1795784519;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=g70Sw5KFtXeD1N+klFwavclKwEB2Fifoe4OTNieWl5U=;
        b=yZ+rMhS6f5DDXup3JMwhwzRUtslgbKBI0XOueJK7NBxgTmKFlDX9oa6r6cmqD6oVxf
         TS4qAQ1mQkMVas/2kpM2FT5Ud5jG9euvFh7/2hLM2IhfoivUtnWjzTuEm/862JYVMX5B
         EntUcshaUlps9cILDAFHerK+ItgZMdUR0Wcf7YVzVyQ0rjPaVat3Ij4fpm3m8k4pHroe
         wl4avoHQr8/Uz9W31+g1LUVQOG86Oat4K6tlTnLRhht7nSKw7ru39kGDlfekoI6SXSvT
         DolpvrLJWwfvWM8Y4sfWW5H/hslmxSO+pW0SrkIKprlYnKrSYjZ6vpZ7dzddp/v1Flrl
         GUQg==
X-Forwarded-Encrypted: i=1; AL+hErHwLqSw1O/kOvItFxfj5P1qucGNPs2hRLxYSZy50O0KguRR4cat6nCvTRKHWSWZ99s3NBG14RJsmvd2rexqmw==@lists.linux.dev
X-Gm-Message-State: APuU4Z93Fmdg+H4efa+AP1Te0NeNF4lG/EGHzQu2iAhrxLVFkF/8Zc0n
	JcU0cISToHu3SdptcTPwPBzGW0wKwAc9jbz1vKuOrCVY7oJRixxmKNLkldfu1wdWMZ3ovO65BRw
	sEJSPcDozHvHtzPq4eg/wg3/c02IFItwpeIQ1EOmYVvhs9+lK4qXa26JSUaat+E6eH3TU
X-Gm-Gg: AZFdTZcg/WQ8rewdaLkIeX3pwgR1Gu7MS2lDobdc7+/Ondh+uT1+6gKgpXVuIdrMsNz
	12vwDwalG6YWXxZpubAHUFy5yfz+FHHJXd3TPaVkOK6nh4yCkQvTJjHCOA7bXIeOKQpeUgquP0o
	3opStYTDUowMZoUD7RuDgd7FM3GsAGkKfWY7XOzCI0iGqRj45yCcZHiFvPPsJG++W4inf4kjwxH
	YfEBKDyto8/8s/QkyDtPJja+l/kg/vCpzTVLMg53RnOEYPbcMYC/bebf9zybn0OsZp8pTHuHbvh
	Z3NhIyQ14ZdNgdZzmwQTsbPKjBV61w8HeQTR4CbXS9NRpr4rgl8ReFh5WXpVhJD3K75nXv7kedo
	kTDXvRvRV0L+icbpm8CSR+wV+a18TNunLcH8wdhcfDzP+4a1FpC3D5yej7SJEhmLOjGivlnY9Na
	sdejU=
X-Received: by 2002:a05:6000:616:b0:4a6:e1ed:771 with SMTP id ffacd0b85a97d-4abb5db73c9mr6914890f8f.34.1795179718873;
        Fri, 20 Nov 2026 05:01:58 -0800 (PST)
X-Received: by 2002:a05:6000:616:b0:4a6:e1ed:771 with SMTP id ffacd0b85a97d-4abb5db73c9mr6914801f8f.34.1795179718334;
        Fri, 20 Nov 2026 05:01:58 -0800 (PST)
Received: from jlelli-thinkpadt14gen4.remote.csb ([151.29.158.90])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab6c4353d6sm5512771f8f.56.2026.11.20.05.01.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 05:01:57 -0800 (PST)
Date: Fri, 20 Nov 2026 14:01:55 +0100
From: Juri Lelli <juri.lelli@redhat.com>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: peterz@infradead.org, mingo@redhat.com, vincent.guittot@linaro.org,
	tglx@kernel.org, will@kernel.org, boqun@kernel.org,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, vschneid@redhat.com, kprateek.nayak@amd.com,
	luca.abeni@santannapisa.it, mathieu.poirier@linaro.org,
	longman@redhat.com, ridong.chen@linux.dev, tj@kernel.org,
	hannes@cmpxchg.org, mkoutny@suse.com, shuah@kernel.org,
	bigeasy@linutronix.de, clrkwllms@kernel.org, parri.andrea@gmail.com,
	m.szyprowski@samsung.com, kayracizmeci@gmail.com,
	weihengqiuu@gmail.com, linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-rt-devel@lists.linux.dev, stable@vger.kernel.org
Subject: Re: [PATCH v5 10/17] sched/deadline: Fix an overflow of the 0-lag
 time with long periods
Message-ID: <awBEww33F6yn0MBO@jlelli-thinkpadt14gen4.remote.csb>
References: <cover.1795115075.git.mathieu.desnoyers@efficios.com>
 <2be3813af9e997f5f7d9d3161d0b65b8d4ab917c.1795115075.git.mathieu.desnoyers@efficios.com>
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Post: <mailto:linux-rt-devel@lists.linux.dev>
List-Help: <mailto:linux-rt-devel+help@lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
List-Owner: <mailto:linux-rt-devel+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
In-Reply-To: <2be3813af9e997f5f7d9d3161d0b65b8d4ab917c.1795115075.git.mathieu.desnoyers@efficios.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: DrSQACAiCTLTkXu6hTBGAhBxCQT_aGY9YcUKbQTPIbw_1795179719
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello,

On 19/11/26 14:07, Mathieu Desnoyers wrote:
> When a deadline task blocks, task_non_contending() computes its 0-lag
> time:
> 
>   zerolag_time = deadline - runtime * dl_period / dl_runtime

...

> +	 * The 0-lag time is the deadline minus the runtime left, scaled by
> +	 * dl_period / dl_runtime. The product of the runtime and dl_period
> +	 * can overflow s64 with periods of a few seconds, so multiply on 128
> +	 * bits. Compute the 0-lag time relative to now.
> +	 *
> +	 * After a change of parameters, the runtime and the deadline stay
> +	 * those of the old parameters until the next period. The 0-lag time
> +	 * uses the new dl_runtime and dl_period. The runtime left can then be
> +	 * far above dl_runtime, and the quotient too large for 64 bits. So
> +	 * first compare the runtime left with the runtime that the new
> +	 * parameters give until the deadline:
> +	 *
> +	 *   (deadline - now) * dl_runtime / dl_period
> +	 *
> +	 * If it is larger, the 0-lag time has passed, and the bandwidth is
> +	 * released now.
> +	 *
> +	 * The runtime is negative after an overrun. An overrun lasts at most
> +	 * about a tick, unless the CPU stalls. After a stall of seconds, with
> +	 * a long period and a short dl_runtime, the 0-lag time can overflow
> +	 * s64. It would be centuries away. In that case, release the bandwidth
> +	 * now.
>  	 */
> -	zerolag_time -= rq_clock(rq);
> +	left = dl_se->deadline - rq_clock(rq);
> +	if (dl_se->runtime < 0) {
> +		u64 room = S64_MAX - max(left, 0LL);
> +
> +		if (-dl_se->runtime > mul_u64_u64_div_u64(room, dl_se->dl_runtime,
> +							  dl_se->dl_period))
> +			zerolag_time = -1;
> +		else
> +			zerolag_time = left +
> +				mul_u64_u64_div_u64(-dl_se->runtime,
> +						    dl_se->dl_period,
> +						    dl_se->dl_runtime);
> +	} else if (left < 0 ||
> +		 dl_se->runtime > mul_u64_u64_div_u64(left, dl_se->dl_runtime,
> +						      dl_se->dl_period))
> +		zerolag_time = -1;
> +	else
> +		zerolag_time = left -
> +			mul_u64_u64_div_u64(dl_se->runtime, dl_se->dl_period,
> +					    dl_se->dl_runtime);

Nitpick-ish, feel free to ignore: the logic is right, but it took me a
while to see which inequality each check stands for, and I fear the next
person looking at it (future me included) will have the same problem.
The multi-line branches also miss the braces the tip bracket rules ask
for.

How about moving it into a helper with one early return per case, and a
comment in front of each check saying what it compares? Something like
the below, on top of this patch. I don't think you need to respin the
whole series in case it makes sense, maybe just an updated version of
this patch will do?

Either way, you can add my

Reviewed-by: Juri Lelli <juri.lelli@redhat.com>

Thanks,
Juri
---
 kernel/sched/deadline.c | 117 ++++++++++++++++++++++++----------------
 1 file changed, 72 insertions(+), 45 deletions(-)

diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 63890866dd0c7..eab354e15acbb 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -377,6 +377,76 @@ static void dl_change_utilization(struct task_struct *p, u64 new_bw)
 
 static void __dl_clear_params(struct sched_dl_entity *dl_se);
 
+/*
+ * Return the time from now to the 0-lag time of @dl_se, or a negative
+ * value if the 0-lag time has passed.
+ *
+ * The 0-lag time is when a task running at its reserved bandwidth would
+ * use up the runtime it has left:
+ *
+ *   0-lag = deadline - runtime * dl_period / dl_runtime
+ *
+ * Example: 30ms every 100ms, blocking 10ms into its period with 20ms
+ * left. 0-lag = 100 - 20 * 100 / 30 = 33ms. From there to the deadline,
+ * 30% of the CPU is exactly the 20ms left.
+ *
+ * The product can overflow 64 bits, so mul_u64_u64_div_u64() multiplies
+ * on 128 bits. Its quotient must still fit: on x86-64 it traps
+ * otherwise. Usually |runtime| <= dl_runtime and the quotient is at most
+ * dl_period.
+ *
+ * Each check compares against the bound scaled by dl_runtime / dl_period,
+ * That quotient cannot overflow, as dl_runtime <= dl_period.
+ */
+static s64 dl_time_to_zerolag(struct sched_dl_entity *dl_se, struct rq *rq)
+{
+	/* Time to the deadline. Negative if the deadline has passed. */
+	s64 left = dl_se->deadline - rq_clock(rq);
+
+	if (dl_se->runtime < 0) {
+		/*
+		 * Overrun: the 0-lag time is after the deadline, by the time
+		 * needed to pay the overrun back at the reserved bandwidth.
+		 */
+		u64 overrun = -dl_se->runtime;
+		u64 room = S64_MAX - max(left, 0LL);
+
+		/*
+		 * overrun * dl_period / dl_runtime > room: the result would
+		 * overflow s64. The 0-lag time is centuries away, for a
+		 * negligible bandwidth. Release it now.
+		 */
+		if (overrun > mul_u64_u64_div_u64(room, dl_se->dl_runtime,
+						  dl_se->dl_period)) {
+			return -1;
+		}
+
+		return left + mul_u64_u64_div_u64(overrun, dl_se->dl_period,
+						  dl_se->dl_runtime);
+	}
+
+	/*
+	 * Runtime left: the 0-lag time is before the deadline. It has
+	 * passed if the deadline has.
+	 */
+	if (left < 0)
+		return -1;
+
+	/*
+	 * runtime * dl_period / dl_runtime > left: the 0-lag time has
+	 * passed. The runtime left is more than the bandwidth gives until
+	 * the deadline, as a wakeup would find with dl_entity_overflow().
+	 */
+	if (dl_se->runtime > mul_u64_u64_div_u64(left, dl_se->dl_runtime,
+						 dl_se->dl_period)) {
+		return -1;
+	}
+
+	/* The quotient is at most @left here. */
+	return left - mul_u64_u64_div_u64(dl_se->runtime, dl_se->dl_period,
+					  dl_se->dl_runtime);
+}
+
 /*
  * The utilization of a task cannot be immediately removed from
  * the rq active utilization (running_bw) when the task blocks.
@@ -436,7 +506,7 @@ static void task_non_contending(struct sched_dl_entity *dl_se, bool dl_task)
 	struct hrtimer *timer = &dl_se->inactive_timer;
 	struct rq *rq = rq_of_dl_se(dl_se);
 	struct dl_rq *dl_rq = &rq->dl;
-	s64 zerolag_time, left;
+	s64 zerolag_time;
 
 	/*
 	 * If this is a non-deadline task that has been boosted,
@@ -450,50 +520,7 @@ static void task_non_contending(struct sched_dl_entity *dl_se, bool dl_task)
 
 	WARN_ON(dl_se->dl_non_contending);
 
-	/*
-	 * The 0-lag time is the deadline minus the runtime left, scaled by
-	 * dl_period / dl_runtime. The product of the runtime and dl_period
-	 * can overflow s64 with periods of a few seconds, so multiply on 128
-	 * bits. Compute the 0-lag time relative to now.
-	 *
-	 * After a change of parameters, the runtime and the deadline stay
-	 * those of the old parameters until the next period. The 0-lag time
-	 * uses the new dl_runtime and dl_period. The runtime left can then be
-	 * far above dl_runtime, and the quotient too large for 64 bits. So
-	 * first compare the runtime left with the runtime that the new
-	 * parameters give until the deadline:
-	 *
-	 *   (deadline - now) * dl_runtime / dl_period
-	 *
-	 * If it is larger, the 0-lag time has passed, and the bandwidth is
-	 * released now.
-	 *
-	 * The runtime is negative after an overrun. An overrun lasts at most
-	 * about a tick, unless the CPU stalls. After a stall of seconds, with
-	 * a long period and a short dl_runtime, the 0-lag time can overflow
-	 * s64. It would be centuries away. In that case, release the bandwidth
-	 * now.
-	 */
-	left = dl_se->deadline - rq_clock(rq);
-	if (dl_se->runtime < 0) {
-		u64 room = S64_MAX - max(left, 0LL);
-
-		if (-dl_se->runtime > mul_u64_u64_div_u64(room, dl_se->dl_runtime,
-							  dl_se->dl_period))
-			zerolag_time = -1;
-		else
-			zerolag_time = left +
-				mul_u64_u64_div_u64(-dl_se->runtime,
-						    dl_se->dl_period,
-						    dl_se->dl_runtime);
-	} else if (left < 0 ||
-		 dl_se->runtime > mul_u64_u64_div_u64(left, dl_se->dl_runtime,
-						      dl_se->dl_period))
-		zerolag_time = -1;
-	else
-		zerolag_time = left -
-			mul_u64_u64_div_u64(dl_se->runtime, dl_se->dl_period,
-					    dl_se->dl_runtime);
+	zerolag_time = dl_time_to_zerolag(dl_se, rq);
 
 	/*
 	 * If the "0-lag time" already passed, decrease the active
-- 
2.56.0

