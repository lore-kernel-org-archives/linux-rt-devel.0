Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E59193ED5C9
	for <linux-rt-devel@lists.linux.dev>; Tue, 19 May 2026 22:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779229549; cv=none; b=R7QzN64zl9qnrQybjhNUIwE1qgAdbbs/+oabtQfgzYYSsG7+KnRNFB+cD8ZabjfI+wG+JELVrxCwjhI4Fu8EO37beCPaS6fVNXsA/ya1guI8M8ggeEdYFzcX0ZlqO4+H4iYapLqnPHcQuCNbnT9Z0jEMS+zKWpr/WyqOwevMUHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779229549; c=relaxed/simple;
	bh=oibJLxIdOuJ1vEqW4cJ9mljoRJ9W4FXNz8lH/bKq6hY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:content-type; b=OyI0sf7cNeI9johptVbx+bqDvWPh6gG2dE1EFz8LEAzy70ifaMvtyZP1ufeH89r6sYMRJS5NB5Yn+NIDSyomQBE0w/otfU3L6pemnIYvkJ+ku+Io7BjBArJ2i7iEYh9AZwXaxyrwAerP27uXJgX2L13WS7P7Qf/PWXsZwpFw+MQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hUQaNiyg; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hUQaNiyg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779229546;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=vAB44BGqZ+fuUDNGrRoAE7PFPdrgJUI60GqrOp9DD1k=;
	b=hUQaNiygfwjZ8TUn+Z8yI4AmgGJ71vIuTcDriBTAEc2T01KoYvCe/t0EySYh6WKByJQ4av
	+YAXHag0Dk6m/1+sf17p2XX/1tJGa1Mp4Hj3P5WZaf+PFSIZ2wQV98KS9yxhLnWK7IzC7I
	kqcxAziQxPis2rJGxkf+5I8Iy5WP4D0=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-459-AzZW7v-RMy2avixHHnyFbw-1; Tue,
 19 May 2026 18:25:42 -0400
X-MC-Unique: AzZW7v-RMy2avixHHnyFbw-1
X-Mimecast-MFC-AGG-ID: AzZW7v-RMy2avixHHnyFbw_1779229540
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DCCCD1956046;
	Tue, 19 May 2026 22:25:39 +0000 (UTC)
Received: from llong-thinkpadp16vgen1.westford.csb (unknown [10.22.65.90])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 04B5519560A2;
	Tue, 19 May 2026 22:25:36 +0000 (UTC)
From: Waiman Long <longman@redhat.com>
To: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev,
	Waiman Long <longman@redhat.com>
Subject: [PATCH] arm64/entry: Don't disable preemption in debug_exception_enter() with RT kernel
Date: Tue, 19 May 2026 18:25:24 -0400
Message-ID: <20260519222524.886454-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-MFC-PROC-ID: H5A2C7TrAMM97HV5RNCmIPQY-kudhYI8SWHDor5eGrk_1779229540
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Commit d8bb6718c4db ("arm64: Make debug exception handlers visible from
RCU") introduces debug_exception_enter() and debug_exception_exit()
where preemption is explicitly disabled. With a PREEMPT_RT debug kernel,
the following bug report can happen.

  BUG: sleeping function called from invalid context at kernel/locking/spinlock_rt.c:48
  in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 15255, name: gdb_app
  preempt_count: 1, expected: 0
  RCU nest depth: 0, expected: 0
  1 lock held by gdb_app/15255:
  #0: ffff10007f41b7d8 (&sighand->siglock){..}-{3:3}, at: force_sig_info_to_task+0x34/0x130
  Preemption disabled at:
  [<ffff800080081ea8>] debug_exception_enter+0x18/0x70
    :
  Call trace:
  dump_backtrace+0xac/0x130
  show_stack+0x1c/0x24
  dump_stack_lvl+0xa0/0xe0
  dump_stack+0x14/0x2c
  __might_resched+0x178/0x230
  rt_spin_lock+0x58/0x120
  force_sig_info_to_task+0x34/0x130
  force_sig_fault+0x58/0x80
  arm64_force_sig_fault+0x44/0x70
  send_user_sigtrap+0x5c/0xa0
  brk_handler+0x38/0x5c
  do_debug_exception+0x78/0x110
  el0_dbg+0x50/0x1e0
  el0t_64_sync_handler+0x114/0x150
  el0t_64_sync+0x17c/0x180

Fix that by blocking the preempt_disable()/preempt_enable_no_resched()
calls when CONFIG_PREEMPT_RT is enabled.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 arch/arm64/kernel/entry-common.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/kernel/entry-common.c b/arch/arm64/kernel/entry-common.c
index c7a23f7c2212..191441b22b7c 100644
--- a/arch/arm64/kernel/entry-common.c
+++ b/arch/arm64/kernel/entry-common.c
@@ -290,15 +290,17 @@ static __always_inline void fpsimd_syscall_exit(void)
 }
 
 /*
- * In debug exception context, we explicitly disable preemption despite
- * having interrupts disabled.
+ * In debug exception context, we explicitly disable preemption except for
+ * PREEMPT_RT kernel as rt_spin_lock() can be called.
+ *
  * This serves two purposes: it makes it much less likely that we would
  * accidentally schedule in exception context and it will force a warning
  * if we somehow manage to schedule by accident.
  */
 static void debug_exception_enter(struct pt_regs *regs)
 {
-	preempt_disable();
+	if (!IS_ENABLED(CONFIG_PREEMPT_RT))
+		preempt_disable();
 
 	/* This code is a bit fragile.  Test it. */
 	RCU_LOCKDEP_WARN(!rcu_is_watching(), "exception_enter didn't work");
@@ -307,7 +309,8 @@ NOKPROBE_SYMBOL(debug_exception_enter);
 
 static void debug_exception_exit(struct pt_regs *regs)
 {
-	preempt_enable_no_resched();
+	if (!IS_ENABLED(CONFIG_PREEMPT_RT))
+		preempt_enable_no_resched();
 }
 NOKPROBE_SYMBOL(debug_exception_exit);
 
-- 
2.54.0

