Received: from relay.hostedemail.com (smtprelay0011.hostedemail.com [216.40.44.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 020DC205E2F
	for <linux-rt-devel@lists.linux.dev>; Mon,  4 Aug 2025 16:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754324859; cv=none; b=qyqz0999aZ6HNMba/QC9GHS9IHj9D1JDRdUr9V2I3YvRQET+bLaK8lrtddgDOBBqPdLfPC4FJnq+qSaQv0Aa0Vp9oh9LW+hRPfHPP3unPyKLcZzvPIbNiZK5q6H8PGFFLJ7KvXFTed2jiHykRQ4MyJHr8owJeUQgm5BoOB6f8qM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754324859; c=relaxed/simple;
	bh=EF09fqtP01LeW6goBVIqhT4DR98n7hzKN17fkaVAe2Y=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=brH4AdTjRiIWRS76DUPy29FpMKoOme1JHJyDX+JLibqbviX+DeAwUn1QnXbSVdmWtBvqGb22XfAs0oBWwfONMaaoHSlvg+K8+c+pg97RTmuHnZLsaAtjkzclqSUV7OUqpcR6zJ+ZO0mMNTXDbkXpDZ3QCtQcgmI/bYHHEtA/hWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf03.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay04.hostedemail.com (Postfix) with ESMTP id E66C21A06F1;
	Mon,  4 Aug 2025 16:27:33 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf03.hostedemail.com (Postfix) with ESMTPA id 836BE60012;
	Mon,  4 Aug 2025 16:27:30 +0000 (UTC)
Date: Mon, 4 Aug 2025 12:27:58 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Yunseong Kim <ysk@kzalloc.com>
Cc: Dmitry Vyukov <dvyukov@google.com>, Andrey Konovalov
 <andreyknvl@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Thomas Gleixner <tglx@linutronix.de>, Sebastian Andrzej Siewior
 <bigeasy@linutronix.de>, Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
 Byungchul Park <byungchul@sk.com>, max.byungchul.park@gmail.com, Yeoreum
 Yun <yeoreum.yun@arm.com>, ppbuk5246@gmail.com, linux-usb@vger.kernel.org,
 linux-rt-devel@lists.linux.dev, syzkaller@googlegroups.com,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 1/4] kcov: Use raw_spinlock_t for kcov->lock and
 kcov_remote_lock
Message-ID: <20250804122758.620f934a@gandalf.local.home>
In-Reply-To: <20250803072044.572733-4-ysk@kzalloc.com>
References: <20250803072044.572733-2-ysk@kzalloc.com>
	<20250803072044.572733-4-ysk@kzalloc.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: awj7kic64tjaaeuy96udt5wcrekxqp1n
X-Rspamd-Server: rspamout01
X-Rspamd-Queue-Id: 836BE60012
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18PSZ92Sd1YlrqLCFU63zjNf9bl2PXkapU=
X-HE-Tag: 1754324850-727609
X-HE-Meta: U2FsdGVkX1+vUUB7h3a3bGTgNnCqcmk2Qtx+7UcqwCVcaEmLf2Q4d3FzOPbUiIcHrn2i+X+1vDoObYWGRvWNNhFgNt3nQTg1cPELoJywUZXIGLd3VQ6kBqzS8vFGscTyCbKTCyuSvqk/K9OEi5p9V6+B36nSVsRmn6jDfaCOjMumEgQctBYNd2hj3xPTPJzZuODvSNwfT/IsYP+EJ0K7exCBWKdnrjVy17bf093Ldvw0HDZeLRWkqV0l4xbfuUViwwdANJL9fgN5IrtiI6Fn4yqWJpPtnq+NFvs8v1C2n6rltOMPdccAVS5vL1wtofR5fBdDPDAqD7ItYnHIRrZWsfMzLbmr6REsi2uQgYtg2fQaA+Mlx1QxxbcPEy3VhieVnGnR66GDGhAf+ngI0YvGfy7VIUx+glasb+E1x4i3PnfSIJ/mq84UdYCeJkUcEeKf

On Sun,  3 Aug 2025 07:20:43 +0000
Yunseong Kim <ysk@kzalloc.com> wrote:

> The locks kcov->lock and kcov_remote_lock can be acquired from
> atomic contexts, such as instrumentation hooks invoked from interrupt
> handlers.
> 
> On PREEMPT_RT-enabled kernels, spinlock_t is typically implemented

On PREEMPT_RT is implemented as a sleeping lock. You don't need to say
"typically".

> as a sleeping lock (e.g., mapped to an rt_mutex). Acquiring such a
> lock in atomic context, where sleeping is not allowed, can lead to
> system hangs or crashes.
> 
> To avoid this, convert both locks to raw_spinlock_t, which always
> provides non-sleeping spinlock semantics regardless of preemption model.
> 
> Signed-off-by: Yunseong Kim <ysk@kzalloc.com>
> ---
>  kernel/kcov.c | 58 +++++++++++++++++++++++++--------------------------
>  1 file changed, 29 insertions(+), 29 deletions(-)
> 
> diff --git a/kernel/kcov.c b/kernel/kcov.c
> index 187ba1b80bda..7d9b53385d81 100644
> --- a/kernel/kcov.c
> +++ b/kernel/kcov.c
> @@ -54,7 +54,7 @@ struct kcov {
>  	 */
>  	refcount_t		refcount;
>  	/* The lock protects mode, size, area and t. */
> -	spinlock_t		lock;
> +	raw_spinlock_t		lock;
>  	enum kcov_mode		mode;
>  	/* Size of arena (in long's). */
>  	unsigned int		size;
> @@ -84,7 +84,7 @@ struct kcov_remote {
>  	struct hlist_node	hnode;
>  };
>  
> -static DEFINE_SPINLOCK(kcov_remote_lock);
> +static DEFINE_RAW_SPINLOCK(kcov_remote_lock);
>  static DEFINE_HASHTABLE(kcov_remote_map, 4);
>  static struct list_head kcov_remote_areas = LIST_HEAD_INIT(kcov_remote_areas);
>  
> @@ -406,7 +406,7 @@ static void kcov_remote_reset(struct kcov *kcov)
>  	struct hlist_node *tmp;
>  	unsigned long flags;
>  
> -	spin_lock_irqsave(&kcov_remote_lock, flags);
> +	raw_spin_lock_irqsave(&kcov_remote_lock, flags);

Not related to these patches, but have you thought about converting some of
these locks over to the "guard()" infrastructure provided by cleanup.h?

>  	hash_for_each_safe(kcov_remote_map, bkt, tmp, remote, hnode) {
>  		if (remote->kcov != kcov)
>  			continue;

Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>

-- Steve
