Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6459118FDDE
	for <linux-rt-devel@lists.linux.dev>; Thu,  6 Nov 2025 12:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762430792; cv=none; b=Ck+6iQDUxIVL14fCpKi+7qzinbyh0wyyZ9SKaH0A8LPTiOGN9WlLSw0t/rHBoMmoYjQRFmFSIv4Vzh1tDIRScEh6VmcIQpQCnTZjMFGNCqSlqx1uNYV4dJA1KYh6EijCBsex/eEKI94+Zz78MX3JEzVHTcJzb04h/eIIz0XtI9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762430792; c=relaxed/simple;
	bh=5/etcKxhYAh14kBwnpI4pV96XNg1yo8HQkL3awEJBrU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=dy9TicqkEb7sFCRLIzt87T90Qgbk3R40cxjfqmJt8nXorY0ZOwlz2hNDXzq9y3ab8kqcmvE+p1nTS2vDVU3nDnrJVP8Ys8DNc0lmsFCYWDTALS9no18Jx+nVHiNEhMqc1//6bCWtd4n6PRjvyrbVfODY4DeR8hLtrjvMWyx6Lxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ydariJbN; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=lFJH7puT; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ydariJbN";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="lFJH7puT"
Date: Thu, 6 Nov 2025 13:06:28 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1762430789;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=H3Y7XuO9RuDxNmnBeDxz3YPpwaA/VdSEOi7MouZ4rQ8=;
	b=ydariJbNnTXU2Kw3SBuheI0lmtfvrcSQtBNug8ZwSKNXCa9Iu4yjL8jWGq9e3XFrolJCG8
	sWmoPud6ROh46yebIfM9/x1ysqxoN1pGPmmmNIT5ZhVJDHFSdZgxKvdR11eZow6yFZm476
	Na++DkehGgs9cx+2O+r7pN+pM8IwNenjL565TnFUEMVfSo8c6fNE9Y1n6wNpvytuAnlOZi
	fG0NF8L9XCcqaIUSSzZEU0vgpwWsICMHlNjecgihBkgxfiS9D1xD81j12Sj/bG5wTq9jhi
	sP7LniKLcu/i46nkGrtssk4qcFmC2AkDfNWuUalHgK3U4gz3TkfCIabSSGYHYQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1762430789;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=H3Y7XuO9RuDxNmnBeDxz3YPpwaA/VdSEOi7MouZ4rQ8=;
	b=lFJH7puTdidlWSwMhKfYvyFsElXECOYkEpUnjjc+s3BuDS+8KQ7b0yiiTjwDbSyF4mvXLI
	Axb0pAQSfdH+uHBw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev
Cc: Thomas Gleixner <tglx@linutronix.de>, Oleg Nesterov <oleg@redhat.com>
Subject: [PATCH] debugobjects: Allow to refill the pool before
 SYSTEM_SCHEDULING
Message-ID: <20251106120628.AxWa_Viy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

The pool of free objects is refilled on several occasions such as object
initialisation. On PREEMPT_RT refilling is limited to preemptible
sections due to sleeping locks used by the memory allocator. The system
boots with disabled interrupts so the pool can not be refilled.

If too many objects are initialized and the pool gets empty then
debugobjects disables itself.

Refiling can also happen early in the boot with disabled interrupts as
long as the scheduler is not operational. If the scheduler can not
preempt a task then a sleeping lock can not be contended.

Allow to additionally refill the pool if the scheduler is not
operational.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 lib/debugobjects.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/debugobjects.c b/lib/debugobjects.c
index 7f50c4480a4e3..7017e5c8f32dd 100644
--- a/lib/debugobjects.c
+++ b/lib/debugobjects.c
@@ -714,7 +714,7 @@ static void debug_objects_fill_pool(void)
 	 * raw_spinlock_t are basically the same type and this lock-type
 	 * inversion works just fine.
 	 */
-	if (!IS_ENABLED(CONFIG_PREEMPT_RT) || preemptible()) {
+	if (!IS_ENABLED(CONFIG_PREEMPT_RT) || preemptible() || system_state < SYSTEM_SCHEDULING) {
 		/*
 		 * Annotate away the spinlock_t inside raw_spinlock_t warning
 		 * by temporarily raising the wait-type to WAIT_SLEEP, matching
-- 
2.51.0

