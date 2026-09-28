Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com [209.85.128.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE3E24E7808
	for <linux-rt-devel@lists.linux.dev>; Mon, 28 Sep 2026 17:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790617329; cv=none; b=tuIKKZmnRQG8UMSRSpniudX+DMRzeiba+yUG9Q7lcqXD26fbDcR61+jhzz4LTw6/X9+Fw9mtS1tJmim7WuiIGDDnzliNlVfuODytr07fIlHo2ac3ybJWBxe8G0w0VJUZXEwk51Ski+rRejhaqVSUVTbpVdehRO7ZhmR0x0wmSRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790617329; c=relaxed/simple;
	bh=fqb9OvcrF+1YGNg2ZQpu0FVkmCJMPIgeYZw98qjd2TE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=OOZEoB/JgPUSxejZpVxM4Rm2SBze7dqmdrxgKh+N9gBQb+IZluIvfk5lEj618OirlepxiTYbSAmo2pwmsiDtQ3qnpviKaCY9xginRCIAEuJs4+oIe51ko+4xa4BVMPo2T0jzW1G211PcOdYzuP8zbQZLL6A24ITriYaQXeYyZaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=V+0MwTwu; arc=none smtp.client-ip=209.85.128.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="V+0MwTwu"
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-49ffe48d1dfso23512025e9.3
        for <linux-rt-devel@lists.linux.dev>; Mon, 28 Sep 2026 10:42:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790617323; x=1791222123; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=b5BgLva5vXrAwBl9Y3v1BBOsVeywVgMCKKqE5NVyRxk=;
        b=V+0MwTwu49kq1EDh8pA5A9P9Gahca2oiPSqScKOgOcwt31b0/fYALbxD2AVES56ZE7
         nX5Ksa8yg88qsUo8gulKYvuPn8KwNH/VVm+fDwkDaq4qwXOjaPPlYfv4DW8BqT8eZYXV
         d0ESz+qf2nYLWw7NLJgo/oScbbiDJMThpvPwstRaVuebLqgJe9ZVUoc/lwufS8XcyxPt
         BBtaHEXTQHvDAoHcA+uzEOz1zWtlfo/J7cq11MjDj1TtQu3aKap+guhTUBduDVf+1kaw
         Z0cGvCoaRULIM7ujI7qBy6a4l7xlihxzJzNfQLGLTpqYLJlhbg6Sq6tfYe1LEEszdUBN
         8gqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790617323; x=1791222123;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=b5BgLva5vXrAwBl9Y3v1BBOsVeywVgMCKKqE5NVyRxk=;
        b=KbNTGxPUKDZWjiDOIbe2tO4IWeEpH8+QtB2YakJ9RGdns4ZW9u50upZCn49gPLaKa/
         UXN8FxSBTV3Q3v7Z4FX4ssU8tYv9hvOuxCb/moal3j2O24UVa9zYZb0sPgljiSMKwFcQ
         dvDqkzmBU/0ZYMgbyON6FHxZai108qDEP1n4Re4UMPT7O2ZL3t8aMa95Y6LoqJmJch34
         Ep5HxfzM6IitC5i62b16l5EQV2MqMXXmH6nZgGgONlII0uol/wiD1wSS1XPe63IjCCRU
         rXLJVRPajSLrbbESge6RYNHisuDRvVVR41mZLYbynUAUfQwLpEY3oJhK14FVS9KIoUfa
         vglg==
X-Forwarded-Encrypted: i=1; AKwUvBw38RejG7bXAIf5tkuWTRpClGCOu9HoJXX+JCmMgS58OCxaL+87J5uOAEQ5PC2pjT1OK4niBtGsRqwwpKMqTg==@lists.linux.dev
X-Gm-Message-State: AFuF++ntBQwmdQdkn/Nmx+cYOBTt1ImzOemOrBLglRdB6X/YpPGMJSuW
	42inPL4m65I4teXhOqFX+8laHbiHGYvozLuZ9jLfJlZRUjJ/McRB5cid6maLHFhY3+dsvww7K5r
	OhwP4jF7+fdNRBw==
X-Received: from wmhj21.prod.google.com ([2002:a05:600c:3015:b0:49e:8337:33d])
 (user=smostafa job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:83c4:b0:49f:c331:39e4 with SMTP id 5b1f17b1804b1-49fe66ca101mr236733115e9.7.1790617322864;
 Mon, 28 Sep 2026 10:42:02 -0700 (PDT)
Date: Mon, 28 Sep 2026 17:41:19 +0000
In-Reply-To: <20260928174122.3380703-1-smostafa@google.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260928174122.3380703-1-smostafa@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20260928174122.3380703-13-smostafa@google.com>
Subject: [RFC PATCH 12/15] sched/task_stack: Introduce ARCH_HAS_VARIABLE_STACK_SIZE
From: Mostafa Saleh <smostafa@google.com>
To: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org, 
	linux-hardening@vger.kernel.org, linux-rt-devel@lists.linux.dev
Cc: corbet@lwn.net, skhan@linuxfoundation.org, rdunlap@infradead.org, 
	catalin.marinas@arm.com, will@kernel.org, mark.rutland@arm.com, 
	akpm@linux-foundation.org, urezki@gmail.com, mingo@redhat.com, 
	peterz@infradead.org, juri.lelli@redhat.com, vincent.guittot@linaro.org, 
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com, 
	mgorman@suse.de, vschneid@redhat.com, kprateek.nayak@amd.com, kees@kernel.org, 
	david@kernel.org, ljs@kernel.org, liam@infradead.org, vbabka@kernel.org, 
	rppt@kernel.org, surenb@google.com, mhocko@suse.com, gustavoars@kernel.org, 
	bigeasy@linutronix.de, clrkwllms@kernel.org, 
	Mostafa Saleh <smostafa@google.com>
Content-Type: text/plain; charset="UTF-8"

When CONFIG_ARCH_HAS_VARIABLE_STACK_SIZE is enabled, the kernel stack
may not be fully populated with the THREAD_SIZE virtual area.

Teach task_stack_size() to return the size of the vm area and not a
fixed size.

This propagates to end_of_stack() which makes functions like
stack_not_used() and set_task_stack_end_magic() to use the lowest
valid stack address instead of THREAD_SIZE which would cause data
aborts.

Signed-off-by: Mostafa Saleh <smostafa@google.com>
---
 arch/Kconfig                     | 10 ++++++++++
 include/linux/sched/task_stack.h |  5 +++++
 2 files changed, 15 insertions(+)

diff --git a/arch/Kconfig b/arch/Kconfig
index 45c657772362..d6fa2ccb0599 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -431,6 +431,16 @@ config HAVE_ASM_MODVERSIONS
 	  <asm/asm-prototypes.h> to support the module versioning for symbols
 	  exported from assembly code.
 
+config ARCH_HAS_VARIABLE_STACK_SIZE
+	bool
+	depends on VMAP_STACK
+	depends on !STACK_GROWSUP
+	depends on THREAD_INFO_IN_TASK
+	help
+	  An arch should select this if it supports dynamically configuring the
+	  kernel stack size.
+	  For example the kernel stack size can be from the command line.
+
 config HAVE_REGS_AND_STACK_ACCESS_API
 	bool
 	help
diff --git a/include/linux/sched/task_stack.h b/include/linux/sched/task_stack.h
index 4a808f9c4631..07d73adaecd1 100644
--- a/include/linux/sched/task_stack.h
+++ b/include/linux/sched/task_stack.h
@@ -10,6 +10,7 @@
 #include <linux/magic.h>
 #include <linux/refcount.h>
 #include <linux/kasan.h>
+#include <linux/vmalloc.h>
 
 #ifdef CONFIG_THREAD_INFO_IN_TASK
 
@@ -96,6 +97,10 @@ static inline unsigned long *end_of_stack(const struct task_struct *p)
  */
 static __always_inline unsigned long task_stack_size(const struct task_struct *task)
 {
+#ifdef CONFIG_ARCH_HAS_VARIABLE_STACK_SIZE
+	if (task->stack_vm_area)
+		return task->stack_vm_area->nr_pages * PAGE_SIZE;
+#endif
 	return THREAD_SIZE;
 }
 
-- 
2.56.0.rc1.315.gc6ed9934b7-goog

