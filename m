Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2E7930C617
	for <linux-rt-devel@lists.linux.dev>; Tue,  6 Jan 2026 09:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767690655; cv=none; b=YXmptTcNlf1nU/e/aYBsYqzOAH/x3BHftN2UuGFr6C+fRwUiVPWaO8sd2v4DCD4rdcU6HElR4QgZyEm3dMEwOoW01BVVL2F5+IHct+q/Qk3PmV8BtWXFSduOddYo/GA1jrdKl8/JbEr0q17FV8E5eW5AlmGQU360voxhQ4iEQxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767690655; c=relaxed/simple;
	bh=/YCcFx9fK4X6vkZb2r65rdSswmVUHKmtCmFNEnHBgpk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gmvfvno4m6Po7Ec7TaFPVYnZT84kd0u3diOrc266JTZRckgOCahUORrqthX7RXuG6A+NC2WWTYJd89zP5OMf4/ZDzU0CCawfq3zTXJb941wksyLS2b27lFxJ7FbRHfKecdnVwqEGEKK3oPPWYkdIIhND9DVmJD2bC87uHFd/WRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=MT73i4nj; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="MT73i4nj"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-42fb8aa0c3eso19711f8f.3
        for <linux-rt-devel@lists.linux.dev>; Tue, 06 Jan 2026 01:10:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1767690651; x=1768295451; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Pq+ApTTyCsVEAV3Mh5mFQtTRHKhX3x1YwcZ2qcrzmns=;
        b=MT73i4nj7PPZTrMdtC8jlDG+UmPy13+BQh4udC/QCeks591glOLiWKEUunibOULI+Y
         wcqLgeKTyKLiLYERkYFluTSK3cQSuC+Gs2nxs8SiiAMaVmCoHUlLgMtwq3warQmi/C6H
         e/F7DUrc+7YU9QEPY7jHkdn0dwibXRsBm0OByIoUVkHwL+MLFDq2HCtjAT3WS/fdN1BH
         2/epI450l2GqbUMK0UB4/2fTx9tAabrvLrYiS5zO52jvMG/QLTtTyUNwYOdYtttC56US
         TDx1JCVz840w/W7/+3g03yNuCSTdrrIVeQUwwQVb0kMz8M2Tuqz2LY41XQXugztiLvaV
         o3Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767690651; x=1768295451;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pq+ApTTyCsVEAV3Mh5mFQtTRHKhX3x1YwcZ2qcrzmns=;
        b=MVt+abxI3IgOru+KH2hd/Sch0xVLR0vJA/m5z2exBu90EH3sRf5e4wgFSj07VsIuKC
         vV2Uwwm86TNVnRbZ8+vA1wMenw6QUP6hQq8VM5CRgS9Y2YDwS02UGovlDFrXlQ/28Jym
         EKH4ge43tMrPJ/cVNR8HGJdnjbNvA4rLyPYVc1MaCZpqlOP82gtVAczxLc3uR5YvtnSR
         xBEw4Nyl5DTvqs4hWZbSb4s2yz4BHpPzmfZIeGfqzfBjTWaNHTbb54tqCJhCZv4IeeLd
         rO40aa4dwy4b6xMTWA4sU2Z4xtSlz5aRaTOWSod90RW7L2jeyePnwAWY6DERDDlVQER5
         9+jg==
X-Forwarded-Encrypted: i=1; AJvYcCXg5z/fF8vZDzUdGioWzIyMKFzf38LZDvL0HSVU88Tmfhdg3TlqZ/zGwiZY+YthDBKumDKdxy/PQWj8HzbylA==@lists.linux.dev
X-Gm-Message-State: AOJu0YzANcy2v/3RFGvSsY5zhMoQXTlo7qINNEDPSD7zJY/+z/I9PgT0
	1bBQvqJ7umZt0EtNHSd2LeiP2QaGd9O6DHbd5U+U0uv/wbGYCychYBrQbgQLkVM0/vw=
X-Gm-Gg: AY/fxX4vgOMEftUJmLfpqasYRI/B/ET13jtZFAcC8vS54taSBkvru6VSRNoZdxKOHmk
	piQICiCkd3Ux4tcxhF6xmWZNDMa4cVh6xT585sZ2S4r6xddDegK54kI2QE8WtLGVl9Ku37ESZhW
	5e0eyb4oi/aejE80TnjhzSH+avQYCWRoRW+Wg0m2Obn44bcMmUuJ5S8NKmqOJVRLcn2K6Yyk0yw
	SidX6BY8dAedWek1I2JiiMWODKWeDOc2PyexGDv2+ANXoSspaj+Et4BbMTiegCjzacKrQft1JEv
	VSqotvA8YcOxnx8xg1jMH4fVtJI8ejzOkN8EayHp262ZFI2W9ibJ7l6TiI3Ar4BUErR74oniVKk
	fDFcmCSChxfFRBb2K+J8xNLlvj00zygzIRY2PQFSxeZ8i3iPbuYai9pN4/xYT549rv3nvGffzix
	GkjLjb57qr/3t/OwlRQoaeDuJ9i9zoMTVE
X-Google-Smtp-Source: AGHT+IHcR0555ohsRlawXEi+d03mZxbXk81vFyB7IVZMXoTi2fYsuDrx0nGHYaHbE3bLvtvjD41pxQ==
X-Received: by 2002:a05:600c:4753:b0:477:9dd9:ac57 with SMTP id 5b1f17b1804b1-47d7f01502cmr13171025e9.0.1767690651096;
        Tue, 06 Jan 2026 01:10:51 -0800 (PST)
Received: from localhost (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d7f653c78sm33651745e9.11.2026.01.06.01.10.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jan 2026 01:10:50 -0800 (PST)
From: Petr Tesarik <ptesarik@suse.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev,
	Petr Tesarik <ptesarik@suse.com>
Subject: [PATCH] ring-buffer: Use a housekeeping CPU to wake up waiters
Date: Tue,  6 Jan 2026 10:10:39 +0100
Message-ID: <20260106091039.2012108-1-ptesarik@suse.com>
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

Signed-off-by: Petr Tesarik <ptesarik@suse.com>
---
 kernel/trace/ring_buffer.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 41c9f5d079beb..ed9160599091d 100644
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
@@ -4011,19 +4012,31 @@ static void rb_commit(struct ring_buffer_per_cpu *cpu_buffer)
 	rb_end_commit(cpu_buffer);
 }
 
+static inline bool
+rb_irq_work_queue(struct rb_irq_work *irq_work)
+{
+	int cpu = housekeeping_any_cpu(HK_TYPE_KERNEL_NOISE);
+
+	/*
+	 * If CPU isolation is not active, cpu is always the current
+	 * CPU, and the following is equivallent to irq_work_queue().
+	 */
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
@@ -4043,7 +4056,7 @@ rb_wakeups(struct trace_buffer *buffer, struct ring_buffer_per_cpu *cpu_buffer)
 	cpu_buffer->irq_work.wakeup_full = true;
 	cpu_buffer->irq_work.full_waiters_pending = false;
 	/* irq_work_queue() supplies it's own memory barriers */
-	irq_work_queue(&cpu_buffer->irq_work.work);
+	rb_irq_work_queue(&cpu_buffer->irq_work);
 }
 
 #ifdef CONFIG_RING_BUFFER_RECORD_RECURSION
-- 
2.52.0

