Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com [209.85.128.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 204AC4E3EF6
	for <linux-rt-devel@lists.linux.dev>; Mon, 28 Sep 2026 17:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790617318; cv=none; b=MIyzz0zX9MIK1x44Q9xhOJEv+GY+m48QDqlGuhfssHmMqqjBmO84uYUSMXfVcNkstO293a2kAncTgb/HFIyGFXfSFfmUL5CiDNsQLoxp0wFswVupjIpNMCoZ+II+mf7UWJEZ4a+ZPXIY7Och/3fiFCJUcwBfZudb+r5mpaxbqtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790617318; c=relaxed/simple;
	bh=92UIyLy7GtKPROYl2Br7ZP/exzYZtpSXAMuolLK+K3g=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=cdkglu0LA3hEp+AGY/giGiNrp8VJf6zqOj/mzDBO9rLbr5K5wEL41xY3d6obcO59XJ2hUDfKjT0LKKUmHrXxoqoIpZC08SQ6sIXW+3LgOTV+KOR4+iZAHsb/qfGKjmvL0mnjydCfrOllH7GMKg8l5zY8GdiXXdhWDqKHLt/P2HU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=X32oy1os; arc=none smtp.client-ip=209.85.128.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="X32oy1os"
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-49ffe287240so16673285e9.2
        for <linux-rt-devel@lists.linux.dev>; Mon, 28 Sep 2026 10:41:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790617313; x=1791222113; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PLizaoNOz6hydwy+EEJKSgP0D8TbobflQ2CjOBToA3A=;
        b=X32oy1os5AlpOGX/LON4yGiF9Kg2Ev2whB20oWrgzD+5yP9cM65aEDuHZjh+azksGA
         sgEgh9zn8VOLVAgpsET4+AdmjqdsZz3fPdw+OnjtWs0llhVnIhXnh1cRKCSYMPwnwYFd
         Y6GD94N3ceedfRoERJO/SOn/k/+8mQAoNhzJVT/kllYXlfnR7ZmSs+5PPupNvHxpHhqG
         moZcdV0gT6PifqFCxnG/jfeWHmnv0+khIBcXum2iMNmvP6h1RRCdKqcbbuYeQHky/W7M
         4xdhM7+4sB5+HEopNr39cOGDl2iv73lST9kzzLXMUum2lyv2Pnj7TjzhnJ6R2oRtJfi3
         uxUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790617313; x=1791222113;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PLizaoNOz6hydwy+EEJKSgP0D8TbobflQ2CjOBToA3A=;
        b=JKpzfLfkW10IMUecvRPF7lPdwKQQz6DjNIPPhCh2VVMVWzdczFwcY6miPZWoR3Xp5p
         ecefU9i4XRn9ggEh8HTmS9gvHnBCbZY+QGCdJ3qY+0N3nmUN0UVfiOebcvUoxpxiVpFB
         EuUCuaX+/3prZqyIPB3SZp2RNIdMAvE3gzqm8ATCT2mC1GuLk/uYEjcgXRx+8c/dg2kh
         p1+qr+6oXnnvVSydzXWOBfU/QhNsxjg7V5NbIuITdBv2ksNCvOfNj3gaCIvX1dulzeWu
         bPsm8iMqKudVBt7dI06ZE4fpRZX3ayaC90cXzMmwca2hqfq6X8iyAvGgC+Uoy+Gv6xCr
         Conw==
X-Forwarded-Encrypted: i=1; AKwUvBw1EgwyT9db6iB+5FDBGBauQJgDr8vT6dWVDnI1UKthuzN34dcAOdDT46fOLWn/JFfXd3Cy5rXIheaFytsr+A==@lists.linux.dev
X-Gm-Message-State: AFuF++n6ztZvhH/8PBYaVVx9A98h1xx8xz6jhGiZqHR99r7TCvHhkDh0
	m0vOymI1FYLMlKZJVQ6fsqqUTp1r0X3irKg9Z3uJtMpq2nTLOXo6nfArJ7a/MBeCKYfJio5AJ5X
	JFCvEfhetOUiCEg==
X-Received: from wmnb21.prod.google.com ([2002:a05:600c:6d5:b0:49f:e43f:afd1])
 (user=smostafa job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:83c5:b0:499:bf0e:95c8 with SMTP id 5b1f17b1804b1-49fe66c8623mr231494305e9.1.1790617313066;
 Mon, 28 Sep 2026 10:41:53 -0700 (PDT)
Date: Mon, 28 Sep 2026 17:41:12 +0000
In-Reply-To: <20260928174122.3380703-1-smostafa@google.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260928174122.3380703-1-smostafa@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20260928174122.3380703-6-smostafa@google.com>
Subject: [RFC PATCH 05/15] sched/task_stack: Add helpers for stack high/low
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

Soon, memory mapped for a kernel stack can be less than THREAD_SIZE.
However, many parts of the kernel assume it is.
Add new helpers for the kernel stack that can be called regardless of
CONFIG_STACK_GROWSUP or the kernel stack size:
- task_stack_low(): Lowest usable address on the stack.
- task_stack_high(): Highest usable address on the stack.
- task_stack_size(): The size of a task kernel stack, it is still
  THREAD_SIZE at the moment but that will change soon.

Signed-off-by: Mostafa Saleh <smostafa@google.com>
---
 include/linux/sched/task_stack.h | 56 ++++++++++++++++++++++++++++++--
 1 file changed, 53 insertions(+), 3 deletions(-)

diff --git a/include/linux/sched/task_stack.h b/include/linux/sched/task_stack.h
index 1fab7e9043a3..4a808f9c4631 100644
--- a/include/linux/sched/task_stack.h
+++ b/include/linux/sched/task_stack.h
@@ -13,6 +13,8 @@
 
 #ifdef CONFIG_THREAD_INFO_IN_TASK
 
+static __always_inline void *task_stack_low(const struct task_struct *task);
+
 /*
  * When accessing the stack of a non-current task that might exit, use
  * try_get_task_stack() instead.  task_stack_page will return a pointer
@@ -30,7 +32,7 @@ static __always_inline unsigned long *end_of_stack(const struct task_struct *tas
 #ifdef CONFIG_STACK_GROWSUP
 	return (unsigned long *)((unsigned long)task->stack + THREAD_SIZE) - 1;
 #else
-	return task->stack;
+	return task_stack_low(task);
 #endif
 }
 
@@ -64,6 +66,53 @@ static inline unsigned long *end_of_stack(const struct task_struct *p)
 
 #endif
 
+/*
+ * Kernel stack layout, higher addresses at the top. task_stack_page() is
+ * the start of the THREAD_SIZE area, task_stack_low() => task_stack_high()
+ * is the usable stack.
+ *
+ * Case 1) Stack grows down: Only the top task_stack_size() bytes are mapped:
+ *
+ *   +-------------+ <- task_stack_high() = task_stack_page() + THREAD_SIZE
+ *   |    stack    |
+ *   |      |      |    task_stack_size() bytes
+ *   |      v      |
+ *   +-------------+ <- task_stack_low() = end_of_stack() (*)
+ *   |   may be    |
+ *   |  unmapped   |    THREAD_SIZE - task_stack_size() bytes
+ *   +-------------+ <- task_stack_page()
+ *
+ *   (*) Depending on CONFIG_THREAD_INFO_IN_TASK, end_of_stack() might be just
+ *       above it.
+ *
+ * Case 2) Stack grows up (CONFIG_STACK_GROWSUP): The whole area is used.
+ * No support for partially mapped stacks.
+ *
+ *   +-------------+ <- task_stack_high() = task_stack_page() + THREAD_SIZE
+ *   |      ^      |    end_of_stack() is the last unsigned long below it
+ *   |      |      |
+ *   |    stack    |    THREAD_SIZE bytes
+ *   +-------------+ <- task_stack_low() = task_stack_page()
+ */
+static __always_inline unsigned long task_stack_size(const struct task_struct *task)
+{
+	return THREAD_SIZE;
+}
+
+static __always_inline void *task_stack_low(const struct task_struct *task)
+{
+#if defined(CONFIG_STACK_GROWSUP)
+	return task_stack_page(task);
+#else
+	return task_stack_page(task) + THREAD_SIZE - task_stack_size(task);
+#endif
+}
+
+static __always_inline void *task_stack_high(const struct task_struct *task)
+{
+	return task_stack_low(task) + task_stack_size(task);
+}
+
 #ifdef CONFIG_THREAD_INFO_IN_TASK
 static inline void *try_get_task_stack(struct task_struct *tsk)
 {
@@ -88,10 +137,11 @@ void exit_task_stack_account(struct task_struct *tsk);
 
 static inline int object_is_on_stack(const void *obj)
 {
-	void *stack = task_stack_page(current);
+	void *stack_base = task_stack_low(current);
+	void *stack_end = task_stack_high(current);
 
 	obj = kasan_reset_tag(obj);
-	return (obj >= stack) && (obj < (stack + THREAD_SIZE));
+	return (obj >= stack_base) && (obj < stack_end);
 }
 
 extern void thread_stack_cache_init(void);
-- 
2.56.0.rc1.315.gc6ed9934b7-goog

