Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793627667;
	b=ibhC/siouLhCkiBn9uvGlVonW9e4XyRXqeG1X4YI5J1GkCXUPp2No2voE0HCi8QMTQiW
	 cP2TgUj5uStneeDHiFy7ztdGU5JR6jDJNhwBpTwYZTmCsSaB03yehmG83S09Vsxpn/F1K
	 J+TZu9JSFnFivizh+oMjcRtGdtNaip/BtRfC9LRQ5+LKLlyk7CQiKovyblFoF4jDd+oa1
	 5lbYwgmaKg5csex6st6HraXSoX8MBZo3TRhwS5J5/aCkLzNcyrSdCvtm0UAxDqOsTSB4l
	 YeSNXLlHFJ6bYhlDoa6MZxFehINUkgJ145LJRM0pRzEybPPo/lqD5hRVdq5HxlsoFyA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793627667;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=lIefd9a9G0gKsYsn6Cn42nkLbuWYrCDoWkU3bV3hULo=;
	b=l11BlPs8b8gJrF0Ga0jh1HxHVoT8ZWl+SGgDGRiaY8C33EP88lUNIBZEQFb8OvZG4rHW
	 Ai+PpUeDspv1P5xDLNyTWw7cKBy8Vbtq1CHJ1Bn6Sc980L76Q9XSabEmm4SImp8MOXxzf
	 4YhcvIv/jlCDzA+SKaOO+tPxn05jEcxgqgg5zfHdBWBR+KzFOvJBsd6oJQGdpwCgZYBTs
	 cxFuXFW0io2+wh8iyUxV3OgSa9rZOtIgsf7LmPMeH1H56PqHZJO+lA6r8ckkMGm6ZLs01
	 62HgWYxKDL3+8g5BREX7/vLwszxhagGd+kLVhlNtBi76/eRZJcaw5Z77QpDki8NS8Bg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="JQ8/fcdl";
	arc=none smtp.remote-ip=209.85.221.53
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF0D860A2612
	for <linux-rt-devel@lists.linux.dev>; Mon,  2 Nov 2026 13:54:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AF0D860A2612
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=JQ8/fcdl
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-48e10a70540so1693593f8f.1
        for <linux-rt-devel@lists.linux.dev>; Mon, 02 Nov 2026 05:54:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793627665; x=1794232465; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=lIefd9a9G0gKsYsn6Cn42nkLbuWYrCDoWkU3bV3hULo=;
        b=JQ8/fcdlCAO9U0q6NSTqQTBMyxlh7wTwLz8VgQu7z5CdOkwsmEBjM3ggMncDlYyTMP
         8MSNVwghtM11ZHXxqpbx1wOGUt5bxNHyUedA+mKP96T/md++ZvmYEVdeWmGAXAfEGgYg
         cgwJIv1f2kwGJs8AK4Q9ZZwhM99gBdcM9A5VAbAjdgXP7rhfNdhjO++nEiBPvqqfplFE
         woYsXnC3/0xPFg3KpAZ8AvfPs8SG6JjRIMFaFba45dUd356RX8023/U0bLjFRavkUFeL
         J14HbT05y3yTDqdITs1ijWZ3y7SOB6R7WylwIr1nnqITH5qN5fZN7SgKK/t42wE+KwLv
         dVhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793627665; x=1794232465;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lIefd9a9G0gKsYsn6Cn42nkLbuWYrCDoWkU3bV3hULo=;
        b=icB6s1rMedKXOt9X5SLY2BYUfghD6BB5B5X8jyROCvdJr2MCSeMrP3n1TDU/gv+93D
         WQaoDXea4UeD22figVSTlMd4kapRaYfW4RPuvk7KiFRRKnbznixK0bKCjWJHY/etoOm+
         ghztyzHSs9B6TIstCk0YbrJGYM28CL0viG/MmQhzI6m2gmSuuHsCkRujItoMwCOc8b3x
         FFsQxKNxxvJC7Pehh5KtasYyJK7y9MonJF7DHLFCwoXG99okQiYPaUhXpddaK+JST5dD
         OyNtyccicjYGzEfEcFoZAZuVp0QFSEvZoOMQsXamp/ymSaE+X4L2AeAXZZW6eWaO6yE7
         QS4w==
