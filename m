Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B71343BFE49
	for <linux-rt-devel@lists.linux.dev>; Thu,  8 Jan 2026 13:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767878500; cv=none; b=kCnq2N7VtFFeYd1umH1a23dnEMZAXb9SZiu6NXaNeaQsGFpGvLb8ZKc34WY/vUz1Pc7Evw4J/dJo6v7vp3OsiEtwXSL0/LclUpHiWzTl0ejbNER2Y9FOtk7nOHWGlzKRvtFIvLn7kplnE4CAYMyX3P+Rz9SkTS07i0btUbeQDKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767878500; c=relaxed/simple;
	bh=U0qom55Gacebp+UsdiJ+b/O2aMKVG7upFL5zmx5Y39w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cGPpOgjTzrc9qttd/73/VXxRBYVzNOS+F58vFSt1ZrRIXNnS8/3QtnrUZk2Aw/Db79vLphDAAUy6LpvfZlWcFkL1qDPpSSEdw3Iu+/8wiVuzmdVMjQ+i4YhrhInps0YjBnhaIB7rPVuM3Avby7QFPq9mYIbOjAt3o8GiqSbxa7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=XXLSATMl; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="XXLSATMl"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-47797676c62so4291545e9.1
        for <linux-rt-devel@lists.linux.dev>; Thu, 08 Jan 2026 05:21:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1767878494; x=1768483294; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=50StYY8PqE6LiYEa0yWmqhA7lvAJPF7Z/gwReWUz/Us=;
        b=XXLSATMltIofJe17F3yMMtB/shwHYD5BFt5dqGFJHjwR8oqq/Jz6L9ptXGBwio0WRG
         sVlih2F5PMEmHKTUrCZZUDU+6cnBTYiy/cY7+JE4jt9z0Fm8xDK2bCDxPuGykWh7yS/c
         7Mfft6F+MAfXG55g+259bOfYxgX2QXzDFU40tPdWClfeKzEVeN9MB12+eexrP4A9pBgp
         ELZr8ySrDll/bJiUSSr1as3WLI79EBV1A4r5T4mkWjgxtlnGeLruDDXTI6EpYxLa/s3q
         HcNvB9VWxL+QbqOP9tINXaVhPBjCqq6to0LmzBcjecR7eG5dycYlS6WQfSWUX/WJjjcl
         BFXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767878494; x=1768483294;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=50StYY8PqE6LiYEa0yWmqhA7lvAJPF7Z/gwReWUz/Us=;
        b=eHxo5R9rHZZz7QtRMCMJ1VGkpGJDce9ArLBsWnDzq2AHURkg8SRhbqC5W9rk2Nzefc
         iWshsZ1i8XSsVdhLcv8BsPGHBaKZ9gkMCBVpaSfSwvya/JYGzXRpTSLIMJLJV4cn7oIo
         aukIU07xli6Xszn8o9wAqGGUUvGxnBC8TZrYGilfy9XUqov4Mas89UJF/ysDhj7dGKcR
         5DdcrbVZMYCV1l11Ouva766w301+x2cWijZm1dbj5dkVCYbe2VCmvvD1erEpNfJmjO23
         HL/6iV90qgL2zuRz1ryoY0RKRIAknVNwhZ4IMq4n7WY3+hR1WLYaroANHudr0C13VUdv
         dHbA==
X-Forwarded-Encrypted: i=1; AJvYcCVNGcwyGllCXbn87gYzLoSsBCz722EgJQwAGy8mBUg3XXDTzCFe0AOC73ayCzYHrPRNqwzDxPGLVMWvqaLtUQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YyAtxIreFeaSitcFBmhVei9YYdr2fwKuAJiOdYGDT398qQMyWz1
	/izISSN7750h4xmlDb7EM3gKuct142akm3VMzt7ESVUDXTZDvgfRSyphcNIbpdzJYnQ=
X-Gm-Gg: AY/fxX6TQPjgsQS3xBulem/bu6lkhAWQIdQ5VPUFIbnMZ1BMAP292gu8uqa9bx3ayBv
	Tze3hlGhEjRq83t0Woax5dY7oXSq/LSBAc1BUX6XGQO1kVkjuzC0UYmNdIRdV6UgI9gEcBovWsZ
	5YGSJnsPOsOxgmhQqQey8VZMG9P+VinuRpWr+P0SrL+ee1zZixuQRnglco9sUSt9DQHsx0WMMhA
	R5cmjZ2JmfRXEzeiP5C9HjckD8bTpx+3qC4aBFKZy7SkIJ/VtbtsmVhnFPpVOrPZiZiI7CJkhVg
	G2gHHesWOgU0sb7M2OYrr9f7imNSux3/YEPQN8yMixiRbidAaZ5E04hzazvQWCIszxdg7/YVM87
	VykaiCiGOuC+09xSXe6aWxq8EQUE9CKJa85Hfj7ThnK7mUsCYyj2opBU5EZEEuRj8igzLsetFdr
	9kq6HmN8Jf5Q3WJ1nQ/Mcicg0D7Com7WhyqavQLP0XkfqpKE9b+UFepfHj9mRIg6/kCnL4K9GpS
	CSy9A==
X-Google-Smtp-Source: AGHT+IHq/wrpgA3iesPBNelbuVXoRqPd5yt2K8zm7TeHF/SLN+p3ooObhZ0itLQOkHFAeGG4uoF4wQ==
X-Received: by 2002:a05:600c:4453:b0:477:9c9e:ec7e with SMTP id 5b1f17b1804b1-47d84b37ae2mr44763915e9.6.1767878494376;
        Thu, 08 Jan 2026 05:21:34 -0800 (PST)
