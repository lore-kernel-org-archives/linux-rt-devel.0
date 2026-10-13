Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73A4448F018
	for <linux-rt-devel@lists.linux.dev>; Tue, 13 Oct 2026 06:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791871497; cv=none; b=tDCNEKcssRHp+JewoPpStyJqtuJ2ASqI7Z+2Wj9ktj7uPLWkldxZuJ40xVsitB66PwZrVddj5efig7j21RdxYuV3zWgsaeW7BKkneY4oyhfSD/qgl6PxhlG2eealLyqgTCZ4qUJJXixxzpqQwnrM/KlDdfO/Wrx+mgaUe6i9FlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791871497; c=relaxed/simple;
	bh=ic/HnWI2uVjT7xZGS6/vTXvIfeGBCgY8SkuyZlDJjxo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ao5n+hLPc83NqAzCLEiTMswEysrBmjNgxVA8khDLs2KrN2J66m68dQIvpzPtsanQopESomqZXi/0m5W8dz9egIKwWcVaZA+5hoNz8U9C5RXvqn5dsf4hEyOLkbVIoYU/uijZxGo0MlkqnWzhqS092J3Fzzd+2QT3sI2N4qydD+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a6Q4Pisq; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a6Q4Pisq"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-48c14a06c95so1919573f8f.1
        for <linux-rt-devel@lists.linux.dev>; Mon, 12 Oct 2026 23:04:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791871494; x=1792476294; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NWCISX+AIl6irThIkjqUzshDOHoJAyWfFCmE1q6BCDU=;
        b=a6Q4PisqwVorvKD5N3as3+UqkymfVVo2/iVoeIslPmHt+ZO27uIHT93Cuo/6aqPP9n
         qv5Tffc14B4KWDzuU6oDzQnvAdIYInJtaYWU4OyB4+Gi/EuvdNyonbpccDRjvOj4QCmV
         fP6mGNI+k/gGtiIxWRPa8Y/Ncz52RyDvxnn9nT1ynQ/eMymqeVRcexGZwrTixL/S4zS5
         IePtUH3pHpxpGKE3b+qyHThCSUMveHcoWPfGSVN6Vz8YhYXJTjVbsUpSifmjs6l9SG7C
         fTOsKRAzXeNOVHLpYL6LDJgVn22wITmAtUXG127oobDEVBHF3NQmS8B0as/hSrWshd2y
         HykA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791871494; x=1792476294;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=NWCISX+AIl6irThIkjqUzshDOHoJAyWfFCmE1q6BCDU=;
        b=wFZw575LIax0NWbnKCbNSAyIlqXPoo0Gc7/L8plYlhZTvycC3RfwYF/Qw2jZH7Szj1
         lamf2Sgzx+aB3z838X/sP0BdNyoQThZnEAixJ5tJdv7SDe+t0ZBqkIr/vIc6lL2Xtzsu
         52IGJp7fgqvUXHqCrVQwhQ1luDkwgiIjhWzAOLiVb/zAok/QPOEkGTFnXnpgBfDWEXas
         w1PIf/Rhoo5voVKHrw7xye6Njj84CmcH5MVmBKUgpVGA1BNe9hNwhCThb8y8nmb86z2D
         MOpWb7CmPPqZjzE6Yy8AHFuyr4tE7QC3uw6BKBvEUqhcUuXig2dCgJNS/kdD3hn042uV
         GrmQ==
X-Forwarded-Encrypted: i=1; AKwUvBzP95yZY/4UYkfqXkmwsxp3222jsIiYgULd/m+gz0joWtZI+iig/Xwa3dZ4tM6yyRxmrMly3gCJj6uGUedJgw==@lists.linux.dev
X-Gm-Message-State: AFq9FYJh0lO+5PGQxoyiv1qC4aUQn+qiOZjRxcTSJyvhYWJknOWtdQF8
	/TcZBIgmdx5E5uI8r2xyyenzUyCLiVyWleViY9rGrRK+qP39X/kVzkOo