X-Forwarded-Encrypted: i=1; AKwUvBzCWE9P9Lj2fIovGzDXRk5D6R8ZYdq+nFa6gN1sbqsFARxfA/P9+9rMtD/in/ov16UlZyQhkVeAb9O8p1DvmA==@lists.linux.dev
X-Gm-Message-State: APuU4Z8QKsYEY5JHCCsyG0ALYsSnAv+Vz6rVAO4SZ691lLxfvyQxK3Yt
	lmfRb5JMI1dCKDgRcpZQmx6Qt9COHVFiHdyoE2YF9NceK2HFJC4VO68k
X-Gm-Gg: AYBFou0syPJiOdehd6sRpDWT/C75db+4Qx3m37UHUpkSBjWf9AeXuVXg3Zbn/FI6eYv
	5rGPSItaqvAM5fT3N7KPScgXNHHGwWjDBBa+quwTiYpL7/0MHoHThl+BtNjkGyvsQbacr2w3p5+
	LMGrbkqpqv14N6OWDJ1j8/hLTsjqJPibl5vQizIu2PYbTgyb/29vgGv6R2P5Ui4jtwVOE92bLyQ
	5b0jfd8HJ/SUALWULLC19ZDRSY1fATFyW3WtlP0lFW88AFpR0E+OSDH+vYyZvJ955HOeeMAar6q
	BrqmCKXcIwaWTzx+nSoXbMVq1p4nHf24JbSLfF/P1DBLFNx2bBE/RAXAQLEohnjqv0S4hbHVcfp
	56rnovdQxp/alzLytqYhq2BtDBePlMDyGFEu25fiVg6ZrJmuvh+4etka9azxLLzzJrWDJaGnJP/
	p22ZLI4UUC4YaR6jAtTcEZbMLzzK8y9Oj1UZmW40rs14nj0/3fdUpqvBXjg0Phq+QpukbBWoYGD
	/c5rYJEp9D7fiBBslluavwTdnWUBkmRCZiKHIB5Bgg13O2wT2x9p5HMZbHF2SRz15WBXYYpj058
	xadeg1+GwEhg1QYPaNxGRLmW0QZx/k6qXWOHhUHEgqSksroJipFoWg2/BQEn1uLndMwW9UM/cvs
	=
X-Received: by 2002:a5d:6f0d:0:b0:48e:19c7:6e23 with SMTP id ffacd0b85a97d-48e73e1be0emr19149710f8f.37.1793627664934;
        Mon, 02 Nov 2026 05:54:24 -0800 (PST)
Received: from andreayoga.wind3.hub ([31.189.68.219])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e71b77f06sm20138662f8f.21.2026.11.02.05.54.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 05:54:24 -0800 (PST)
From: Andrea Parri <parri.andrea@gmail.com>
To: Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>
Cc: Andrea Parri <parri.andrea@gmail.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Aaron Tomlin <atomlin@atomlin.com>,
	linux-rt-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH] sched/deadline: Fix spurious -EPERM for migration-disabled tasks
Date: Mon,  2 Nov 2026 14:54:19 +0100
Message-ID: <20261102135420.244745-1-parri.andrea@gmail.com>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Post: <mailto:linux-rt-devel@lists.linux.dev>
List-Help: <mailto:linux-rt-devel+help@lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
List-Owner: <mailto:linux-rt-devel+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

sched_setattr() can refuse to make a task SCHED_DEADLINE with -EPERM,
even though the task's affinity covers the whole root domain. A retry
can succeed, but the error blames an affinity the task does not have.

__sched_setscheduler() tests p->cpus_ptr, which is not always the task's
affinity. When a task is scheduled out inside a migrate_disable() section,
migrate_disable_switch() points p->cpus_ptr at the current CPU until
migrate_enable(). On PREEMPT_RT every spinlock_t holder is in such a
section, so ordinary kernel work opens the window. Elsewhere, seccomp
filters run in one.

Test p->cpus_mask instead, which keeps the task's affinity and is what
sched_getaffinity() reports. This should be safe because an admitted
task's cpus_mask covers the root domain, so set_cpus_allowed_dl() moves
no bandwidth when migrate_enable() restores p->cpus_ptr.

