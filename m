Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8733E4A33EB
	for <linux-rt-devel@lists.linux.dev>; Wed,  1 Jul 2026 13:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782911515; cv=none; b=AasPCFW1aj1FBbdJGjYaSwqOIw6tPxNx+hIAuuaX/t+fypw8kY/iJnbUeftsSXge6GWi18akOJc5ggtW8WX7Os61lmH8Oytu4PqYkbglYkcGns+pOZYj2ulXU25FS4cb9LUTdynqBnh8fS5Xbp7FXoLhsr/DR4mhr+ZcHLH0C14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782911515; c=relaxed/simple;
	bh=1FOwkeW4BsJyymvFsiWTHxpxKFQqtBbzlQrs5/HjSmo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Nctwlay2pLIg3S8JZ/GMXAptxa/aQGPUPk/xvk5+QnUn/OoK5Ob2cqF3SkZDzZO0FNFrYtlsgxd4R5Cv6ZawtS+wCcNzai0440ISZoWZaIko0hOK2C9DjDag8EczQ6xiCxHyW7P5oluVHNxP+lqw0YTn/exAKdHSvt4AjaHSfWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=JRYOc0WM; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=kV9X3vlO; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="JRYOc0WM";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="kV9X3vlO"
Date: Wed, 1 Jul 2026 15:11:50 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1782911512;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=wmH6XkkEqhC2CCWhMYz+7/DE6HeVJPYHN+UjqIA19iU=;
	b=JRYOc0WM8qr0g5htRg4FxyWwGQQVMRbXsDaKLDQmSlRwU+99EXFTr9izt1NFUMQOnApCn2
	rZtY06Zm5Sc/Km5EWx9R0s/8Eu31nkOewvnljDjDnB/+Gmssccn7RC9JMgZfhrWvhLvyMx
	SlgpOdCNgxjuJ33WUqv1Uk43/mAl6FFgXdCHgAR/mxhsbdTe/zVyJ9R34vRJaNa1AkC3L+
	bNzCj8zWWHWY6ZLpb2AeqqN7+BAghll12NugS4oBVRTLM6VCtAd/nZCCxODhuiZhnoc13t
	SjfIl9QVFtEInxgvClpgS7OltpDpzuXw5LiWxydfm2bLdxsWiyI5ebUdxl6rzg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1782911512;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=wmH6XkkEqhC2CCWhMYz+7/DE6HeVJPYHN+UjqIA19iU=;
	b=kV9X3vlOiDFVL5m1bZzgDXLC+lCtstTD2hnUiNaGVyPrxuaGK+SZuD/vRUJgzNYFlYazY3
	oiVGfn+kun9zfzDg==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev
Cc: Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Darren Hart <dvhart@infradead.org>,
	Davidlohr Bueso <dave@stgolabs.net>,
	=?utf-8?B?QW5kcsOp?= Almeida <andrealmeid@igalia.com>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ji'an Zhou <eilaimemedsnaimel@gmail.com>,
	Michael Bommarito <michael.bommarito@gmail.com>
Subject: [PATCH] futex/requeue: Revert "Prevent NULL pointer dereference in
 remove_waiter() on self-deadlock""
Message-ID: <20260701131150.0Ijhq4Dw@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

The commit cited below should not have been merged. It did not fix an
existing problem but it introduced new problems by keeping the pi_state
in state Q_REQUEUE_PI_IN_PROGRESS and leaking it.

Based on the commit description the intention was to handle the case
when task_blocks_on_rt_mutex() returns -EDEADLK and the following
remove_waiter() dereferences the NULL pointer in waiter->task.

That has been already handled by Davidlohr in commit 40a25d59e85b3
("locking/rtmutex: Skip remove_waiter() when waiter is not enqueued")
and requires no further acting.

Revert the commit breaking the "waiter == owner" case again.

Fixes: 74e144274af39 ("futex/requeue: Prevent NULL pointer dereference in remove_waiter() on self-deadlock")
Reported-by: Michael Bommarito <michael.bommarito@gmail.com>
Closes: https://lore.kernel.org/all/20260629020049.2082397-1-michael.bommarito@gmail.com
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 kernel/futex/requeue.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/kernel/futex/requeue.c b/kernel/futex/requeue.c
index 7384672916fb6..79823ad136830 100644
--- a/kernel/futex/requeue.c
+++ b/kernel/futex/requeue.c
@@ -645,12 +645,6 @@ int futex_requeue(u32 __user *uaddr1, unsigned int flags1,
 				continue;
 			}
 
-			/* Self-deadlock: non-top waiter already owns the PI futex. */
-			if (rt_mutex_owner(&pi_state->pi_mutex) == this->task) {
-				ret = -EDEADLK;
-				break;
-			}
-
 			ret = rt_mutex_start_proxy_lock(&pi_state->pi_mutex,
 							this->rt_waiter,
 							this->task);
-- 
2.53.0