Received: from localhost (dynamic-2a00-1028-83b8-1e7a-3010-3bd6-8521-caf1.ipv6.o2.cz. [2a00:1028:83b8:1e7a:3010:3bd6:8521:caf1])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d7f6f0e15sm148940005e9.10.2026.01.08.05.21.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jan 2026 05:21:34 -0800 (PST)
From: Petr Tesarik <ptesarik@suse.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev,
	Petr Tesarik <ptesarik@suse.com>
Subject: [PATCH v2 1/1] ring-buffer: Use a housekeeping CPU to wake up waiters
Date: Thu,  8 Jan 2026 14:21:32 +0100
Message-ID: <20260108132132.2473515-1-ptesarik@suse.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Avoid running the wakeup irq_work on an isolated CPU. Since the wakeup can
run on any CPU, let's pick a housekeeping CPU to do the job.

This change reduces additional noise when tracing isolated CPUs. For
example, the following ipi_send_cpu stack trace was captured with
nohz_full=2 on the isolated CPU:

          <idle>-0       [002] d.h4.  1255.379293: ipi_send_cpu: cpu=2 callsite=irq_work_queue+0x2d/0x50 callback=rb_wake_up_waiters+0x0/0x80
          <idle>-0       [002] d.h4.  1255.379329: <stack trace>
 => trace_event_raw_event_ipi_send_cpu
 => __irq_work_queue_local
 => irq_work_queue
 => ring_buffer_unlock_commit
 => trace_buffer_unlock_commit_regs
 => trace_event_buffer_commit
 => trace_event_raw_event_x86_irq_vector
 => __sysvec_apic_timer_interrupt
 => sysvec_apic_timer_interrupt
 => asm_sysvec_apic_timer_interrupt
 => pv_native_safe_halt
 => default_idle
 => default_idle_call
 => do_idle
 => cpu_startup_entry
 => start_secondary
 => common_startup_64

The IRQ work interrupt alone adds considerable noise, but the impact can
get even worse with PREEMPT_RT, because the IRQ work interrupt is then
handled by a separate kernel thread. This requires a task switch and makes
tracing useless for analyzing latency on an isolated CPU.

After applying the patch, the trace is similar, but ipi_send_cpu always
targets a non-isolated CPU.

Unfortunately, irq_work_queue_on() is not NMI-safe. When running in NMI
context, fall back to queuing the irq work on the local CPU.

Signed-off-by: Petr Tesarik <ptesarik@suse.com>
---
 kernel/trace/ring_buffer.c | 24 +++++++++++++++++++++---
 1 file changed, 21 insertions(+), 3 deletions(-)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 41c9f5d079beb..5cf4c6baa2771 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -4,6 +4,7 @@
  *
  * Copyright (C) 2008 Steven Rostedt <srostedt@redhat.com>
  */
+#include <linux/sched/isolation.h>
 #include <linux/trace_recursion.h>
 #include <linux/trace_events.h>
 #include <linux/ring_buffer.h>
@@ -4011,19 +4012,36 @@ static void rb_commit(struct ring_buffer_per_cpu *cpu_buffer)
 	rb_end_commit(cpu_buffer);
 }
 
+static bool
+rb_irq_work_queue(struct rb_irq_work *irq_work)
+{
+	int cpu;
+
+	/* irq_work_queue_on() is not NMI-safe */
+	if (unlikely(in_nmi()))
+		return irq_work_queue(&irq_work->work);
+
+	/*
+	 * If CPU isolation is not active, cpu is always the current
+	 * CPU, and the following is equivallent to irq_work_queue().
+	 */
+	cpu = housekeeping_any_cpu(HK_TYPE_KERNEL_NOISE);
+	return irq_work_queue_on(&irq_work->work, cpu);
+}
+
 static __always_inline void
 rb_wakeups(struct trace_buffer *buffer, struct ring_buffer_per_cpu *cpu_buffer)
 {
 	if (buffer->irq_work.waiters_pending) {
 		buffer->irq_work.waiters_pending = false;
 		/* irq_work_queue() supplies it's own memory barriers */
-		irq_work_queue(&buffer->irq_work.work);
+		rb_irq_work_queue(&buffer->irq_work);
 	}
 
 	if (cpu_buffer->irq_work.waiters_pending) {
 		cpu_buffer->irq_work.waiters_pending = false;
 		/* irq_work_queue() supplies it's own memory barriers */
-		irq_work_queue(&cpu_buffer->irq_work.work);
+		rb_irq_work_queue(&cpu_buffer->irq_work);
 	}
 
 	if (cpu_buffer->last_pages_touch == local_read(&cpu_buffer->pages_touched))
@@ -4043,7 +4061,7 @@ rb_wakeups(struct trace_buffer *buffer, struct ring_buffer_per_cpu *cpu_buffer)
 	cpu_buffer->irq_work.wakeup_full = true;
 	cpu_buffer->irq_work.full_waiters_pending = false;
 	/* irq_work_queue() supplies it's own memory barriers */
-	irq_work_queue(&cpu_buffer->irq_work.work);
+	rb_irq_work_queue(&cpu_buffer->irq_work);
 }
 
 #ifdef CONFIG_RING_BUFFER_RECORD_RECURSION
-- 
2.52.0

