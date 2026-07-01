Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DBA44266BA;
	Wed,  1 Jul 2026 15:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782919510; cv=none; b=ogR9EfgDMvhdAJlGnNWN1v9b6lA4H+IPw1PloVCAsmwn4suADHubvhXRV6ad/8GZbuj25wjHxl1GLHSgTWrHkWNrpGJqKtGyu46lNEkREqBb1iL87o6jinPKmSReyIQ3eDgwK9JjpnA/yhUvpVwe4G+XvIf5dibJUZ69CZkAZvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782919510; c=relaxed/simple;
	bh=6f62nyBP09JOVXi5DCb2z5K8ax0Wxn7LA+UlQKbDeCQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=BVeiW379UaL1nq0LAWSxb8UdLhoaHkk5PkkX0I3AlqwyycYTIBx/u5mZgxgFls02JriQwmLcSeN3e9AppbOYzTUL7E7rc5rHML7OKdN5PI9dBA0+Erw4DyteTuIFaWinssbRuoKuJiV7nFBlsZVgQC1bP/5LzjE4XdLjTNWZNBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U9BnszoZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U9BnszoZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55D0A1F000E9;
	Wed,  1 Jul 2026 15:25:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782919509;
	bh=47Ao+f2xgNiLVzqLR+oO+cFylnrCPHbI81+HvhQal+o=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=U9BnszoZyTDwhk/4YUew7N7CXBeETuRiC0RtOmY2unzpxJ63kPABsFcVnIyRm67ty
	 p1caS657ldMcIqR6SIjbEBVBmcnUahsJLk74GqYt1ciL0fDC+ROuZ69eNCZbIox8sG
	 KkOt4vfdXq5aTnhCP3o9RBGxMiLgtuwRgHfQX+FTG221kHpUEVOD564X2d90VuL6Gp
	 +EhmES7r48kZfbahCNf5LOecRCRsjq9otmC3ziD90NDJJDgd2aBf/vsDT1/O0OFVy+
	 /wBi5iZBwkCUpVDTDtoEDR41f8SsnKDJs/7P10IePYsQc8SCcX3eogItTLGkJfD5/t
	 Sd3NsjkDCuOIA==
From: Thomas Gleixner <tglx@kernel.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Darren Hart <dvhart@infradead.org>, Davidlohr Bueso <dave@stgolabs.net>,
 =?utf-8?Q?Andr=C3=A9?= Almeida <andrealmeid@igalia.com>, Clark Williams
 <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, Ji'an Zhou
 <eilaimemedsnaimel@gmail.com>, Michael Bommarito
 <michael.bommarito@gmail.com>
Subject: Re: [PATCH] futex/requeue: Revert "Prevent NULL pointer dereference
 in remove_waiter() on self-deadlock""
In-Reply-To: <20260701131150.0Ijhq4Dw@linutronix.de>
References: <20260701131150.0Ijhq4Dw@linutronix.de>
Date: Wed, 01 Jul 2026 17:25:05 +0200
Message-ID: <87h5mipwa6.ffs@fw13>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, Jul 01 2026 at 15:11, Sebastian Andrzej Siewior wrote:
> The commit cited below should not have been merged. It did not fix an
> existing problem but it introduced new problems by keeping the pi_state
> in state Q_REQUEUE_PI_IN_PROGRESS and leaking it.
>
> Based on the commit description the intention was to handle the case
> when task_blocks_on_rt_mutex() returns -EDEADLK and the following
> remove_waiter() dereferences the NULL pointer in waiter->task.
>
> That has been already handled by Davidlohr in commit 40a25d59e85b3
> ("locking/rtmutex: Skip remove_waiter() when waiter is not enqueued")
> and requires no further acting.

No. If the self deadlock is obvious, then this should not even go into
the proxy lock code. I clearly failed to notice the leak problem, but
reverting it and relying on some magic down the road to handle it
correctly is not really solid.

The below should fix it properly.

---
--- a/kernel/futex/requeue.c
+++ b/kernel/futex/requeue.c
@@ -646,15 +646,13 @@ int futex_requeue(u32 __user *uaddr1, un
 			}
 
 			/* Self-deadlock: non-top waiter already owns the PI futex. */
-			if (rt_mutex_owner(&pi_state->pi_mutex) == this->task) {
+			if (likely(rt_mutex_owner(&pi_state->pi_mutex) != this->task)) {
+				ret = rt_mutex_start_proxy_lock(&pi_state->pi_mutex,
+								this->rt_waiter, this->task);
+			} else {
 				ret = -EDEADLK;
-				break;
 			}
 
-			ret = rt_mutex_start_proxy_lock(&pi_state->pi_mutex,
-							this->rt_waiter,
-							this->task);
-
 			if (ret == 1) {
 				/*
 				 * We got the lock. We do neither drop the refcount