X-Gm-Gg: AYBFou0SR2bVgI8V1S9EfMWHHJjaXw2amw9eX1hi5jYALbkLNr3TF9zeGz9M70JkgU0
	fhOwDOLttI1ZC5m8THENkXMVComaqZ3hEA474WE1MhhV/hIutLUwR6GpKnxc1bj12A2Mq+TbYNS
	B6CCk55BR3p7GabHmNrGK1ns2iKwUrL6MTYwBUZAuBNc+shKmAQF8grmywE3+k06g0hmDq5/88j
	pO/sRgNn1mg0PCdOlm8J2GnnCniUPDx85DUGcv/009pYHqHE4vzq3okt5ZTeeiYieSvqAMPSTLK
	zHgcGfRUS3fcr58M/fUMssQthjsQ0tHjbKHcwqWcCYiQn8iAlv/1yxrUe1KYq3kmLUgRwFB1drw
	eh+IBkBIv4ld/+bVbyabhtf/Dzi5fNwZSVelea3youjLQb25L21SoBzkcACAqnrKDQpjRQ5OpLA
	R0X29tAxBKQTUoYKnhvPn01uAOLcje1eT1aIPHLxHMLTRByHM//WR0dN9X4W8PJGwBCdwrsahYH
	xZrkhzCbnKalnZGPWJV6DuIe8jEpdnzTG8VPuPXrxlKO86Ovd8OfYkfpdssezedWE3/+CI=
X-Received: by 2002:adf:e7c5:0:b0:48c:7ee3:e07d with SMTP id ffacd0b85a97d-48dbaceedd2mr16125022f8f.52.1791871494440;
        Mon, 12 Oct 2026 23:04:54 -0700 (PDT)
Received: from localhost ([188.234.148.119])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48de096922dsm2684630f8f.8.2026.10.12.23.04.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2026 23:04:52 -0700 (PDT)
From: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@kernel.org>,
	Andy Lutomirski <luto@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Will Deacon <will@kernel.org>,
	Boqun Feng <boqun@kernel.org>,
	Waiman Long <longman@redhat.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Karl Mehltretter <kmehltretter@gmail.com>,
	linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev
Subject: Re: [RFC PATCH] entry: Account the deferred hrtimer rearm as hardirq context for lockdep
Date: Tue, 13 Oct 2026 11:04:48 +0500
Message-ID: <20261013060448.751816-1-mikhail.v.gavrilov@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261012152120.GT4121339@noisy.programming.kicks-ass.net>
References: <20261012152120.GT4121339@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, Oct 12, 2026 at 05:21:20PM +0200, Peter Zijlstra wrote:
> On Fri, Oct 09, 2026 at 01:46:49AM +0500, Mikhail Gavrilov wrote:
> > Not touched, and a question for you: the rearm in hrtick_schedule_exit()
> > also stacks chains on the preempted task's locks, under the runqueue lock.
> > Chains with hrtimer_bases.lock under the runqueue lock, this rearm among
> > them, were 4.9% of the pool in the boot above. Should it get the same
> > treatment?
>
> I'm thinking those would be there before the patch too. We've always
> done hrtimer_start() from there. You might not have seen it because
> hrtick was default disabled for most.

Right, hrtick_start() has always put hrtimer_bases.lock under the
runqueue lock, and 9213aa4784cf ("sched: Default enable HRTICK when
deferred rearming is enabled") is what made it common. I'll leave that
one alone.

> The first question I had was about __exit_to_usermode_prepare(), that
> also does hrtimer_rearm, but doesn't get wrapped. I'm thinking that's
> not a problem because at that point the lock stack is empty and all
> that. But perhaps a comment?

Yes, no locks can be held there. And since the chain key only covers
the locks taken since the last change of irq context, a rearm on an
empty lock stack lands in the same chains as the rearm in hardirq
context. In the 46.6 hour boot, the 16 chains starting with
hrtimer_bases.lock were all created in hardirq context, and no process
or softirq context chain starts with it.

For v2 I'd add to the comment above the helper:

 * The rearm on return to user mode needs no such annotation: no locks
 * are held there, so it uses the same lock chains as the rearm in
 * hardirq context.

> That said; I wonder if we want more of irqentry_exit_to_kernel_mode()
> wrapped like this. The schedule_preempt_irq() thing will now also stack
> rq->lock and the like on top of 'random' kernel stacks, rather than
> keeping it in 'empty' hardirq contexts.
>
> Or am I making a mess of things?

Apart from the rearm, the preemption is the only thing in there that
takes locks, and I don't see a way to run it in lockdep's hardirq
context: preempt_schedule_irq() enables interrupts before calling
__schedule(), which trips the lockdep_hardirq_context() check in
lockdep_hardirqs_on_prepare(), and hardirq_context is per CPU, so it
would stay set for whatever task __schedule() switches to.

Nor is the shape specific to the interrupt return: schedule() under a
held sleeping lock stacks rq->lock on that lock the same way. In the
46.6 hour boot, chains with rq->__lock on top of other held locks were
18.1% of the pool, and lockdep_chains does not tell which of them came
from preemption.

-- 
Thanks,
Mikhail