The following program, run as root, had 553679, 453720 and 424623 of its
1000000 requests refused on three boots of a 4-CPU PREEMPT_RT guest, and
236182, 217174 and 237183 without PREEMPT_RT. With this applied the count
is 0, also with lockdep, and a task pinned to one CPU is still refused:

  #define _GNU_SOURCE
  #include <errno.h>
  #include <linux/filter.h>
  #include <linux/seccomp.h>
  #include <pthread.h>
  #include <stddef.h>
  #include <stdint.h>
  #include <stdio.h>
  #include <sys/syscall.h>
  #include <unistd.h>

  #define REQUESTS 1000000
  #define INSNS 300

  struct attr {
      uint32_t size, policy;
      uint64_t flags;
      int32_t nice;
      uint32_t prio;
      uint64_t runtime, deadline, period;
  };

  static volatile int stop;
  static volatile pid_t target;

  static long set(struct attr a)
  {
      a.size = sizeof(a);
      return syscall(SYS_sched_setattr, target, &a, 0);
  }

  static void *worker(void *arg)
  {
      struct sock_filter f[INSNS + 1];
      struct sock_fprog prog = { .len = INSNS + 1, .filter = f };
      int i;

      /* Reading the arguments keeps seccomp from caching the result */
      for (i = 0; i < INSNS; i++)
          f[i] = (struct sock_filter)
              BPF_STMT(BPF_LD | BPF_W | BPF_ABS,
                       offsetof(struct seccomp_data, args));
      f[INSNS] = (struct sock_filter)
          BPF_STMT(BPF_RET | BPF_K, SECCOMP_RET_ALLOW);
      syscall(SYS_seccomp, SECCOMP_SET_MODE_FILTER, 0, &prog);

      target = syscall(SYS_gettid);
      while (!stop)
          syscall(SYS_getppid);
      return arg;
  }

  static void *hog(void *arg)
  {
      while (!stop)
          ;
      return arg;
  }

  int main(void)
  {
      pthread_t t[9];
      long refused = 0;
      int i;

      pthread_create(&t[0], NULL, worker, NULL);
      while (!target)
          usleep(100);
      for (i = 1; i < 9; i++)
          pthread_create(&t[i], NULL, hog, NULL);
      for (i = 0; i < REQUESTS; i++) {
          /* SCHED_DEADLINE, 2us every 1s */
          if (set((struct attr){ .policy = 6, .runtime = 2000,
                                 .deadline = 1000000000,
                                 .period = 1000000000 }) && errno == EPERM)
              refused++;
          set((struct attr){ .policy = 0 }); /* SCHED_OTHER */
      }
      stop = 1;
      for (i = 0; i < 9; i++)
          pthread_join(t[i], NULL);
      printf("%ld of %d requests refused\n", refused, REQUESTS);
      return 0;
  }

An LLM helped find this bug and write this patch and its test.

Fixes: af449901b84c ("sched: Add migrate_disable()")
Signed-off-by: Andrea Parri <parri.andrea@gmail.com>
Cc: stable@vger.kernel.org
---
This textually conflicts with [1], which rewrites this line and keeps
p->cpus_ptr. Whichever goes second needs to keep &p->cpus_mask.

Also tested on PREEMPT_RT with lockdep by holding a 1ms/10ms reservation
for 3ms at a time, so that tasks admitted while migration-disabled reach
migrate_enable() as SCHED_DEADLINE: no warnings, total_bw unchanged, and
none of 6788 requests refused. Without this patch, 826 of 6645 are refused.

Other !PREEMPT_RT migrate_disable() users were not tested.

[1] https://lore.kernel.org/20261030151307.768523-2-atomlin@atomlin.com/

 kernel/sched/syscalls.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/syscalls.c b/kernel/sched/syscalls.c
index 45a127deeadd9..fb8f332074b88 100644
--- a/kernel/sched/syscalls.c
+++ b/kernel/sched/syscalls.c
@@ -628,7 +628,7 @@ int __sched_setscheduler(struct task_struct *p,
 			 * the entire root_domain to become SCHED_DEADLINE. We
 			 * will also fail if there's no bandwidth available.
 			 */
-			if (!cpumask_subset(span, p->cpus_ptr) ||
+			if (!cpumask_subset(span, &p->cpus_mask) ||
 			    rq->rd->dl_bw.bw == 0) {
 				retval = -EPERM;
 				goto unlock;
-- 
2.53.0

